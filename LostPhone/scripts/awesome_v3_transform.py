"""Transform DESIGN-swiftui.md Swift blocks into prefixed, compilable showroom code."""

from __future__ import annotations

import re
from typing import Sequence

SWIFT_KEYWORDS = frozenset(
    {
        "View",
        "Configuration",
        "String",
        "Int",
        "Double",
        "CGFloat",
        "Bool",
        "UUID",
        "URL",
        "Image",
        "Color",
        "Font",
        "Button",
        "Text",
        "Task",
        "Gradient",
        "Profile",
        "Identifiable",
        "Hashable",
        "Codable",
        "Sendable",
        "some",
        "any",
        "Self",
        "true",
        "false",
        "nil",
        "Variant",
        "VoteState",
        "ReadState",
        "State",
        "Binding",
        "Published",
        "ObservableObject",
        "Environment",
        "PreviewProvider",
        "LinearGradient",
        "AngularGradient",
        "RadialGradient",
        "Capsule",
        "Circle",
        "Rectangle",
        "RoundedRectangle",
        "UnevenRoundedRectangle",
        "ScrollView",
        "LazyVStack",
        "LazyHStack",
        "NavigationStack",
        "TabView",
        "VStack",
        "HStack",
        "ZStack",
        "Spacer",
        "ForEach",
        "GridItem",
        "LazyVGrid",
        "LazyHGrid",
        "Divider",
        "Section",
        "List",
        "Label",
        "ContentUnavailableView",
    }
)


def extract_swift_blocks(md: str) -> list[str]:
    blocks: list[str] = []
    in_swift = False
    in_motion = False
    buf: list[str] = []
    for line in md.splitlines():
        if line.startswith("## "):
            low = line.lower()
            in_motion = "motion" in low or "haptic" in low
        if line.strip().startswith("```swift"):
            in_swift = True
            buf = []
            continue
        if in_swift and line.strip() == "```":
            in_swift = False
            if buf:
                code = "\n".join(buf)
                if in_motion and not re.search(r"\bstruct\b", code):
                    pass  # skip pure motion snippets
                else:
                    if in_motion:
                        code = strip_leading_orphan_modifiers(code)
                    blocks.append(code)
            continue
        if in_swift:
            buf.append(line)
    return blocks


def strip_leading_orphan_modifiers(code: str) -> str:
    """Retire les lignes motion (.sensoryFeedback, etc.) avant le premier type Swift."""
    lines = code.splitlines()
    while lines:
        s = lines[0].strip()
        if not s:
            lines.pop(0)
            continue
        if s.startswith("//") or (s.startswith(".") and "struct " not in s and "enum " not in s):
            lines.pop(0)
            continue
        break
    return "\n".join(lines)


def block_is_useful(code: str) -> bool:
    if "import AVKit" in code or "AVPlayer" in code or "VideoPlayer" in code:
        return False
    if "import Lottie" in code or "LottieView" in code:
        return False
    if not re.search(r"\b(struct|enum|class|extension)\s+", code):
        return False
    if re.search(r"\b(struct|enum|class|extension)\s+", code):
        return True
    return False


def _font_custom_to_system(line: str) -> str:
    if "static let" not in line and "static var" not in line:
        return line
    size_m = re.search(r"size:\s*(\d+(?:\.\d+)?)", line)
    weight_m = re.search(r"weight:\s*(\.\w+)", line)
    size = size_m.group(1) if size_m else "17"
    weight = weight_m.group(1) if weight_m else ".regular"
    name_m = re.match(r"(\s*static (?:let|var) \w+\s*=).*", line)
    if name_m:
        return f"{name_m.group(1)} Font.system(size: {size}, weight: {weight})"
    return line


def transform_color_extension(code: str, tokens_name: str) -> tuple[str, list[str]]:
    token_names: list[str] = []
    out: list[str] = []
    in_ext = False
    for line in code.splitlines():
        if "extension Color" in line and "LinearGradient" not in line:
            in_ext = True
            out.append(f"private enum {tokens_name} {{")
            continue
        if in_ext and line.strip() == "}":
            out.append("}")
            in_ext = False
            continue
        if in_ext:
            m = re.match(r"\s*static let (\w+)", line)
            if m:
                token_names.append(m.group(1))
            out.append(line)
        else:
            out.append(line)
    return "\n".join(out), token_names


def transform_font_extension(code: str, fonts_name: str) -> tuple[str, list[str]]:
    font_names: list[str] = []
    out: list[str] = []
    in_ext = False
    for line in code.splitlines():
        if "extension Font" in line:
            in_ext = True
            out.append(f"private enum {fonts_name} {{")
            continue
        if in_ext and line.strip() == "}" and not line.startswith("    }"):
            # closing brace of extension — may be ambiguous; use depth
            pass
        if in_ext:
            if line.strip() == "}" and line.startswith("}"):
                out.append("}")
                in_ext = False
                continue
            line = _font_custom_to_system(line)
            m = re.match(r"\s*static let (\w+)", line)
            if m:
                font_names.append(m.group(1))
            out.append(line)
        else:
            out.append(line)
    # Fix: if still in_ext, close enum
    if in_ext:
        out.append("}")
    return "\n".join(out), font_names


def transform_linear_gradient_extension(code: str, grad_name: str) -> str:
    if "extension LinearGradient" not in code:
        return code
    return code.replace("extension LinearGradient", f"private enum {grad_name}", 1)


def collect_type_names(codes: Sequence[str]) -> list[str]:
    names: set[str] = set()
    for code in codes:
        for m in re.finditer(r"\b(?:struct|enum|class)\s+(\w+)", code):
            n = m.group(1)
            if n not in SWIFT_KEYWORDS:
                names.add(n)
    return sorted(names, key=len, reverse=True)


def build_type_map(type_names: Sequence[str], prefix: str) -> dict[str, str]:
    mapping: dict[str, str] = {}
    for name in type_names:
        if name.startswith(prefix):
            continue
        mapping[name] = f"{prefix}{name}"
    return mapping


def apply_type_renames(code: str, type_map: dict[str, str]) -> str:
    for old, new in sorted(type_map.items(), key=lambda x: -len(x[0])):
        code = re.sub(rf"\b{re.escape(old)}\b", new, code)
    return code


def apply_token_and_font_refs(
    code: str,
    token_names: Sequence[str],
    font_names: Sequence[str],
    tokens_enum: str,
    fonts_enum: str,
) -> str:
    for f in font_names:
        code = re.sub(rf"\.font\(\.{re.escape(f)}\)", f".font({fonts_enum}.{f})", code)
        code = re.sub(rf"Font\.{re.escape(f)}\b", f"{fonts_enum}.{f}", code)
    for t in token_names:
        if t in font_names:
            continue
        code = re.sub(rf"\bColor\.{re.escape(t)}\b", f"{tokens_enum}.{t}", code)
        code = re.sub(rf"\.foregroundStyle\(\.{re.escape(t)}\)", f".foregroundStyle({tokens_enum}.{t})", code)
        code = re.sub(rf"\.fill\(\.{re.escape(t)}\)", f".fill({tokens_enum}.{t})", code)
        code = re.sub(rf"\.stroke\(\.{re.escape(t)}\)", f".stroke({tokens_enum}.{t})", code)
        code = re.sub(rf"\.strokeBorder\(\.{re.escape(t)}\)", f".strokeBorder({tokens_enum}.{t})", code)
    return code


def fix_gradient_token_refs(code: str, token_names: Sequence[str], tokens_enum: str, font_names: Sequence[str]) -> str:
    skip = set(font_names)
    for t in sorted(set(token_names), key=len, reverse=True):
        if t in skip:
            continue
        code = re.sub(rf"(?<!\w)\.{re.escape(t)}\b(?!\()", f"{tokens_enum}.{t}", code)
    return code


def fix_linear_gradient_refs(code: str, grad_enum: str) -> str:
    if grad_enum not in code:
        return code
    grad_block = code.split(f"private enum {grad_enum}", 1)[1].split("\nprivate ", 1)[0]
    grad_names = re.findall(r"static (?:let|var) (\w+)", grad_block)
    for g in grad_names:
        code = re.sub(rf"\bLinearGradient\.{re.escape(g)}\b", f"{grad_enum}.{g}", code)
    return code


def strip_orphan_motion_lines(code: str) -> str:
    """Supprime les fragments motion Spectr (section 5) hors contexte View."""
    out: list[str] = []
    for line in code.splitlines():
        s = line.strip()
        if re.match(r"^\.sensoryFeedback\(", s):
            continue
        if re.match(r"^\.scaleEffect\(", s):
            continue
        if re.match(r"^\.animation\(", s):
            continue
        if re.match(r"^\.delay\(", s):
            continue
        if re.match(r"^// (Add to cart|Cart badge|Add-to-cart|Mic record|Read receipt)", s, re.I):
            continue
        out.append(line)
    return "\n".join(out)


def _extract_braced_block(code: str, start: int) -> tuple[str, int]:
    """Return (inner_body, end_index) for block opening at start (at 'private enum' or 'extension')."""
    i = code.find("{", start)
    if i < 0:
        return "", start
    depth = 1
    j = i + 1
    while j < len(code) and depth:
        if code[j] == "{":
            depth += 1
        elif code[j] == "}":
            depth -= 1
        j += 1
    return code[i + 1 : j - 1], j


def merge_duplicate_private_enums(code: str, enum_name: str) -> str:
    """Fusionne plusieurs `private enum Foo` identiques (specs multi-blocs)."""
    marker = f"private enum {enum_name}"
    if code.count(marker) <= 1:
        return code

    static_lines: dict[str, str] = {}
    other_lines: list[str] = []
    spans: list[tuple[int, int]] = []

    search_from = 0
    while True:
        idx = code.find(marker, search_from)
        if idx < 0:
            break
        body, end = _extract_braced_block(code, idx)
        spans.append((idx, end))
        for line in body.splitlines():
            stripped = line.strip()
            if not stripped or stripped.startswith("//"):
                continue
            m = re.match(r"static let (\w+)", stripped)
            if m:
                static_lines.setdefault(m.group(1), line)
            elif stripped not in other_lines:
                other_lines.append(line)
        search_from = end

    merged_inner = "\n".join(list(static_lines.values()) + other_lines)
    merged_block = f"private enum {enum_name} {{\n{merged_inner}\n}}\n"

    for start, end in reversed(spans):
        code = code[:start] + code[end:]

    # Insérer le bloc fusionné avant le premier composant struct/enum
    insert = re.search(r"\nprivate struct ", code)
    if insert:
        pos = insert.start() + 1
        code = code[:pos] + merged_block + "\n" + code[pos:]
    else:
        code = merged_block + "\n" + code

    return code


def dedupe_extension_view(code: str) -> str:
    """Supprime les extensions dupliquées (View, Text, Font…) avec les mêmes fonctions."""
    seen: set[str] = set()
    out: list[str] = []
    i = 0
    lines = code.splitlines(keepends=True)
    while i < len(lines):
        line = lines[i]
        if re.match(r"extension (View|Text|Font|Image)\b", line.strip()):
            block_lines = [line]
            i += 1
            depth = line.count("{") - line.count("}")
            while i < len(lines) and depth > 0:
                block_lines.append(lines[i])
                depth += lines[i].count("{") - lines[i].count("}")
                i += 1
            block = "".join(block_lines)
            funcs = re.findall(r"func (\w+)\(", block)
            if funcs and all(f in seen for f in funcs):
                continue
            for f in funcs:
                seen.add(f)
            out.append(block)
            continue
        out.append(line)
        i += 1
    return "".join(out)


def dedupe_private_types(code: str, prefix: str) -> str:
    """Garde la première déclaration de chaque private struct/enum (hors Tokens/Fonts/Gradients)."""
    seen: set[str] = set()
    skip_enums = {f"{prefix}Tokens", f"{prefix}Fonts", f"{prefix}Gradients"}
    out: list[str] = []
    i = 0
    lines = code.splitlines(keepends=True)
    while i < len(lines):
        line = lines[i]
        m = re.match(r"private (struct|enum) (\w+)", line.strip())
        if m and m.group(2) not in skip_enums:
            name = m.group(2)
            block_lines = [line]
            i += 1
            depth = line.count("{") - line.count("}")
            while i < len(lines) and depth > 0:
                block_lines.append(lines[i])
                depth += lines[i].count("{") - lines[i].count("}")
                i += 1
            if name in seen:
                continue
            seen.add(name)
            out.extend(block_lines)
            continue
        out.append(line)
        i += 1
    return "".join(out)


def finalize_component_swift(code: str, prefix: str) -> str:
    """Post-traitement : extensions restantes → enums, struct → private struct."""
    tokens_enum = f"{prefix}Tokens"
    fonts_enum = f"{prefix}Fonts"
    grad_enum = f"{prefix}Gradients"

    # Blocs extension Color restants (ex. Instagram : Color + LinearGradient dans un même bloc)
    while "extension Color" in code and "LinearGradient" not in code.split("extension Color", 1)[0][-20:]:
        m = re.search(r"extension Color\s*\{", code)
        if not m:
            break
        code, _ = _replace_braced_block(code, m.start(), f"private enum {tokens_enum} {{", "}}")
    # Color + LinearGradient dans le même bloc initial
    if "extension Color" in code:
        code, tokens = transform_color_extension(code, tokens_enum)
    if "extension Font" in code:
        code, _ = transform_font_extension(code, fonts_enum)
    if "extension LinearGradient" in code:
        code = transform_linear_gradient_extension(code, grad_enum)

    code = merge_duplicate_private_enums(code, tokens_enum)
    code = merge_duplicate_private_enums(code, fonts_enum)
    code = merge_duplicate_private_enums(code, grad_enum)
    code = dedupe_extension_view(code)

    token_names = re.findall(rf"{re.escape(tokens_enum)}\.(\w+)", code) + re.findall(
        r"static let (\w+)\s*=", code
    )
    token_names = list(dict.fromkeys(token_names))
    font_names = re.findall(r"static let (\w+)\s*=", code.split(f"private enum {fonts_enum}", 1)[-1] if fonts_enum in code else "")

    code = apply_token_and_font_refs(code, token_names, font_names, tokens_enum, fonts_enum)
    code = fix_gradient_token_refs(code, token_names, tokens_enum, font_names)
    code = fix_linear_gradient_refs(code, grad_enum)

    # Second passe après fusion des enums
    token_names = re.findall(r"static let (\w+)\s*=", code.split(f"private enum {tokens_enum}", 1)[1].split("\nprivate enum", 1)[0] if f"private enum {tokens_enum}" in code else "")
    token_names = list(dict.fromkeys(token_names))
    if f"private enum {fonts_enum}" in code:
        fb = code.split(f"private enum {fonts_enum}", 1)[1].split("\nprivate enum", 1)[0]
        font_names = list(dict.fromkeys(re.findall(r"static let (\w+)\s*=", fb)))
    code = apply_token_and_font_refs(code, token_names, font_names, tokens_enum, fonts_enum)
    code = fix_gradient_token_refs(code, token_names, tokens_enum, font_names)
    code = re.sub(rf"\bColor\.(\w+)\b", rf"{tokens_enum}.\1", code)

    code = dedupe_private_types(code, prefix)

    # Structs extraites = private (sauf déjà private)
    code = re.sub(r"\nstruct Lpsp", r"\nprivate struct Lpsp", code)
    code = re.sub(r"\nenum Lpsp", r"\nprivate enum Lpsp", code)
    # Ne pas privatiser Tokens/Fonts/Gradients déjà private enum
    code = code.replace("private private ", "private ")

    if "UIFont" in code and "import UIKit" not in code:
        code = "import UIKit\n" + code

    return code


def _replace_braced_block(code: str, start: int, open_repl: str, close_marker: str) -> tuple[str, str]:
    """Replace extension block starting at start with open_repl + same inner content."""
    depth = 0
    i = code.find("{", start)
    if i < 0:
        return code, ""
    inner_start = i + 1
    depth = 1
    j = inner_start
    while j < len(code) and depth:
        if code[j] == "{":
            depth += 1
        elif code[j] == "}":
            depth -= 1
        j += 1
    inner = code[inner_start : j - 1]
    new_block = open_repl + inner + "}"
    return code[:start] + new_block + code[j:], inner


def transform_blocks(
    blocks: Sequence[str],
    prefix: str,
) -> tuple[str, list[str], list[str], set[str]]:
    """Returns transformed Swift, token names, font names, component struct names."""
    tokens_enum = f"{prefix}Tokens"
    fonts_enum = f"{prefix}Fonts"

    useful = [b for b in blocks if block_is_useful(b)]
    type_map = build_type_map(collect_type_names(useful), prefix)

    parts: list[str] = []

    for block in useful:
        code = block
        if "import SwiftUI" in code:
            code = code.replace("import SwiftUI\n", "").replace("import SwiftUI", "")

        code = apply_type_renames(code, type_map)
        code = strip_leading_orphan_modifiers(code)
        parts.append(code.strip())

    merged = "\n\n".join(parts)
    merged = finalize_component_swift(merged, prefix)

    token_names = re.findall(r"static let (\w+)\s*=", merged)
    token_names = list(dict.fromkeys(token_names))
    all_fonts: list[str] = []
    if f"private enum {fonts_enum}" in merged:
        font_block = merged.split(f"private enum {fonts_enum}", 1)[1].split("\nprivate ", 1)[0]
        all_fonts = re.findall(r"static let (\w+)\s*=", font_block)

    components = {
        m.group(1)
        for m in re.finditer(rf"\bprivate struct\s+({re.escape(prefix)}\w+)", merged)
        if not m.group(1).endswith("Style") and "ShowroomRoot" not in m.group(1) and "TabScreen" not in m.group(1) and "Demo" not in m.group(1)
    }

    return merged, token_names, all_fonts, components
