#!/usr/bin/env python3
"""Generate LpspAwesome*View.swift files from Meliwat awesome-ios-design-md DESIGN-swiftui.md specs."""

from __future__ import annotations

import re
import sys
from pathlib import Path

# App display name -> relative path under design-md/
APP_PATHS: dict[str, str] = {
    "WhatsApp": "messaging/whatsapp",
    "Signal": "messaging/signal",
    "Telegram": "messaging/telegram",
    "Messenger": "messaging/messenger",
    "Discord": "messaging/discord",
    "Teams": "productivity/microsoft-teams",
    "Instagram": "social/instagram",
    "TikTok": "social/tiktok",
    "Snapchat": "social/snapchat",
    "X": "social/x-twitter",
    "Reddit": "social/reddit",
    "LinkedIn": "social/linkedin",
    "Facebook": "social/facebook",
    "Threads": "social/threads",
    "Pinterest": "social/pinterest",
    "Tinder": "dating/tinder",
    "Bumble": "dating/bumble",
    "Hinge": "dating/hinge",
    "Happn": "dating/happn",
    "Spotify": "music/spotify",
    "Apple Music": "music/apple-music",
    "Deezer": "music/deezer",
    "SoundCloud": "music/soundcloud",
    "YouTube Music": "music/youtube-music",
    "Shazam": "music/shazam",
    "Audible": "music/audible",
    "YouTube": "video/youtube",
    "Netflix": "video/netflix",
    "Disney+": "video/disney-plus",
    "Prime Video": "video/prime-video",
    "Apple TV": "video/apple-tv",
    "Twitch": "video/twitch",
    "ChatGPT": "misc/chatgpt",
    "Gemini": "misc/gemini",
    "Claude": "misc/claude",
    "Perplexity": "misc/perplexity",
    "Grok": "misc/grok",
    "Revolut": "finance/revolut",
    "Wise": "finance/wise",
    "PayPal": "finance/paypal",
    "Binance": "finance/binance",
    "Coinbase": "finance/coinbase",
    "Amazon": "misc/amazon",
    "Uber": "travel/uber",
    "Uber Eats": "food/uber-eats",
    "Deliveroo": "food/deliveroo",
    "Waze": "travel/waze",
    "Google Maps": "travel/google-maps",
    "Booking": "travel/booking",
    "Airbnb": "travel/airbnb",
    "Expedia": "travel/expedia",
    "Flighty": "travel/flighty",
    "TripAdvisor": "travel/tripadvisor",
    "Strava": "fitness/strava",
    "Google Calendar": "productivity/google-calendar",
    "Dropbox": "productivity/dropbox",
    "Zoom": "productivity/zoom",
    "Kindle": "misc/kindle",
    "Banque": "finance/revolut",  # reuse neobank shell until dedicated spec
    "Plans": "travel/google-maps",
    "Fichiers": "productivity/dropbox",
}


def slug(name: str) -> str:
    return re.sub(r"[^a-zA-Z0-9]", "", name)


def extract_colors(md: str, prefix: str) -> list[tuple[str, str]]:
    """Parse static let lines from Color extension block."""
    colors: list[tuple[str, str]] = []
    in_block = False
    for line in md.splitlines():
        if "extension Color" in line:
            in_block = True
            continue
        if in_block and line.strip() == "```":
            break
        if in_block:
            m = re.match(r"\s*static let (\w+)\s*=\s*(.+)$", line)
            if m:
                prop, expr = m.group(1), m.group(2).rstrip()
                colors.append((prop, expr))
    return colors


def extract_tab_view(md: str) -> str | None:
    """Find TabView struct body in markdown swift block."""
    pattern = re.compile(
        r"struct (\w+(?:TabView|RootTabView|RootView))\s*:\s*View\s*\{.*?\n\s*var body: some View \{(.*?)\n\s*\}\n\}",
        re.DOTALL,
    )
    m = pattern.search(md)
    if not m:
        return None
    struct_name, body = m.group(1), m.group(2)
    return struct_name, body


def extract_fonts(md: str) -> list[tuple[str, str]]:
    fonts: list[tuple[str, str]] = []
    in_block = False
    for line in md.splitlines():
        if "extension Font" in line:
            in_block = True
            continue
        if in_block and line.strip() == "```":
            break
        if in_block:
            m = re.match(r"\s*static let (\w+)\s*=\s*(.+)$", line)
            if m:
                fonts.append((m.group(1), m.group(2).rstrip()))
    return fonts


def generate_view(app_name: str, design_md: Path) -> str:
    md = design_md.read_text(encoding="utf-8")
    type_slug = slug(app_name)
    colors = extract_colors(md, type_slug)
    fonts = extract_fonts(md)

    color_lines = []
    for prop, expr in colors[:24]:
        color_lines.append(f"        static let {prop} = {expr}")

    font_lines = []
    for prop, expr in fonts[:12]:
        font_lines.append(f"        static let {prop} = {expr}")

    tab_info = extract_tab_view(md)
    tab_items = []
    if tab_info:
        _, body = tab_info
        for m in re.finditer(r'Label\("([^"]+)", systemImage: "([^"]+)"\)', body):
            tab_items.append((m.group(1), m.group(2)))
        for m in re.finditer(r"\.tabItem\s*\{\s*Label\(\"([^\"]+)\"", body):
            if not any(t[0] == m.group(1) for t in tab_items):
                tab_items.append((m.group(1), "square.grid.2x2.fill"))

    if not tab_items:
        tab_items = [("Accueil", "house.fill"), ("Explorer", "magnifyingglass"), ("Profil", "person.fill")]

    primary = colors[0][0] if colors else "accent"
    canvas = next((c[0] for c in colors if "canvas" in c[0].lower() or "background" in c[0].lower()), colors[0][0] if colors else "accent")

    tab_swift = "\n".join(
        f"""            Awesome{type_slug}TabScreen(title: "{title}", icon: "{icon}", appName: "{app_name}")
                .tabItem {{ Label("{title}", systemImage: "{icon}") }}"""
        for title, icon in tab_items[:5]
    )

    return f'''import SwiftUI

// Source: Meliwat/awesome-ios-design-md — {design_md.parent.name}/DESIGN-swiftui.md
struct LpspAwesome{type_slug}View: View {{
    var body: some View {{
        TabView {{
{tab_swift}
        }}
        .tint({type_slug}Tokens.{primary})
    }}
}}

private enum {type_slug}Tokens {{
{chr(10).join(color_lines) if color_lines else "        static let accent = Color.accentColor"}
}}

private struct Awesome{type_slug}TabScreen: View {{
    let title: String
    let icon: String
    let appName: String

    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 16) {{
                    header
                    sampleContent
                }}
                .padding()
            }}
            .background({type_slug}Tokens.{canvas}.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground({type_slug}Tokens.{canvas}, for: .navigationBar)
        }}
    }}

    private var header: some View {{
        HStack {{
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle({type_slug}Tokens.{primary})
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }}
    }}

    @ViewBuilder
    private var sampleContent: some View {{
        ForEach(0..<6, id: \\.self) {{ i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill({type_slug}Tokens.{primary}.opacity(0.12))
                .frame(height: 72)
                .overlay(alignment: .leading) {{
                    VStack(alignment: .leading, spacing: 4) {{
                        Text("\\(title) item \\(i + 1)")
                            .font(.headline)
                        Text("Awesome iOS DESIGN spec")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }}
                    .padding(.horizontal, 16)
                }}
        }}
    }}
}}
'''


def main() -> int:
    design_root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("/tmp/awesome-ios-design-md/design-md")
    out_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("LostPhone/LostPhone/Apps/Awesome/Generated")
    out_dir.mkdir(parents=True, exist_ok=True)

    registry_entries = []
    for app_name, rel in APP_PATHS.items():
        swift_path = design_root / rel / "DESIGN-swiftui.md"
        if not swift_path.exists():
            print(f"skip missing: {app_name} -> {swift_path}", file=sys.stderr)
            continue
        code = generate_view(app_name, swift_path)
        out_file = out_dir / f"LpspAwesome{slug(app_name)}View.swift"
        out_file.write_text(code, encoding="utf-8")
        registry_entries.append((app_name, slug(app_name)))
        print(f"generated {out_file.name}")

    registry = '''import SwiftUI

/// Routage showroom → vues Awesome (Meliwat/awesome-ios-design-md).
enum AwesomeShowroomRouter {
    @ViewBuilder
    static func view(for appName: String) -> some View {
        switch LpspAppAliases.canonical(appName) {
'''
    for app_name, s in registry_entries:
        registry += f'        case "{app_name}": LpspAwesome{s}View()\n'
    registry += '''        default:
            AwesomeShowroomFallbackView(appName: appName)
        }
    }
}

struct AwesomeShowroomFallbackView: View {
    let appName: String
    var body: some View {
        NavigationStack {
            ContentUnavailableView(appName, systemImage: "app.fill", description: Text("Vue Awesome en cours"))
        }
    }
}
'''
    (out_dir.parent / "AwesomeShowroomRouter.swift").write_text(registry, encoding="utf-8")

    tier_list = "\n".join(f'        "{name}",' for name in APP_PATHS.keys())
    catalog = f'''import Foundation

enum AwesomeShowroomCatalog {{
    static let tierApps: [String] = [
{tier_list}
    ]
}}
'''
    (Path("LostPhone/LostPhone/Core/Services/AwesomeShowroomCatalog.swift")).write_text(catalog, encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
