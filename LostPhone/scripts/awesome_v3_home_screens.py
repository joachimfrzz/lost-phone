"""Spectr gallery pixel-perfect home tab (index 0) for Awesome v3 showrooms."""

from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path

from awesome_v3_spectr_codegen import _text_lit, render_spectr_home_swift
from awesome_v3_spectr_manifest import template_for_app
from generate_awesome_apps import APP_PATHS


@dataclass
class HomeContext:
    app_name: str
    prefix: str
    category: str
    tokens: str
    canvas: str
    accent: str
    canvas_ref: str
    accent_ref: str
    components: set[str] = field(default_factory=set)
    feed_post: str | None = None
    story_ring: str | None = None
    post_card: str | None = None
    vote_col: str | None = None
    chat_screen: str | None = None
    outgoing_bubble: str | None = None
    compose_bar: str | None = None
    now_playing: str | None = None
    map_view: str | None = None
    where_to: str | None = None
    ride_card: str | None = None
    action_rail: str | None = None
    caption_overlay: str | None = None
    swipe_card: str | None = None
    play_btn: str | None = None
    poster_row: str | None = None
    top10_row: str | None = None
    metal_card: str | None = None
    shazam_home: str | None = None
    composer: str | None = None
    user_bubble: str | None = None
    assistant: str | None = None
    video_card: str | None = None
    server_rail: str | None = None


def _slug_for_app(app_name: str) -> str:
    rel = APP_PATHS.get(app_name, "")
    return rel.split("/")[-1] if rel else app_name.lower().replace(" ", "-")


def spectr_home_screen(ctx: HomeContext) -> str:
    """Generate SwiftUI home screen from Spectr gallery preview (HTML/CSS source of truth)."""
    slug = _slug_for_app(ctx.app_name)

    # Spec shells that match Spectr gallery home 1:1 (Meliwat DESIGN-swiftui.md)
    if slug == "instagram" and ctx.feed_post and ctx.story_ring:
        from awesome_v3_spectr_codegen import load_preview

        data = json.loads(
            (Path(__file__).resolve().parent / "spectr_previews" / "instagram.json").read_text(encoding="utf-8")
        )
        texts = data.get("texts", [])
        return f"""
private struct {ctx.prefix}SpectrStoryItem: Identifiable {{
    let id = UUID()
    let name: String
    let unread: Bool
}}

private enum {ctx.prefix}SpectrStoryData {{
    static let items: [{ctx.prefix}SpectrStoryItem] = [
        .init(name: "Your story", unread: true),
        .init(name: "maya_c", unread: true),
        .init(name: "jordanp", unread: true),
        .init(name: "_alex", unread: false),
    ]
}}

private struct {ctx.prefix}SpectrHomeTabScreen: View {{
    var body: some View {{
        VStack(spacing: 0) {{
            HStack {{
                Text("Instagram").font(.custom("Snell Roundhand", size: 28)).fontWeight(.bold)
                Spacer()
                Image(systemName: "heart").font(.system(size: 22))
                Image(systemName: "paperplane").font(.system(size: 22))
            }}
            .padding(.horizontal, 14).padding(.top, 8).padding(.bottom, 6)
            ScrollView {{
                VStack(spacing: 0) {{
                    ScrollView(.horizontal, showsIndicators: false) {{
                        HStack(spacing: 12) {{
                            ForEach({ctx.prefix}SpectrStoryData.items) {{ s in
                                VStack(spacing: 4) {{
                                    {ctx.story_ring}(avatar: Image(systemName: "person.circle.fill"), isUnread: s.unread, size: 56)
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 56)
                                }}
                            }}
                        }}
                        .padding(.horizontal, 14).padding(.vertical, 10)
                    }}
                    .overlay(alignment: .bottom) {{ Divider().background(Color(red: 0.15, green: 0.15, blue: 0.15)) }}
                    {ctx.feed_post}(
                        username: "maya_c",
                        avatar: Image(systemName: "person.circle.fill"),
                        photo: Image(systemName: "photo"),
                        likes: 1247,
                        caption: "golden hour on the walk home",
                        timestamp: "2 HOURS AGO"
                    )
                }}
            }}
        }}
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }}
}}
"""

    if slug == "whatsapp" and ctx.chat_screen and "WAChatScreen" in ctx.chat_screen:
        return f"""
private struct {ctx.prefix}SpectrHomeTabScreen: View {{
    var body: some View {{ {ctx.chat_screen}() }}
}}
"""
    if slug in {"spotify", "soundcloud", "apple-music", "deezer", "youtube-music"} and ctx.now_playing:
        from awesome_v3_spectr_codegen import load_preview

        _, _, _ = load_preview(slug)
        data = json.loads(
            (Path(__file__).resolve().parent / "spectr_previews" / f"{slug}.json").read_text(encoding="utf-8")
        )
        texts = data.get("texts", [])
        title = next((t for t in texts if len(t) > 3 and t[0].isupper() and " " in t), "Midnight Wavelength")
        artist = next((t for t in texts if t not in (title,) and not t.startswith("Playing")), "Nova Palmer")
        return f"""
private struct {ctx.prefix}SpectrHomeTabScreen: View {{
    var body: some View {{
        {ctx.now_playing}(
            trackTitle: {_text_lit(title)},
            artist: {_text_lit(artist)},
            artwork: Image(systemName: "music.note"),
            dominantColor: {ctx.accent_ref}
        )
        .background({ctx.canvas_ref}.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }}
}}
"""

    try:
        return render_spectr_home_swift(slug, ctx.prefix)
    except Exception:
        # Fallback minimal screen if preview assets missing
        _ = template_for_app(ctx.app_name, ctx.category)
        return f"""
private struct {ctx.prefix}SpectrHomeTabScreen: View {{
    var body: some View {{
        VStack {{
            Text({ctx.app_name!r}).font(.headline)
            Text("Spectr preview").font(.caption).foregroundStyle(.secondary)
        }}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background({ctx.canvas_ref}.ignoresSafeArea())
    }}
}}
"""
