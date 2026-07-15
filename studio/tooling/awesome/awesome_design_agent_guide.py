#!/usr/bin/env python3
"""Affiche la section 9 (Agent Prompt Guide) de DESIGN.md pour une app Awesome.

Usage refonte artisanale (4 sources) :
  1. DESIGN-swiftui.md  — composants / tokens (déjà dans LpspAwesome*View.swift)
  2. DESIGN.md §9       — ce script (checklist + prompts composants critiques)
  3. Spectr gallery     — layout home + pixel ref
  4. Lost Phone         — LpspXxxStore + données scénario

Exemples :
  python3 awesome_design_agent_guide.py Deliveroo
  python3 awesome_design_agent_guide.py whatsapp --checklist
  python3 awesome_design_agent_guide.py --list
"""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

from generate_awesome_apps import APP_PATHS, slug

SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parents[1]
DEFAULT_SPEC_ROOTS = (
    REPO_ROOT / "awesome-ios-design-md" / "design-md",
    Path("/tmp/awesome-ios-design-md/design-md"),
)

SECTION_HEADINGS = (
    "## 9. Agent Prompt Guide",
    "## Agent Prompt Guide",
    "### Agent Prompt Guide",
)

SUBSECTION_COLORS = "### Quick Color Reference"
SUBSECTION_PROMPTS = "### Example Component Prompts"
SUBSECTION_ITERATION = "### Iteration Guide"


def resolve_spec_root(explicit: Path | None) -> Path | None:
    if explicit is not None:
        return explicit if explicit.is_dir() else None
    for root in DEFAULT_SPEC_ROOTS:
        if root.is_dir():
            return root
    return None


def normalize_query(query: str) -> str:
    return re.sub(r"[^a-z0-9]+", "", query.lower())


def resolve_app(query: str) -> tuple[str, str]:
    """Return (display_name, design-md relative path)."""
    q = query.strip()
    q_norm = normalize_query(q)

    for name, rel in APP_PATHS.items():
        if name.lower() == q.lower():
            return name, rel
        if slug(name).lower() == q_norm:
            return name, rel
        if rel.split("/")[-1].replace("-", "") == q_norm:
            return name, rel

    raise KeyError(f"App inconnue: {query!r} (voir --list)")


def read_design_md(spec_root: Path, rel: str) -> Path:
    path = spec_root / rel / "DESIGN.md"
    if not path.is_file():
        raise FileNotFoundError(path)
    return path


def extract_section_9(md: str) -> str:
    start = -1
    matched_heading = ""
    for heading in SECTION_HEADINGS:
        idx = md.find(heading)
        if idx >= 0:
            start = idx
            matched_heading = heading
            break
    if start < 0:
        raise ValueError("Section « Agent Prompt Guide » introuvable dans DESIGN.md")

    tail = md[start + len(matched_heading) :]
    m = re.search(r"\n## \d+\. ", tail)
    body = tail[: m.start()] if m else tail
    return (matched_heading + body).rstrip()


def subsection_block(section: str, heading: str) -> str:
    if heading not in section:
        return ""
    chunk = section.split(heading, 1)[1]
    for next_h in (SUBSECTION_COLORS, SUBSECTION_PROMPTS, SUBSECTION_ITERATION):
        if next_h == heading:
            continue
        if next_h in chunk:
            chunk = chunk.split(next_h, 1)[0]
    return chunk.strip()


def parse_iteration_checklist(section: str) -> list[str]:
    block = subsection_block(section, SUBSECTION_ITERATION)
    items: list[str] = []
    for line in block.splitlines():
        m = re.match(r"^\d+\.\s+(.+)$", line.strip())
        if m:
            items.append(m.group(1).strip())
    return items


def parse_component_prompts(section: str) -> list[str]:
    block = subsection_block(section, SUBSECTION_PROMPTS)
    prompts: list[str] = []
    for line in block.splitlines():
        m = re.match(r'^-\s+"(.+)"\s*$', line.strip())
        if m:
            prompts.append(m.group(1))
    return prompts


def parse_color_refs(section: str) -> list[str]:
    block = subsection_block(section, SUBSECTION_COLORS)
    refs: list[str] = []
    for line in block.splitlines():
        line = line.strip()
        if line.startswith("- "):
            refs.append(line[2:].strip())
    return refs


def spectr_url(rel: str) -> str:
    return f"https://www.spectr.to/gallery/{rel.split('/')[-1]}"


def clone_hint() -> str:
    return (
        "Clone Meliwat (une fois) :\n"
        "  git clone https://github.com/Meliwat/awesome-ios-design-md.git "
        f"{REPO_ROOT / 'awesome-ios-design-md'}\n"
        f"Puis relancer depuis {SCRIPT_DIR}"
    )


def format_output(
    app_name: str,
    rel: str,
    design_path: Path,
    section: str,
    *,
    checklist_only: bool = False,
    prompts_only: bool = False,
) -> str:
    lines = [
        f"# Agent Prompt Guide — {app_name}",
        f"Spec: Meliwat/awesome-ios-design-md/{rel}/DESIGN.md",
        f"Swift: Meliwat/awesome-ios-design-md/{rel}/DESIGN-swiftui.md",
        f"Spectr: {spectr_url(rel)}",
        f"Local: {design_path}",
        "",
        "Workflow refonte : composants spec → §9 ci-dessous → layout Spectr → LpspStore Lost Phone.",
        "",
    ]

    if checklist_only:
        rules = parse_iteration_checklist(section)
        lines.append("## Iteration Guide (quality gate)")
        for i, rule in enumerate(rules, 1):
            lines.append(f"- [ ] {i}. {rule}")
        return "\n".join(lines)

    if prompts_only:
        prompts = parse_component_prompts(section)
        lines.append("## Example Component Prompts")
        for i, prompt in enumerate(prompts, 1):
            lines.append(f"{i}. {prompt}")
        return "\n".join(lines)

    lines.append(section)
    rules = parse_iteration_checklist(section)
    if rules:
        lines.extend(["", "---", "", "## Checklist copiable (Iteration Guide)", ""])
        for i, rule in enumerate(rules, 1):
            lines.append(f"- [ ] {i}. {rule}")
    return "\n".join(lines)


def cmd_list() -> int:
    for name in sorted(APP_PATHS.keys(), key=str.lower):
        rel = APP_PATHS[name]
        print(f"{name:20}  {rel:40}  {spectr_url(rel)}")
    return 0


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "app",
        nargs="?",
        help="Nom app (Deliveroo), slug (deliveroo) ou segment path (whatsapp)",
    )
    parser.add_argument(
        "--spec-root",
        type=Path,
        default=None,
        help="Racine design-md (défaut: ../../awesome-ios-design-md/design-md)",
    )
    parser.add_argument("--list", action="store_true", help="Lister apps connues")
    parser.add_argument(
        "--checklist",
        action="store_true",
        help="Afficher uniquement l'Iteration Guide en cases à cocher",
    )
    parser.add_argument(
        "--prompts",
        action="store_true",
        help="Afficher uniquement les Example Component Prompts",
    )
    args = parser.parse_args(argv)

    if args.list:
        return cmd_list()

    if not args.app:
        parser.error("Indiquer une app ou --list")

    spec_root = resolve_spec_root(args.spec_root)
    if spec_root is None:
        print(clone_hint(), file=sys.stderr)
        return 2

    try:
        app_name, rel = resolve_app(args.app)
        design_path = read_design_md(spec_root, rel)
    except KeyError as exc:
        print(exc, file=sys.stderr)
        return 1
    except FileNotFoundError as exc:
        print(f"Fichier absent: {exc}", file=sys.stderr)
        print(clone_hint(), file=sys.stderr)
        return 2

    md = design_path.read_text(encoding="utf-8")
    try:
        section = extract_section_9(md)
    except ValueError as exc:
        print(f"{design_path}: {exc}", file=sys.stderr)
        return 1

    print(
        format_output(
            app_name,
            rel,
            design_path,
            section,
            checklist_only=args.checklist,
            prompts_only=args.prompts,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
