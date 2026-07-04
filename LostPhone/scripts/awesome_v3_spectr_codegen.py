"""Convert Spectr gallery preview HTML + CSS vars into pixel-faithful SwiftUI."""

from __future__ import annotations

import json
import re
from html.parser import HTMLParser
from pathlib import Path

PREVIEW_DIR = Path(__file__).resolve().parent / "spectr_previews"
SKIP_ROOT = frozenset({"tab-bar", "island", "status"})


def hex_color(value: str, fallback: str = "Color.primary") -> str:
    value = (value or "").strip()
    m = re.match(r"#([0-9A-Fa-f]{6})", value)
    if not m:
        return fallback
    h = m.group(1)
    r, g, b = int(h[0:2], 16) / 255, int(h[2:4], 16) / 255, int(h[4:6], 16) / 255
    return f"Color(red: {r:.3f}, green: {g:.3f}, blue: {b:.3f})"


def css_font_size(rule: str, default: float = 14) -> float:
    m = re.search(r"font-size:\s*([\d.]+)px", rule or "")
    return float(m.group(1)) if m else default


def css_weight(rule: str, default: str = ".regular") -> str:
    if "weight: 700" in (rule or "") or "weight:700" in (rule or ""):
        return ".bold"
    if "weight: 600" in (rule or "") or "weight:600" in (rule or ""):
        return ".semibold"
    return default


class _Node:
    __slots__ = ("tag", "classes", "text", "children")

    def __init__(self, tag: str, classes: list[str]):
        self.tag = tag
        self.classes = classes
        self.text = ""
        self.children: list[_Node] = []


class _TreeParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.root = _Node("root", [])
        self.stack = [self.root]

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if tag in ("html", "body", "svg", "path", "polyline", "polygon", "line", "circle", "rect"):
            return
        cls = ""
        for k, v in attrs:
            if k == "class" and v:
                cls = v
        node = _Node(tag, cls.split())
        self.stack[-1].children.append(node)
        self.stack.append(node)

    def handle_endtag(self, tag: str) -> None:
        if tag in ("html", "body", "svg", "path", "polyline", "polygon", "line", "circle", "rect"):
            return
        if len(self.stack) > 1:
            self.stack.pop()

    def handle_data(self, data: str) -> None:
        t = data.strip()
        if t and len(self.stack) > 1:
            self.stack[-1].text = (self.stack[-1].text + " " + t).strip()


def parse_tree(html: str) -> _Node:
    p = _TreeParser()
    p.feed(html)
    return p.root


def load_preview(slug: str) -> tuple[dict[str, str], _Node, dict[str, str]]:
    data = json.loads((PREVIEW_DIR / f"{slug}.json").read_text(encoding="utf-8"))
    css_path = PREVIEW_DIR / f"{slug}_css.json"
    css = json.loads(css_path.read_text(encoding="utf-8")) if css_path.is_file() else {}
    tree = parse_tree(data["body_html"])
    return data.get("vars", {}), tree, css


def _rule(css: dict[str, str], *names: str) -> str:
    for n in names:
        if n in css:
            return css[n]
    return ""


def _text_lit(s: str) -> str:
    return json.dumps(s, ensure_ascii=False)


def _flatten_text(node: _Node) -> str:
    parts = [node.text] if node.text else []
    for ch in node.children:
        t = _flatten_text(ch)
        if t:
            parts.append(t)
    return " ".join(p for p in parts if p).strip()


def render_node(node: _Node, vars: dict[str, str], css: dict[str, str], indent: int = 3, slug: str = "") -> str:
    if not node.classes and not node.text and not node.children:
        return ""
    base = node.classes[0] if node.classes else node.tag
    if base in SKIP_ROOT:
        return ""
    pad = "    " * indent
    inner = render_children(node, vars, css, indent, slug)

    # leaf text
    if node.text and not node.children:
        rule = _rule(css, base, " ".join(node.classes))
        size = css_font_size(rule, 14)
        weight = css_weight(rule)
        color = hex_color(vars.get("--text", "#FFFFFF"))
        if base in ("balance-label", "caption-meta", "nav-sub", "hero-tag", "hero-sub", "np-label", "np-from"):
            color = hex_color(vars.get("--text-secondary", "#A8A8A8"))
        if base in ("likes", "post-username", "card-name", "balance-figure", "hero-title-art", "track-title"):
            weight = ".semibold" if base != "balance-figure" else ".bold"
        if base == "balance-figure":
            size = 36
        if base == "hero-title-art":
            size = 42
        if base == "nf-word":
            color = hex_color(vars.get("--red", "#E50914"))
            weight = ".black"
        if base == "top10-numeral":
            weight = ".black"
            size = css_font_size(rule, 110)
            color = "Color(red: 0.12, green: 0.12, blue: 0.12)"
        if base == "app-logo":
            return f'{pad}Text({_text_lit(node.text)}).font(.custom("Snell Roundhand", size: 28)).fontWeight(.bold).foregroundStyle({hex_color(vars.get("--text", "#FFFFFF"))})'
        if base in ("caption", "poem"):
            return f'{pad}Text({_text_lit(_flatten_text(node))}).font(.system(size: 13)).foregroundStyle({hex_color(vars.get("--text", "#FFFFFF"))})'
        return f'{pad}Text({_text_lit(node.text)}).font(.system(size: {size}, weight: {weight})).foregroundStyle({color})'

    handlers = {
        "app-nav": lambda: f"{pad}HStack {{\n{inner}\n{pad}}} .padding(.horizontal, 14).padding(.top, 8).padding(.bottom, 6)",
        "app-logo": lambda: f'{pad}Text({_text_lit(node.text)}).font(.custom("Snell Roundhand", size: 28)).fontWeight(.bold)',
        "app-nav-actions": lambda: f"{pad}HStack(spacing: 16) {{\n{inner}\n{pad}}}",
        "wall": lambda: "" if slug == "whatsapp" else f"{pad}Color(red: 0.06, green: 0.08, blue: 0.07).opacity(0.95).ignoresSafeArea()",
        "input-bar": lambda: f"{pad}HStack(spacing: 12) {{\n{inner}\n{pad}}} .padding(.horizontal, 8).padding(.vertical, 6).background({hex_color(vars.get('--input-fill', '#1F2C34'))})",
        "top-nav": lambda: f"{pad}HStack(spacing: 12) {{\n{inner}\n{pad}}} .padding(.horizontal, 16).frame(height: 44)",
        "top-bar": lambda: f"{pad}HStack(spacing: 12) {{\n{inner}\n{pad}}} .padding(.horizontal, 16).frame(height: 44)",
        "header": lambda: f"{pad}HStack {{\n{inner}\n{pad}}} .padding(.horizontal, 16).frame(height: 48)",
        "chat-nav": lambda: f"{pad}HStack(spacing: 10) {{\n{inner}\n{pad}}} .padding(.horizontal, 12).frame(height: 56)",
        "thread-head": lambda: f"{pad}HStack(spacing: 10) {{\n{inner}\n{pad}}} .padding(.horizontal, 12).frame(height: 56)",
        "nav-bar": lambda: f"{pad}HStack(spacing: 8) {{\n{inner}\n{pad}}} .padding(.horizontal, 12).frame(height: 48)",
        "appbar": lambda: f"{pad}VStack(spacing: 0) {{\n{inner}\n{pad}}}",
        "appbar-row": lambda: f"{pad}HStack {{\n{inner}\n{pad}}} .padding(.horizontal, 16).frame(height: 48)",
        "app-top": lambda: f"{pad}HStack {{\n{inner}\n{pad}}} .padding(.horizontal, 16).frame(height: 48)",
        "stories": lambda: f"{pad}ScrollView(.horizontal, showsIndicators: false) {{\n{pad}    HStack(spacing: 12) {{\n{inner}\n{pad}    }}\n{pad}    .padding(.horizontal, 14).padding(.vertical, 10)\n{pad}}}",
        "story": lambda: f"{pad}VStack(spacing: 4) {{\n{inner}\n{pad}}}",
        "story-ring": lambda: _story_ring(node, vars, css, indent),
        "story-photo": lambda: "",
        "story-label": lambda: render_node(_Node("span", ["story-label"]), vars, css, indent) if node.text else "",
        "post": lambda: f"{pad}VStack(alignment: .leading, spacing: 0) {{\n{inner}\n{pad}}}",
        "post-header": lambda: f"{pad}HStack(spacing: 10) {{\n{inner}\n{pad}}} .padding(.horizontal, 14).frame(height: 48)",
        "post-avatar": lambda: f"{pad}Circle().fill(LinearGradient(colors: [Color(red:1,green:0.84,blue:0.6), Color(red:1,green:0.89,blue:0.58)], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 30, height: 30)",
        "post-image": lambda: f"{pad}Rectangle().fill(LinearGradient(colors: [Color(red:0.20,green:0.12,blue:0.30), Color(red:0.82,green:0.29,blue:0.45)], startPoint: .topLeading, endPoint: .bottomTrailing)).aspectRatio(1, contentMode: .fill)",
        "action-bar": lambda: f"{pad}HStack(spacing: 16) {{\n{inner}\n{pad}}} .font(.system(size: 22)).padding(.horizontal, 14).frame(height: 44)",
        "icon": lambda: _icon(node, indent, slug),
        "nav-name": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 16, weight: .semibold))',
        "nav-sub": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 12)).foregroundStyle(.secondary)',
        "nav-avatar": lambda: f'{pad}Circle().fill({hex_color(vars.get("--action-blue", "#0095F6"))}).frame(width: 36, height: 36).overlay(Text({_text_lit(node.text or "MR")}).font(.caption.bold()).foregroundStyle(.white))',
        "likes": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 13, weight: .semibold)).padding(.horizontal, 14)',
        "caption-meta": lambda: f'{pad}Text({_text_lit(node.text.upper())}).font(.system(size: 11)).foregroundStyle({hex_color(vars.get("--text-secondary", "#A8A8A8"))}).tracking(0.5).padding(.horizontal, 14).padding(.top, 4)',
        "wall": lambda: "",
        "video": lambda: f"{pad}LinearGradient(colors: [Color(red:0.08,green:0.05,blue:0.12), {hex_color(vars.get('--bg','#000'))}], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()",
        "map": lambda: _map_bg(vars, indent),
        "hero": lambda: f"{pad}ZStack(alignment: .bottomLeading) {{\n{inner}\n{pad}}} .frame(height: 420)",
        "hero-bg": lambda: (
            f"{pad}LinearGradient(colors: [Color(red:0.05,green:0.05,blue:0.08), Color(red:0.15,green:0.05,blue:0.08)], startPoint: .top, endPoint: .bottom).frame(maxWidth: .infinity, maxHeight: .infinity)"
            if slug == "netflix"
            else f"{pad}Circle().fill(RadialGradient(colors: [{hex_color(vars.get('--brand', '#0066FF'))}.opacity(0.5), .clear], center: .center, startRadius: 20, endRadius: 180)).frame(width: 280, height: 280)"
        ),
        "hero-fade": lambda: f"{pad}LinearGradient(colors: [.clear, {hex_color(vars.get('--bg', vars.get('--canvas', '#141414')))}], startPoint: .top, endPoint: .bottom).frame(height: 120)",
        "hero-top": lambda: f"{pad}HStack {{\n{inner}\n{pad}}} .padding(.horizontal, 12).padding(.top, 48)",
        "hero-title": lambda: f"{pad}VStack(alignment: .leading, spacing: 4) {{\n{inner}\n{pad}}} .padding(.horizontal, 12)",
        "hero-title-art": lambda: f'{pad}Text({_text_lit(_flatten_text(node))}).font(.system(size: 42, weight: .black)).foregroundStyle(.white)',
        "hero-btns": lambda: f"{pad}HStack(spacing: 10) {{\n{inner}\n{pad}}} .padding(.horizontal, 12).padding(.bottom, 16)",
        "hero-btn": lambda: f"{pad}HStack(spacing: 6) {{\n{inner}\n{pad}}} .padding(.horizontal, 14).padding(.vertical, 8).background({'Color.white' if 'play' in node.classes else 'Color.white.opacity(0.25)'}).foregroundStyle({'Color.black' if 'play' in node.classes else 'Color.white'}).clipShape(RoundedRectangle(cornerRadius: 4))",
        "top10-badge": lambda: f"{pad}HStack(spacing: 6) {{\n{inner}\n{pad}}} .padding(.horizontal, 12)",
        "top10": lambda: f"{pad}VStack(alignment: .leading, spacing: 8) {{\n{inner}\n{pad}}} .padding(.top, 8)",
        "top10-header": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 14, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)',
        "row-header": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 14, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)',
        "row-sec": lambda: f"{pad}VStack(alignment: .leading, spacing: 8) {{\n{inner}\n{pad}}} .padding(.top, 12)",
        "row-scroll": lambda: f"{pad}ScrollView(.horizontal, showsIndicators: false) {{\n{pad}    HStack(spacing: 8) {{\n{inner}\n{pad}    }}\n{pad}    .padding(.horizontal, 12)\n{pad}}}",
        "cw-tile": lambda: f"{pad}RoundedRectangle(cornerRadius: 4).fill(Color(red:0.15,green:0.15,blue:0.15)).frame(width: 120, height: 68)",
        "top10-row": lambda: f"{pad}HStack(spacing: 8) {{\n{inner}\n{pad}}} .padding(.horizontal, 12)",
        "top10-cell": lambda: f"{pad}HStack(alignment: .bottom, spacing: 4) {{\n{inner}\n{pad}}}",
        "top10-numeral": lambda: f"{pad}Text({_text_lit(node.text or '1')}).font(.system(size: 72, weight: .black)).foregroundStyle(Color(red:0.12,green:0.12,blue:0.12)).offset(y: 8)",
        "top10-poster": lambda: f"{pad}RoundedRectangle(cornerRadius: 4).fill(Color(red:0.2,green:0.2,blue:0.22)).frame(width: 90, height: 130)",
        "card-area": lambda: f"{pad}ZStack {{\n{inner}\n{pad}}} .padding(.horizontal, 12)",
        "swipe-card": lambda: f"{pad}ZStack(alignment: .bottomLeading) {{\n{inner}\n{pad}}} .frame(maxWidth: .infinity).frame(height: 480).clipShape(RoundedRectangle(cornerRadius: 12))",
        "portrait": lambda: f"{pad}LinearGradient(colors: [Color(red:0.55,green:0.35,blue:0.45), Color(red:0.25,green:0.18,blue:0.35)], startPoint: .top, endPoint: .bottom).frame(maxWidth: .infinity, maxHeight: .infinity)",
        "card-gradient": lambda: f"{pad}LinearGradient(colors: [.clear, .black.opacity(0.75)], startPoint: .center, endPoint: .bottom).frame(height: 180)",
        "card-info": lambda: f"{pad}HStack(alignment: .bottom) {{\n{inner}\n{pad}}} .padding(16)",
        "actions": lambda: f"{pad}HStack(spacing: 18) {{\n{inner}\n{pad}}} .padding(.bottom, 8)",
        "act-btn": lambda: f"{pad}Circle().fill(.white).frame(width: 56, height: 56).shadow(color: .black.opacity(0.15), radius: 4)",
        "balance-wrap": lambda: f"{pad}VStack(spacing: 4) {{\n{inner}\n{pad}}} .frame(maxWidth: .infinity).padding(.horizontal, 20).padding(.top, 8)",
        "qa-row": lambda: f"{pad}HStack(spacing: 0) {{\n{inner}\n{pad}}} .padding(.horizontal, 8).padding(.vertical, 16)",
        "qa": lambda: f"{pad}VStack(spacing: 6) {{\n{inner}\n{pad}}} .frame(maxWidth: .infinity)",
        "qa-circle": lambda: f"{pad}Circle().fill({hex_color(vars.get('--grad-start', vars.get('--brand', '#6B5BFF')))}).frame(width: 52, height: 52)",
        "metal-card": lambda: f"{pad}RoundedRectangle(cornerRadius: 16).fill(LinearGradient(colors: [{hex_color(vars.get('--grad-start','#5B6BFF'))}, {hex_color(vars.get('--grad-end','#9C6BFF'))}], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(height: 120).padding(.horizontal, 16)",
        "tiles": lambda: f"{pad}VStack(spacing: 8) {{\n{inner}\n{pad}}} .padding(.horizontal, 16).padding(.top, 8)",
        "ctile": lambda: f"{pad}HStack(spacing: 12) {{\n{inner}\n{pad}}} .padding(14).background({hex_color(vars.get('--surface-1', '#16161F'))}).clipShape(RoundedRectangle(cornerRadius: 16))",
        "chat-body": lambda: f"{pad}ScrollView {{\n{pad}    VStack(spacing: 8) {{\n{inner}\n{pad}    }}\n{pad}    .padding(.vertical, 8)\n{pad}}}",
        "thread": lambda: f"{pad}ScrollView {{\n{pad}    VStack(spacing: 8) {{\n{inner}\n{pad}    }}\n{pad}    .padding(.vertical, 8)\n{pad}}}",
        "chat": lambda: f"{pad}ScrollView {{\n{pad}    VStack(alignment: .leading, spacing: 16) {{\n{inner}\n{pad}    }}\n{pad}    .padding(16)\n{pad}}}",
        "bubble": lambda: _bubble(node, vars, indent),
        "msg-user": lambda: _bubble_simple(node.text, True, vars, indent),
        "msg-asst": lambda: f"{pad}VStack(alignment: .leading, spacing: 8) {{\n{inner}\n{pad}}} .padding(12).background({hex_color(vars.get('--elevated', vars.get('--surface-1', '#1E1E2A')))}).clipShape(RoundedRectangle(cornerRadius: 16)).frame(maxWidth: .infinity, alignment: .leading)",
        "e2e-banner": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 12)).foregroundStyle(.secondary).multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.vertical, 8)',
        "nav-info": lambda: f"{pad}VStack(alignment: .leading, spacing: 0) {{\n{inner}\n{pad}}}",
        "nav-back": lambda: f'{pad}Image(systemName: "chevron.left").font(.system(size: 17, weight: .semibold))',
        "nav-icons": lambda: f"{pad}HStack(spacing: 16) {{\n{inner}\n{pad}}} .foregroundStyle({hex_color(vars.get('--text', '#FFFFFF'))})",
        "np-gradient": lambda: "",
        "scroll-body": lambda: f"{pad}ScrollView {{\n{pad}    VStack(spacing: 16) {{\n{inner}\n{pad}    }}\n{pad}    .padding(.vertical, 8)\n{pad}}}",
        "album-art": lambda: f"{pad}RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [Color(red:0.3,green:0.2,blue:0.5), Color(red:0.1,green:0.1,blue:0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)).aspectRatio(1, contentMode: .fit).padding(.horizontal, 24)",
        "scrubber": lambda: f"{pad}Capsule().fill(.white.opacity(0.25)).frame(height: 4).padding(.horizontal, 24)",
        "rail": lambda: f"{pad}VStack(spacing: 20) {{\n{inner}\n{pad}}} .padding(.trailing, 12)",
        "caption-block": lambda: f"{pad}VStack(alignment: .leading, spacing: 6) {{\n{inner}\n{pad}}} .padding(.horizontal, 14).padding(.bottom, 8)",
        "top-tabs": lambda: f"{pad}HStack(spacing: 20) {{\n{inner}\n{pad}}} .padding(.top, 52)",
        "top-tab": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 17, weight: {".bold" if "active" in node.classes else ".semibold"})).foregroundStyle(.white.opacity({1.0 if "active" in node.classes else 0.55}))',
        "top-search": lambda: f'{pad}Image(systemName: "magnifyingglass").font(.system(size: 20)).foregroundStyle(.white).padding(.trailing, 16)',
        "caption-user": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 16, weight: .semibold)).foregroundStyle(.white)',
        "caption-text": lambda: f'{pad}Text({_text_lit(_flatten_text(node))}).font(.system(size: 15)).foregroundStyle(.white)',
        "music-row": lambda: f"{pad}HStack(spacing: 8) {{\n{inner}\n{pad}}} .foregroundStyle(.white.opacity(0.9))",
        "music-marquee": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 13)).lineLimit(1)',
        "compose": lambda: f"{pad}VStack(spacing: 6) {{\n{inner}\n{pad}}} .padding(.horizontal, 12).padding(.bottom, 8)",
        "compose-pill": lambda: f"{pad}HStack {{\n{inner}\n{pad}}} .padding(.horizontal, 12).padding(.vertical, 10).background({hex_color(vars.get('--input-fill', vars.get('--surface-1', '#262626')))}).clipShape(RoundedRectangle(cornerRadius: 24))",
        "search-wrap": lambda: f"{pad}VStack(spacing: 0) {{\n{inner}\n{pad}}} .padding(.horizontal, 16).padding(.top, 8)",
        "search-pill": lambda: f"{pad}HStack(spacing: 10) {{\n{inner}\n{pad}}} .padding(.horizontal, 14).padding(.vertical, 12).background({hex_color(vars.get('--input-fill', vars.get('--surface-2', '#F0F0F0')))}).clipShape(RoundedRectangle(cornerRadius: 28))",
        "feed": lambda: f"{pad}ScrollView {{\n{pad}    VStack(spacing: 12) {{\n{inner}\n{pad}    }}\n{pad}}}",
        "feed-scroll": lambda: f"{pad}ScrollView {{\n{pad}    VStack(spacing: 12) {{\n{inner}\n{pad}    }}\n{pad}}}",
        "masonry": lambda: f"{pad}HStack(alignment: .top, spacing: 8) {{\n{inner}\n{pad}}} .padding(.horizontal, 8)",
        "col": lambda: f"{pad}VStack(spacing: 8) {{\n{inner}\n{pad}}} .frame(maxWidth: .infinity)",
        "pin": lambda: f"{pad}Circle().fill({hex_color(vars.get('--action-blue', '#0095F6'))}).frame(width: 10, height: 10)",
        "sheet": lambda: f"{pad}VStack(spacing: 0) {{\n{inner}\n{pad}}} .background({hex_color(vars.get('--bg', vars.get('--canvas', '#FFFFFF')))}).clipShape(RoundedRectangle(cornerRadius: 16))",
        "gallery": lambda: f"{pad}LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {{\n{inner}\n{pad}}} .padding(8)",
        "tile": lambda: f"{pad}RoundedRectangle(cornerRadius: 8).fill(Color(red:0.15,green:0.17,blue:0.22)).aspectRatio(1, contentMode: .fit).overlay(Text({_text_lit(node.text or 'Alex')}).font(.caption).foregroundStyle(.white), alignment: .bottomLeading).padding(6)",
        "schedule": lambda: f"{pad}ScrollView {{\n{inner}\n{pad}}}",
        "reader": lambda: f"{pad}ScrollView {{\n{inner}\n{pad}}} .padding(20)",
        "ring-wrap": lambda: f"{pad}ZStack {{\n{inner}\n{pad}}}",
        "ring": lambda: f"{pad}Circle().strokeBorder(.white.opacity(0.15), lineWidth: 3).frame(width: 200, height: 200)",
        "viewfinder": lambda: f"{pad}Color.black.ignoresSafeArea()",
        "cam-overlay": lambda: f"{pad}VStack {{\n{inner}\n{pad}}}",
        "billboard": lambda: f"{pad}ZStack(alignment: .bottomLeading) {{\n{inner}\n{pad}}} .frame(height: 380)",
        "bb-bg": lambda: f"{pad}LinearGradient(colors: [Color(red:0.05,green:0.08,blue:0.2), Color(red:0.02,green:0.02,blue:0.06)], startPoint: .top, endPoint: .bottom).frame(maxWidth: .infinity, maxHeight: .infinity)",
        "player": lambda: f"{pad}ZStack {{\n{inner}\n{pad}}} .background(Color.black)",
        "convo": lambda: f"{pad}ScrollView {{\n{pad}    VStack(alignment: .leading, spacing: 16) {{\n{inner}\n{pad}    }}\n{pad}    .padding(16)\n{pad}}}",
        "swipe-area": lambda: f"{pad}ZStack {{\n{inner}\n{pad}}}",
        "profile-scroll": lambda: f"{pad}ScrollView {{\n{inner}\n{pad}}}",
        "rail-icon": lambda: f"{pad}VStack(spacing: 4) {{\n{inner}\n{pad}}}",
        "rail-count": lambda: render_node(_Node("span", ["rail-count"]), vars, css, indent) if node.text else "",
        "avatar-wrap": lambda: f"{pad}ZStack(alignment: .bottom) {{\n{inner}\n{pad}}}",
        "avatar": lambda: f"{pad}Circle().fill(LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 48, height: 48)",
        "disc": lambda: f"{pad}Circle().fill(.black).frame(width: 44, height: 44).overlay(Circle().fill(Color.red.opacity(0.8)).frame(width: 26, height: 26))",
        "menu-btn": lambda: f'{pad}Image(systemName: "line.3.horizontal").font(.title3)',
        "model-chip": lambda: f'{pad}Text({_text_lit(node.text.replace("▾","").strip() if node.text else "GPT-4o")}).font(.system(size: 15, weight: .semibold)).padding(.horizontal, 12).padding(.vertical, 6).background(Color(.systemGray6)).clipShape(Capsule())',
        "new-chat": lambda: f'{pad}Image(systemName: "square.and.pencil").font(.title3)',
        "poem": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 16)).foregroundStyle(.primary)',
        "intro": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 14)).foregroundStyle(.secondary)',
        "comp-input": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 16)).foregroundStyle(.secondary).frame(maxWidth: .infinity, alignment: .leading)',
        "compose-hint": lambda: f'{pad}Text({_text_lit(node.text)}).font(.system(size: 11)).foregroundStyle(.secondary).multilineTextAlignment(.center)',
    }

    if base in handlers:
        return handlers[base]()
    if inner:
        return inner
    if node.text:
        return f'{pad}Text({_text_lit(node.text)}).font(.system(size: 14))'
    return ""


def render_children(node: _Node, vars: dict[str, str], css: dict[str, str], indent: int, slug: str = "") -> str:
    parts = []
    action_icons = ["heart.fill", "message", "paperplane", "bookmark"]
    action_i = 0

    def render_child(ch: _Node) -> str:
        nonlocal action_i
        if ch.classes and ch.classes[0] == "icon" and node.classes and node.classes[0] == "action-bar":
            sym = action_icons[min(action_i, len(action_icons) - 1)]
            action_i += 1
            pad = "    " * (indent + 1)
            if "heart-liked" in ch.classes or (action_i == 1 and slug == "instagram"):
                return f'{pad}Image(systemName: "heart.fill").foregroundStyle(Color(red:0.93,green:0.29,blue:0.34))'
            if sym == "bookmark":
                return f'{pad}Image(systemName: "bookmark")'
            return f'{pad}Image(systemName: "{sym}")'
        return render_node(ch, vars, css, indent + 1, slug)

    for ch in node.children:
        bit = render_child(ch)
        if bit.strip():
            parts.append(bit)
    return "\n".join(parts)


def _story_ring(node: _Node, vars: dict[str, str], css: dict[str, str], indent: int) -> str:
    pad = "    " * indent
    read = "read" in node.classes
    stroke = "Color(red:0.15,green:0.15,blue:0.15)" if read else "AngularGradient(gradient: Gradient(colors: [Color(red:0.51,green:0.23,blue:0.71), Color(red:0.99,green:0.11,blue:0.11), Color(red:0.99,green:0.69,blue:0.27), Color(red:0.51,green:0.23,blue:0.71)]), center: .center)"
    inner = f"{pad}    Circle().fill(LinearGradient(colors: [Color(red:1,green:0.84,blue:0.79), Color(red:1,green:0.89,blue:0.60)], startPoint: .topLeading, endPoint: .bottomTrailing)).frame(width: 48, height: 48)"
    if read:
        return f"{pad}Circle().strokeBorder({stroke}, lineWidth: 2).frame(width: 56, height: 56)\n{inner}"
    return f"{pad}Circle().strokeBorder({stroke}, lineWidth: 2.5).frame(width: 56, height: 56)\n{inner}"


def _icon(node: _Node, indent: int, slug: str = "") -> str:
    pad = "    " * indent
    liked = "heart-liked" in node.classes or "liked" in node.classes
    save = "save" in node.classes
    if liked:
        return f'{pad}Image(systemName: "heart.fill").foregroundStyle(Color(red:0.93,green:0.29,blue:0.34))'
    if save:
        return f'{pad}Image(systemName: "bookmark")'
    if slug == "instagram" and node.classes == ["icon"]:
        return f'{pad}Image(systemName: "heart")'
    return f'{pad}Image(systemName: "ellipsis")'


def _map_bg(vars: dict[str, str], indent: int) -> str:
    pad = "    " * indent
    return f"{pad}Color(red:0.89,green:0.91,blue:0.85).ignoresSafeArea()"


def _bubble(node: _Node, vars: dict[str, str], indent: int) -> str:
    pad = "    " * indent
    incoming = "incoming" in node.classes
    align = "leading" if incoming else "trailing"
    bg = hex_color(vars.get("--input-fill", "#262626")) if incoming else hex_color(vars.get("--action-blue", "#0095F6"))
    fg = ".primary" if incoming else ".white"
    return (
        f"{pad}HStack {{\n"
        f"{'' if incoming else pad + '    Spacer(minLength: 48)\n'}"
        f"{pad}    Text({_text_lit(node.text)}).font(.system(size: 16)).foregroundStyle({fg})\n"
        f"{pad}        .padding(.horizontal, 12).padding(.vertical, 8)\n"
        f"{pad}        .background({bg}).clipShape(RoundedRectangle(cornerRadius: 18))\n"
        f"{'' if not incoming else pad + '    Spacer(minLength: 48)\n'}"
        f"{pad}}}.frame(maxWidth: .infinity, alignment: .{align}).padding(.horizontal, 12)"
    )


def _bubble_simple(text: str, outgoing: bool, vars: dict[str, str], indent: int) -> str:
    pad = "    " * indent
    bg = hex_color(vars.get("--surface-2", "#2A2A2A")) if not outgoing else hex_color(vars.get("--action-blue", "#10A37F"))
    align = "trailing" if outgoing else "leading"
    return (
        f"{pad}HStack {{\n"
        f"{'' if not outgoing else pad + '    Spacer(minLength: 32)\n'}"
        f"{pad}    Text({_text_lit(text)}).font(.system(size: 16)).padding(12)\n"
        f"{pad}        .background({bg}).clipShape(RoundedRectangle(cornerRadius: 16))\n"
        f"{'' if outgoing else pad + '    Spacer(minLength: 32)\n'}"
        f"{pad}}}.frame(maxWidth: .infinity, alignment: .{align})"
    )


def render_spectr_home_swift(slug: str, prefix: str) -> str:
    vars, tree, css = load_preview(slug)
    bg_key = "--bg" if "--bg" in vars else "--canvas" if "--canvas" in vars else "--surface"
    bg = hex_color(vars.get(bg_key, "#FFFFFF"))
    dark = (
        vars.get("--bg") in ("#000000", "#000")
        or vars.get("--canvas", "").lower().startswith("#0")
        or slug in {"netflix", "instagram", "tiktok", "spotify", "revolut", "discord", "twitch"}
    )
    parts = []
    for ch in tree.children:
        bit = render_node(ch, vars, css, 2, slug)
        if bit.strip():
            parts.append(bit)
    body = "\n".join(parts)
    if not body.strip():
        body = "        Text(\"Preview\").foregroundStyle(.secondary)"
    scheme = "\n        .preferredColorScheme(.dark)" if dark else ""

    top_classes = [ch.classes[0] for ch in tree.children if ch.classes]
    if slug == "tiktok" or (top_classes and top_classes[0] == "video"):
        wrapper = f"""ZStack(alignment: .bottomLeading) {{
            LinearGradient(colors: [Color(red:0.08,green:0.05,blue:0.12), {bg}], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
{body}
        }}"""
    elif slug == "whatsapp" or (top_classes and top_classes[0] == "wall"):
        wrapper = f"""ZStack {{
            Color(red: 0.06, green: 0.08, blue: 0.07).ignoresSafeArea()
            VStack(spacing: 0) {{
{body}
            }}
        }}"""
    elif slug in {"google-maps", "uber", "waze", "flighty"} or (top_classes and top_classes[0] == "map"):
        wrapper = f"""ZStack(alignment: .bottom) {{
{body}
        }}"""
    elif slug in {"netflix", "disney-plus", "prime-video", "revolut", "airbnb", "booking"}:
        wrapper = f"""ScrollView(showsIndicators: false) {{
            VStack(spacing: 0) {{
{body}
            }}
        }}"""
    elif top_classes and top_classes[0] in {"viewfinder", "player"}:
        wrapper = f"ZStack {{\n{body}\n        }}"
    else:
        wrapper = f"VStack(spacing: 0) {{\n{body}\n        }}"
    return f"""
private struct {prefix}SpectrHomeTabScreen: View {{
    var body: some View {{
        {wrapper}
        .background({bg}.ignoresSafeArea()){scheme}
    }}
}}
"""
