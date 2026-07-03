#!/usr/bin/env python3
"""Generate quasi-conformant LpspAwesome*View.swift files from DESIGN-swiftui.md specs."""

from __future__ import annotations

import sys
from pathlib import Path

from generate_awesome_apps import APP_PATHS
from awesome_templates import (
    category_from_path,
    extract_colors,
    extract_fonts,
    extract_tabs,
    gen_messaging,
    header,
    pick_color,
    pick_font,
    slug,
    tab_view,
    tokens_block,
)

# ---------------------------------------------------------------------------
# Shared Swift fragments
# ---------------------------------------------------------------------------

def _generic_list(slug_name: str, accent: str) -> str:
    return f"""
private struct {slug_name}GenericListScreen: View {{
    let title: String
    var body: some View {{
        NavigationStack {{
            List(0..<8, id: \\.self) {{ i in
                HStack {{
                    RoundedRectangle(cornerRadius: 8).fill({slug_name}Tokens.{accent}.opacity(0.15)).frame(width: 44, height: 44)
                    VStack(alignment: .leading) {{
                        Text("\\(title) \\(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Mis à jour récemment").font(.system(size: 14)).foregroundStyle(.secondary)
                    }}
                }}
            }}
            .navigationTitle(title)
        }}
    }}
}}
"""


def _default_tabs(category: str) -> list[tuple[str, str]]:
    defaults: dict[str, list[tuple[str, str]]] = {
        "social": [("Accueil", "house.fill"), ("Explorer", "magnifyingglass"), ("Reels", "play.rectangle"), ("Profil", "person.circle")],
        "video": [("Accueil", "house.fill"), ("Nouveautés", "play.rectangle.on.rectangle"), ("Profil", "person.crop.circle.fill")],
        "music": [("Accueil", "house.fill"), ("Rechercher", "magnifyingglass"), ("Bibliothèque", "books.vertical.fill")],
        "dating": [("Découvrir", "flame.fill"), ("Messages", "bubble.left.fill"), ("Profil", "person.fill")],
        "finance": [("Accueil", "house.fill"), ("Cartes", "creditcard.fill"), ("Plus", "ellipsis")],
        "maps": [("Accueil", "house.fill"), ("Services", "square.grid.2x2"), ("Activité", "clock.fill")],
        "food": [("Accueil", "house.fill"), ("Rechercher", "magnifyingglass"), ("Compte", "person.crop.circle")],
        "travel": [("Explorer", "safari.fill"), ("Rechercher", "magnifyingglass"), ("Voyages", "suitcase.fill")],
        "ai": [("Chat", "bubble.left.fill"), ("Historique", "clock.fill")],
        "commerce": [("Accueil", "house.fill"), ("Rechercher", "magnifyingglass"), ("Panier", "cart.fill")],
        "reader": [("Bibliothèque", "books.vertical.fill"), ("Découvrir", "magnifyingglass")],
        "shazam": [("Découvrir", "waveform")],
        "calendar": [("Agenda", "calendar"), ("Tâches", "checklist")],
        "files": [("Fichiers", "folder.fill"), ("Récents", "clock.fill")],
        "meetings": [("Réunions", "video.fill"), ("Chat", "bubble.left.and.bubble.right.fill")],
        "fitness": [("Fil", "house.fill"), ("Carte", "map.fill"), ("Vous", "person.fill")],
        "messaging": [("Chats", "message.fill"), ("Appels", "phone.fill"), ("Réglages", "gearshape.fill")],
    }
    return defaults.get(category, [("Accueil", "house.fill"), ("Explorer", "magnifyingglass"), ("Profil", "person.fill")])


def _ensure_tabs(tabs: list[tuple[str, str]], category: str) -> list[tuple[str, str]]:
    return tabs if tabs else _default_tabs(category)


# ---------------------------------------------------------------------------
# SOCIAL — Instagram-style feed
# ---------------------------------------------------------------------------

def gen_social(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "action", "brand", "blue", "accent", "primary")
    canvas = pick_color(colors, "canvasLight", "canvas", "background", "surface")
    text_sec = pick_color(colors, "textSecondary", "secondary", "text", default_idx=0)
    text_pri = pick_color(colors, "textPrimary", "text", default_idx=0)
    destructive = pick_color(colors, "destructive", "red", default_idx=0)
    tabs = _ensure_tabs(tabs, "social")
    title_font = pick_font(fonts, "username", "screen", "body")

    screens = f'''        case let t where t.contains("accueil") || t.contains("home") || t.contains("feed") || t.contains("notification"):
            {slug_name}FeedScreen()
        case let t where t.contains("explor") || t.contains("search") || t.contains("commun"):
            {slug_name}ExploreScreen()
        case let t where t.contains("reel") || t.contains("short") || t.contains("create") || t.contains("post"):
            {slug_name}ReelsScreen()
        case let t where t.contains("profil") || t.contains("profile") || t.contains("network"):
            {slug_name}ProfileScreen()'''

    body = f"""
private struct {slug_name}FeedScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 0) {{
                    {slug_name}StoriesBar()
                    ForEach({slug_name}DemoData.posts) {{ post in
                        {slug_name}PostCard(post: post, accent: {slug_name}Tokens.{p}, textSec: {slug_name}Tokens.{text_sec})
                        Divider().background({slug_name}Tokens.{text_sec}.opacity(0.3))
                    }}
                }}
            }}
            .background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            .navigationTitle("{app_name}")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {{
                ToolbarItem(placement: .topBarLeading) {{ Image(systemName: "camera").foregroundStyle({slug_name}Tokens.{p}) }}
                ToolbarItem(placement: .topBarTrailing) {{
                    HStack(spacing: 16) {{
                        Image(systemName: "heart")
                        Image(systemName: "paperplane")
                    }}
                }}
            }}
        }}
    }}
}}

private struct {slug_name}StoriesBar: View {{
    private let stories = {slug_name}DemoData.stories
    var body: some View {{
        ScrollView(.horizontal, showsIndicators: false) {{
            HStack(spacing: 14) {{
                ForEach(stories) {{ story in
                    VStack(spacing: 4) {{
                        ZStack {{
                            Circle().strokeBorder(
                                AngularGradient(colors: [.orange, .pink, .purple, .blue, .orange], center: .center),
                                lineWidth: story.unread ? 2.5 : 1
                            ).frame(width: 68, height: 68)
                            Circle().fill(story.color.gradient).frame(width: 60, height: 60)
                                .overlay(Text(story.initials).font(.system(size: 20, weight: .semibold)).foregroundStyle(.white))
                        }}
                        Text(story.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                    }}
                }}
            }}
            .padding(.horizontal, 12).padding(.vertical, 10)
        }}
    }}
}}

private struct {slug_name}PostCard: View {{
    let post: {slug_name}Post
    let accent: Color
    let textSec: Color
    @State private var liked = false
    var body: some View {{
        VStack(alignment: .leading, spacing: 8) {{
            HStack {{
                Circle().fill(post.avatarColor.gradient).frame(width: 32, height: 32)
                    .overlay(Text(post.initials).font(.system(size: 12, weight: .bold)).foregroundStyle(.white))
                Text(post.username).font({slug_name}Fonts.{title_font})
                Spacer()
                Image(systemName: "ellipsis")
            }}
            .padding(.horizontal, 12)
            RoundedRectangle(cornerRadius: 0).fill(post.avatarColor.opacity(0.25)).frame(height: 320)
                .overlay {{ Image(systemName: "photo").font(.system(size: 48)).foregroundStyle(textSec) }}
            HStack(spacing: 16) {{
                Button {{ liked.toggle() }} label: {{ Image(systemName: liked ? "heart.fill" : "heart").foregroundStyle(liked ? .red : .primary) }}
                Image(systemName: "bubble.right")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }}
            .font(.system(size: 22)).padding(.horizontal, 12)
            Text("\\(post.likes + (liked ? 1 : 0)) J'aime").font(.system(size: 14, weight: .semibold)).padding(.horizontal, 12)
            Text(post.caption).font(.system(size: 14)).padding(.horizontal, 12).padding(.bottom, 12)
        }}
    }}
}}

private struct {slug_name}ExploreScreen: View {{
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                LazyVGrid(columns: cols, spacing: 2) {{
                    ForEach(0..<18, id: \\.self) {{ i in
                        RoundedRectangle(cornerRadius: 2).fill(Color(hue: Double(i) / 18, saturation: 0.3, brightness: 0.85))
                            .aspectRatio(1, contentMode: .fit)
                    }}
                }}
            }}
            .navigationTitle("Explorer")
        }}
    }}
}}

private struct {slug_name}ReelsScreen: View {{
    var body: some View {{
        ZStack {{
            Color.black.ignoresSafeArea()
            VStack {{
                Spacer()
                Image(systemName: "play.rectangle.fill").font(.system(size: 64)).foregroundStyle(.white.opacity(0.8))
                Text("Reels").font(.title2.bold()).foregroundStyle(.white)
                Text("Faites défiler pour découvrir").foregroundStyle(.white.opacity(0.7))
                Spacer()
            }}
        }}
    }}
}}

private struct {slug_name}ProfileScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 16) {{
                    HStack(spacing: 24) {{
                        Circle().fill({slug_name}Tokens.{p}.gradient).frame(width: 86, height: 86)
                            .overlay(Text("LP").font(.title.bold()).foregroundStyle(.white))
                        HStack(spacing: 20) {{
                            {slug_name}StatBlock(value: "128", label: "Publications")
                            {slug_name}StatBlock(value: "1,2k", label: "Abonnés")
                            {slug_name}StatBlock(value: "342", label: "Abonnements")
                        }}
                    }}
                    .padding(.horizontal)
                    Text("Joueur Lost Phone").font(.system(size: 14, weight: .semibold))
                    Text("Paris · Photographie · Voyage").font(.system(size: 14)).foregroundStyle(.secondary)
                    HStack {{
                        Button {{}} label: {{ Text("Modifier le profil").font(.system(size: 14, weight: .semibold)).frame(maxWidth: .infinity).padding(.vertical, 8).background(RoundedRectangle(cornerRadius: 8).fill({slug_name}Tokens.{text_sec}.opacity(0.15))) }}
                        Button {{}} label: {{ Text("Partager").font(.system(size: 14, weight: .semibold)).frame(maxWidth: .infinity).padding(.vertical, 8).background(RoundedRectangle(cornerRadius: 8).fill({slug_name}Tokens.{text_sec}.opacity(0.15))) }}
                    }}
                    .padding(.horizontal)
                }}
                .padding(.top)
            }}
            .navigationTitle("Profil")
        }}
    }}
}}

private struct {slug_name}StatBlock: View {{
    let value: String; let label: String
    var body: some View {{
        VStack {{ Text(value).font(.system(size: 16, weight: .bold)); Text(label).font(.system(size: 12)) }}
    }}
}}

private struct {slug_name}Story: Identifiable {{ let id = UUID(); let name: String; let initials: String; let color: Color; let unread: Bool }}
private struct {slug_name}Post: Identifiable {{ let id = UUID(); let username: String; let initials: String; let avatarColor: Color; let caption: String; let likes: Int }}

private enum {slug_name}DemoData {{
    static let stories: [{slug_name}Story] = [
        .init(name: "Votre story", initials: "+", color: .gray, unread: false),
        .init(name: "Camille", initials: "C", color: .pink, unread: true),
        .init(name: "Lucas", initials: "L", color: .blue, unread: true),
        .init(name: "Inès", initials: "I", color: .purple, unread: false),
    ]
    static let posts: [{slug_name}Post] = [
        .init(username: "camille_p", initials: "C", avatarColor: .pink, caption: "Coucher de soleil sur la Seine 🌅 #paris", likes: 842),
        .init(username: "lucas.mrt", initials: "L", avatarColor: .blue, caption: "Nouveau café du quartier — à tester !", likes: 156),
    ]
}}
{_generic_list(slug_name, p)}
"""
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


# ---------------------------------------------------------------------------
# VIDEO — Netflix-style
# ---------------------------------------------------------------------------

def gen_video(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "red", "brand", "accent", "primary")
    canvas = pick_color(colors, "canvas", "deepBlack", "background", "black")
    surface = pick_color(colors, "surface1", "surface", "elevated", default_idx=0)
    text_pri = pick_color(colors, "textPrimary", "text", default_idx=0)
    text_sec = pick_color(colors, "textSecondary", "secondary", default_idx=0)
    tabs = _ensure_tabs(tabs, "video")

    screens = f'''        case let t where t.contains("accueil") || t.contains("home") || t.contains("watch"):
            {slug_name}HomeScreen()
        case let t where t.contains("search") || t.contains("recherch") || t.contains("new") || t.contains("hot") || t.contains("short"):
            {slug_name}BrowseScreen()
        case let t where t.contains("profil") || t.contains("profile") || t.contains("netflix") || t.contains("watchlist") || t.contains("store") || t.contains("download") || t.contains("notif"):
            {slug_name}ProfilePickerScreen()'''

    body = f"""
private struct {slug_name}HomeScreen: View {{
    var body: some View {{
        NavigationStack {{
            ZStack(alignment: .bottom) {{
                ScrollView {{
                    VStack(alignment: .leading, spacing: 20) {{
                        {slug_name}HeroBillboard()
                        ForEach({slug_name}DemoData.rows) {{ row in
                            {slug_name}PosterRow(title: row.title, items: row.items, accent: {slug_name}Tokens.{p})
                        }}
                    }}
                    .padding(.bottom, 24)
                }}
                .background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            }}
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {{
                ToolbarItem(placement: .principal) {{ Text("{app_name}").font(.system(size: 20, weight: .bold)).foregroundStyle({slug_name}Tokens.{text_pri}) }}
                ToolbarItem(placement: .topBarTrailing) {{ Image(systemName: "person.crop.circle").foregroundStyle({slug_name}Tokens.{text_pri}) }}
            }}
            .toolbarBackground({slug_name}Tokens.{canvas}, for: .navigationBar)
        }}
    }}
}}

private struct {slug_name}HeroBillboard: View {{
    var body: some View {{
        ZStack(alignment: .bottomLeading) {{
            RoundedRectangle(cornerRadius: 4).fill(
                LinearGradient(colors: [{slug_name}Tokens.{surface}, .black.opacity(0.3)], startPoint: .top, endPoint: .bottom)
            ).aspectRatio(16/9, contentMode: .fit)
            VStack(alignment: .leading, spacing: 8) {{
                Text("SÉRIE TENDANCE").font(.system(size: 11, weight: .bold)).foregroundStyle({slug_name}Tokens.{text_sec})
                Text("L'Énigme de Belleville").font(.system(size: 28, weight: .bold)).foregroundStyle(.white)
                HStack(spacing: 12) {{
                    Label("Lecture", systemImage: "play.fill").font(.system(size: 15, weight: .bold))
                        .frame(maxWidth: .infinity).padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 4).fill({slug_name}Tokens.{pick_color(colors, "red", "brand", default_idx=0)}))
                    Label("Plus d'infos", systemImage: "info.circle").font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity).padding(.vertical, 10)
                        .background(RoundedRectangle(cornerRadius: 4).fill({slug_name}Tokens.{surface}))
                }}
            }}
            .padding(16)
        }}
        .padding(.horizontal, 12)
    }}
}}

private struct {slug_name}PosterRow: View {{
    let title: String; let items: [String]; let accent: Color
    var body: some View {{
        VStack(alignment: .leading, spacing: 8) {{
            Text(title).font(.system(size: 17, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)
            ScrollView(.horizontal, showsIndicators: false) {{
                HStack(spacing: 8) {{
                    ForEach(items, id: \\.self) {{ item in
                        RoundedRectangle(cornerRadius: 4).fill(accent.opacity(0.35)).frame(width: 110, height: 160)
                            .overlay(alignment: .bottomLeading) {{
                                Text(item).font(.system(size: 11, weight: .semibold)).foregroundStyle(.white).padding(6)
                            }}
                    }}
                }}
                .padding(.horizontal, 12)
            }}
        }}
    }}
}}

private struct {slug_name}BrowseScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.rows.flatMap {{ $0.items }}, id: \\.self) {{ title in
                HStack {{
                    RoundedRectangle(cornerRadius: 4).fill({slug_name}Tokens.{surface}).frame(width: 80, height: 120)
                    VStack(alignment: .leading, spacing: 4) {{
                        Text(title).font(.system(size: 17, weight: .semibold)).foregroundStyle({slug_name}Tokens.{text_pri})
                        Text("Nouveauté · 2026").font(.system(size: 13)).foregroundStyle({slug_name}Tokens.{text_sec})
                    }}
                }}
                .listRowBackground({slug_name}Tokens.{canvas})
            }}
            .scrollContentBackground(.hidden)
            .background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            .navigationTitle("Parcourir")
        }}
    }}
}}

private struct {slug_name}ProfilePickerScreen: View {{
    let profiles = {slug_name}DemoData.profiles
    var body: some View {{
        ZStack {{
            {slug_name}Tokens.{canvas}.ignoresSafeArea()
            VStack(spacing: 24) {{
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle({slug_name}Tokens.{text_pri})
                HStack(spacing: 20) {{
                    ForEach(profiles) {{ p in
                        VStack(spacing: 8) {{
                            RoundedRectangle(cornerRadius: 4).fill(p.color).frame(width: 84, height: 84)
                                .overlay(Text(p.emoji).font(.system(size: 36)))
                            Text(p.name).foregroundStyle({slug_name}Tokens.{text_sec})
                        }}
                    }}
                    VStack(spacing: 8) {{
                        RoundedRectangle(cornerRadius: 4).strokeBorder({slug_name}Tokens.{text_sec}, lineWidth: 1).frame(width: 84, height: 84)
                            .overlay(Image(systemName: "plus").font(.title).foregroundStyle({slug_name}Tokens.{text_sec}))
                        Text("Ajouter").foregroundStyle({slug_name}Tokens.{text_sec})
                    }}
                }}
            }}
        }}
    }}
}}

private struct {slug_name}PosterRowData: Identifiable {{ let id = UUID(); let title: String; let items: [String] }}
private struct {slug_name}Profile: Identifiable {{ let id = UUID(); let name: String; let emoji: String; let color: Color }}

private enum {slug_name}DemoData {{
    static let rows: [{slug_name}PosterRowData] = [
        .init(title: "Tendances actuelles", items: ["Midnight", "Horizon", "Nexus", "Pulse"]),
        .init(title: "Continuer à regarder", items: ["Saison 2 · Ép. 4", "Film · 42 min"]),
        .init(title: "Ajouts récents", items: ["Atlas", "Rivage", "Signal"]),
    ]
    static let profiles: [{slug_name}Profile] = [
        .init(name: "Alex", emoji: "🎬", color: {slug_name}Tokens.{p}),
        .init(name: "Enfants", emoji: "🧒", color: .orange),
    ]
}}
{_generic_list(slug_name, p)}
"""
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


# ---------------------------------------------------------------------------
# MUSIC — Spotify-style
# ---------------------------------------------------------------------------

def gen_music(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "green", "brand", "accent", "primary")
    canvas = pick_color(colors, "canvas", "background", "surface", "black")
    surface = pick_color(colors, "surface", "elevated", "card", default_idx=0)
    text_pri = pick_color(colors, "textPrimary", "text", default_idx=0)
    tabs = _ensure_tabs(tabs, "music")

    screens = f'''        case let t where t.contains("accueil") || t.contains("home") || t.contains("radio") || t.contains("new") || t.contains("sample"):
            {slug_name}HomeScreen()
        case let t where t.contains("search") || t.contains("recherch") || t.contains("discover"):
            {slug_name}SearchScreen()
        case let t where t.contains("library") || t.contains("biblioth") || t.contains("premium") || t.contains("profil"):
            {slug_name}LibraryScreen()'''

    body = f"""
private struct {slug_name}HomeScreen: View {{
    var body: some View {{
        ZStack(alignment: .bottom) {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 20) {{
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).foregroundStyle({slug_name}Tokens.{text_pri}).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
                        ForEach({slug_name}DemoData.recent) {{ item in
                            {slug_name}RecentTile(item: item, surface: {slug_name}Tokens.{surface})
                        }}
                    }}
                    .padding(.horizontal)
                    Text("Récemment joué").font(.system(size: 22, weight: .bold)).foregroundStyle({slug_name}Tokens.{text_pri}).padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {{
                        HStack(spacing: 12) {{
                            ForEach({slug_name}DemoData.playlists) {{ pl in
                                VStack(alignment: .leading) {{
                                    RoundedRectangle(cornerRadius: 6).fill(pl.color).frame(width: 140, height: 140)
                                    Text(pl.title).font(.system(size: 14, weight: .semibold)).foregroundStyle({slug_name}Tokens.{text_pri}).lineLimit(1)
                                }}
                            }}
                        }}
                        .padding(.horizontal)
                    }}
                }}
                .padding(.vertical).padding(.bottom, 80)
            }}
            .background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            {slug_name}MiniPlayer(accent: {slug_name}Tokens.{p}, surface: {slug_name}Tokens.{surface}, textPri: {slug_name}Tokens.{text_pri})
        }}
    }}
}}

private struct {slug_name}RecentTile: View {{
    let item: {slug_name}RecentItem; let surface: Color
    var body: some View {{
        HStack(spacing: 10) {{
            RoundedRectangle(cornerRadius: 4).fill(item.color).frame(width: 52, height: 52)
            Text(item.title).font(.system(size: 14, weight: .semibold)).foregroundStyle(.white).lineLimit(2)
            Spacer(minLength: 0)
        }}
        .padding(8).background(RoundedRectangle(cornerRadius: 6).fill(surface))
    }}
}}

private struct {slug_name}MiniPlayer: View {{
    let accent: Color; let surface: Color; let textPri: Color
    var body: some View {{
        HStack(spacing: 12) {{
            RoundedRectangle(cornerRadius: 4).fill(accent.opacity(0.5)).frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: 2) {{
                Text("La Vie en Rose").font(.system(size: 14, weight: .semibold)).foregroundStyle(textPri)
                Text("Édith Piaf").font(.system(size: 12)).foregroundStyle(.secondary)
            }}
            Spacer()
            Image(systemName: "play.fill").font(.title3)
            Image(systemName: "forward.end.fill").font(.title3)
        }}
        .padding(.horizontal, 12).padding(.vertical, 10)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {{ Divider() }}
    }}
}}

private struct {slug_name}SearchScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                HStack {{
                    Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                    Text("Artistes, titres ou podcasts").foregroundStyle(.secondary)
                    Spacer()
                }}
                .padding().background(RoundedRectangle(cornerRadius: 8).fill({slug_name}Tokens.{surface}))
                .padding()
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
                    ForEach({slug_name}DemoData.genres, id: \\.self) {{ g in
                        RoundedRectangle(cornerRadius: 8).fill(Color(hue: Double(abs(g.hashValue) % 360) / 360, saturation: 0.5, brightness: 0.7))
                            .frame(height: 100).overlay(alignment: .bottomLeading) {{ Text(g).font(.headline).padding(8) }}
                    }}
                }}
                .padding(.horizontal)
                Spacer()
            }}
            .background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            .navigationTitle("Rechercher")
        }}
    }}
}}

private struct {slug_name}LibraryScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.playlists) {{ pl in
                HStack(spacing: 12) {{
                    RoundedRectangle(cornerRadius: 4).fill(pl.color).frame(width: 48, height: 48)
                    VStack(alignment: .leading) {{
                        Text(pl.title).font(.system(size: 16, weight: .semibold))
                        Text("Playlist · 42 titres").font(.system(size: 13)).foregroundStyle(.secondary)
                    }}
                }}
                .listRowBackground({slug_name}Tokens.{canvas})
            }}
            .scrollContentBackground(.hidden)
            .background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            .navigationTitle("Bibliothèque")
        }}
    }}
}}

private struct {slug_name}RecentItem: Identifiable {{ let id = UUID(); let title: String; let color: Color }}
private struct {slug_name}Playlist: Identifiable {{ let id = UUID(); let title: String; let color: Color }}

private enum {slug_name}DemoData {{
    static let recent: [{slug_name}RecentItem] = [
        .init(title: "Mix du jour", color: .purple),
        .init(title: "Découvertes", color: .blue),
        .init(title: "Podcasts FR", color: .orange),
        .init(title: "Chill", color: .teal),
    ]
    static let playlists: [{slug_name}Playlist] = [
        .init(title: "Indie Française", color: .pink),
        .init(title: "Running Paris", color: .green),
        .init(title: "Années 80", color: .indigo),
    ]
    static let genres = ["Pop", "Rap FR", "Jazz", "Classique", "Électro", "Rock"]
}}
{_generic_list(slug_name, p)}
"""
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


# ---------------------------------------------------------------------------
# DATING — Tinder-style
# ---------------------------------------------------------------------------

def gen_dating(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "pink", "brand", "accent", "primary", "red")
    canvas = pick_color(colors, "canvas", "background", "white", "surface")
    tabs = _ensure_tabs(tabs, "dating")
    screens = f"""        case let t where t.contains("découvr") || t.contains("swipe") || t.contains("flame") || t.contains("match") || t.contains("timeline") || t.contains("map") || t.contains("top"):
            {slug_name}SwipeScreen()
        case let t where t.contains("chat") || t.contains("message"):
            {slug_name}MatchesScreen()
        case let t where t.contains("profil") || t.contains("profile"):
            {slug_name}DatingProfileScreen()"""
    body = f"""
private struct {slug_name}SwipeScreen: View {{
    @State private var index = 0
    private let profiles = {slug_name}DemoData.profiles
    var body: some View {{
        ZStack {{
            {slug_name}Tokens.{canvas}.ignoresSafeArea()
            VStack(spacing: 16) {{
                HStack {{
                    Image(systemName: "slider.horizontal.3").font(.title2)
                    Spacer()
                    Text("{app_name}").font(.system(size: 22, weight: .bold)).foregroundStyle({slug_name}Tokens.{p})
                    Spacer()
                    Image(systemName: "bolt.fill").font(.title2).foregroundStyle({slug_name}Tokens.{p})
                }}.padding(.horizontal)
                ZStack {{
                    ForEach(Array(profiles.enumerated()), id: \\.element.id) {{ i, profile in
                        if i >= index {{
                            {slug_name}SwipeCard(profile: profile, accent: {slug_name}Tokens.{p})
                                .scaleEffect(i == index ? 1 : 0.96).offset(y: CGFloat(i - index) * 8)
                        }}
                    }}
                }}.frame(maxHeight: 480)
                HStack(spacing: 24) {{
                    {slug_name}ActionButton(icon: "xmark", color: .red, size: 56) {{ if index < profiles.count {{ index += 1 }} }}
                    {slug_name}ActionButton(icon: "star.fill", color: .blue, size: 48) {{}}
                    {slug_name}ActionButton(icon: "heart.fill", color: {slug_name}Tokens.{p}, size: 56) {{ if index < profiles.count {{ index += 1 }} }}
                }}.padding(.bottom, 8)
            }}
        }}
    }}
}}

private struct {slug_name}SwipeCard: View {{
    let profile: {slug_name}DatingProfile; let accent: Color
    var body: some View {{
        ZStack(alignment: .bottomLeading) {{
            RoundedRectangle(cornerRadius: 16).fill(profile.color.gradient).frame(maxWidth: .infinity).frame(height: 440)
            LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .center, endPoint: .bottom)
            VStack(alignment: .leading, spacing: 4) {{
                HStack(alignment: .firstTextBaseline) {{
                    Text(profile.name).font(.system(size: 28, weight: .bold)).foregroundStyle(.white)
                    Text("\\(profile.age)").font(.system(size: 24)).foregroundStyle(.white)
                }}
                Text(profile.bio).font(.system(size: 15)).foregroundStyle(.white.opacity(0.9))
            }}.padding(20)
        }}.padding(.horizontal, 12).shadow(color: .black.opacity(0.15), radius: 12, y: 6)
    }}
}}

private struct {slug_name}ActionButton: View {{
    let icon: String; let color: Color; let size: CGFloat; let action: () -> Void
    var body: some View {{
        Button(action: action) {{
            Image(systemName: icon).font(.system(size: size * 0.35, weight: .bold)).foregroundStyle(color)
                .frame(width: size, height: size).background(Circle().fill(.white).shadow(color: .black.opacity(0.1), radius: 4, y: 2))
        }}
    }}
}}

private struct {slug_name}MatchesScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.matches) {{ m in
                HStack(spacing: 12) {{
                    Circle().fill(m.color.gradient).frame(width: 56, height: 56).overlay(Text(m.initials).font(.headline).foregroundStyle(.white))
                    VStack(alignment: .leading) {{
                        Text(m.name).font(.system(size: 17, weight: .semibold))
                        Text(m.preview).font(.system(size: 14)).foregroundStyle(.secondary).lineLimit(1)
                    }}
                    Spacer()
                    if m.unread {{ Circle().fill({slug_name}Tokens.{p}).frame(width: 10, height: 10) }}
                }}
            }}.navigationTitle("Messages")
        }}
    }}
}}

private struct {slug_name}DatingProfileScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                Circle().fill({slug_name}Tokens.{p}.gradient).frame(width: 120, height: 120).overlay(Text("LP").font(.largeTitle.bold()).foregroundStyle(.white))
                Text("Alex, 28").font(.title.bold())
                Text("Paris · Photographe amateur").foregroundStyle(.secondary)
                Button("Modifier le profil") {{}}.buttonStyle(.borderedProminent).tint({slug_name}Tokens.{p})
            }}.padding().navigationTitle("Profil")
        }}
    }}
}}

private struct {slug_name}DatingProfile: Identifiable {{ let id = UUID(); let name: String; let age: Int; let bio: String; let color: Color }}
private struct {slug_name}Match: Identifiable {{ let id = UUID(); let name: String; let initials: String; let preview: String; let color: Color; let unread: Bool }}
private enum {slug_name}DemoData {{
    static let profiles: [{slug_name}DatingProfile] = [
        .init(name: "Sophie", age: 26, bio: "Amatrice de vin nature et randonnées", color: .pink),
        .init(name: "Thomas", age: 29, bio: "Chef cuisinier · Lyon", color: .blue),
        .init(name: "Léa", age: 24, bio: "Design & café du matin", color: .purple),
    ]
    static let matches: [{slug_name}Match] = [
        .init(name: "Sophie", initials: "S", preview: "Salut ! On se voit cette semaine ?", color: .pink, unread: true),
        .init(name: "Marie", initials: "M", preview: "Super, à bientôt alors 😊", color: .orange, unread: false),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body

# ---------------------------------------------------------------------------
# FINANCE — Revolut-style
# ---------------------------------------------------------------------------

def gen_finance(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "blue", "primary")
    canvas = pick_color(colors, "canvas", "background", "surface", "black")
    text_pri = pick_color(colors, "textPrimary", "text", default_idx=0)
    text_sec = pick_color(colors, "textSecondary", "secondary", default_idx=0)
    tabs = _ensure_tabs(tabs, "finance")
    screens = (
        f'        case let t where t.contains("accueil") || t.contains("home") || t.contains("activity"):\n'
        f"            {slug_name}HomeScreen()\n"
        f'        case let t where t.contains("card") || t.contains("invest") || t.contains("crypto") || t.contains("market") || t.contains("trade") || t.contains("financ"):\n'
        f"            {slug_name}CardsScreen()\n"
        f'        case let t where t.contains("recipient") || t.contains("plus"):\n'
        f"            {slug_name}MoreScreen()"
    )
    body = f"""
private struct {slug_name}HomeScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 20) {{
                    VStack(alignment: .leading, spacing: 8) {{
                        Text("Solde total").font(.system(size: 14)).foregroundStyle({slug_name}Tokens.{text_sec})
                        Text("2 847,50 €").font(.system(size: 36, weight: .bold)).foregroundStyle({slug_name}Tokens.{text_pri})
                        HStack(spacing: 16) {{
                            Label("Ajouter", systemImage: "plus")
                            Label("Envoyer", systemImage: "arrow.up.right")
                            Label("Échanger", systemImage: "arrow.left.arrow.right")
                        }}.font(.system(size: 14, weight: .semibold)).foregroundStyle({slug_name}Tokens.{p}).padding(.top, 4)
                    }}.frame(maxWidth: .infinity, alignment: .leading)
                    RoundedRectangle(cornerRadius: 16).fill(LinearGradient(colors: [{slug_name}Tokens.{p}, {slug_name}Tokens.{p}.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180).overlay(alignment: .bottomLeading) {{
                            VStack(alignment: .leading) {{ Text("Carte Virtuelle").font(.system(size: 13)).foregroundStyle(.white.opacity(0.8)); Text("•••• 4829").font(.system(size: 22, weight: .bold)).foregroundStyle(.white) }}.padding(20)
                        }}
                    VStack(alignment: .leading, spacing: 12) {{
                        Text("Transactions").font(.system(size: 18, weight: .bold))
                        ForEach({slug_name}DemoData.transactions) {{ tx in {slug_name}TransactionRow(tx: tx) }}
                    }}
                }}.padding()
            }}.background({slug_name}Tokens.{canvas}.ignoresSafeArea()).navigationTitle("{app_name}")
        }}
    }}
}}

private struct {slug_name}TransactionRow: View {{
    let tx: {slug_name}Transaction
    var body: some View {{
        HStack(spacing: 12) {{
            Circle().fill(tx.color.opacity(0.2)).frame(width: 44, height: 44).overlay(Image(systemName: tx.icon).foregroundStyle(tx.color))
            VStack(alignment: .leading) {{ Text(tx.title).font(.system(size: 16, weight: .medium)); Text(tx.date).font(.system(size: 13)).foregroundStyle(.secondary) }}
            Spacer()
            Text(tx.amount).font(.system(size: 16, weight: .semibold)).foregroundStyle(tx.amount.hasPrefix("-") ? .primary : .green)
        }}
    }}
}}

private struct {slug_name}CardsScreen: View {{
    var body: some View {{ NavigationStack {{ Text("Gérez vos cartes").padding().navigationTitle("Cartes") }} }}
}}

private struct {slug_name}MoreScreen: View {{
    var body: some View {{
        NavigationStack {{ List {{ Section("Compte") {{ Label("Profil", systemImage: "person"); Label("Sécurité", systemImage: "lock") }} }}.navigationTitle("Plus") }}
    }}
}}

private struct {slug_name}Transaction: Identifiable {{ let id = UUID(); let title: String; let date: String; let amount: String; let icon: String; let color: Color }}
private enum {slug_name}DemoData {{
    static let transactions: [{slug_name}Transaction] = [
        .init(title: "Monoprix", date: "Aujourd'hui", amount: "-24,80 €", icon: "cart.fill", color: .orange),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €", icon: "arrow.down.left", color: .green),
        .init(title: "Netflix", date: "28 juin", amount: "-13,49 €", icon: "play.tv.fill", color: .red),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_maps(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "black", "primary")
    surface = pick_color(colors, "surface", "card", "elevated", default_idx=0)
    tabs = _ensure_tabs(tabs, "maps")
    screens = (
        f'        case let t where t.contains("accueil") || t.contains("home") || t.contains("service") || t.contains("contribute"):\n'
        f"            {slug_name}MapScreen()\n"
        f'        case let t where t.contains("activ") || t.contains("clock"):\n'
        f"            {slug_name}ActivityScreen()"
    )
    body = f"""
private struct {slug_name}MapScreen: View {{
    var body: some View {{
        ZStack(alignment: .bottom) {{
            {slug_name}MapPlaceholder()
            {slug_name}RideSheet(accent: {slug_name}Tokens.{p}, surface: {slug_name}Tokens.{surface})
        }}.ignoresSafeArea(edges: .bottom)
    }}
}}

private struct {slug_name}MapPlaceholder: View {{
    var body: some View {{
        ZStack {{
            LinearGradient(colors: [Color(red: 0.85, green: 0.92, blue: 0.88), Color(red: 0.75, green: 0.85, blue: 0.78)], startPoint: .top, endPoint: .bottom)
            Image(systemName: "map.fill").font(.system(size: 120)).foregroundStyle(.white.opacity(0.4))
            VStack {{
                HStack {{ Image(systemName: "location.fill"); Text("Place de la République") }}.padding(10).background(.ultraThinMaterial).clipShape(Capsule()).padding()
                Spacer()
            }}
        }}
    }}
}}

private struct {slug_name}RideSheet: View {{
    let accent: Color; let surface: Color
    var body: some View {{
        VStack(spacing: 0) {{
            Capsule().fill(Color.secondary.opacity(0.4)).frame(width: 36, height: 5).padding(.top, 8)
            VStack(alignment: .leading, spacing: 16) {{
                Text("Où allez-vous ?").font(.headline)
                Text("République → Gare de Lyon").foregroundStyle(.secondary)
                ForEach({slug_name}DemoData.rides) {{ ride in
                    HStack {{
                        Image(systemName: ride.icon).font(.title2).frame(width: 40)
                        VStack(alignment: .leading) {{ Text(ride.name).font(.headline); Text(ride.eta).font(.subheadline).foregroundStyle(.secondary) }}
                        Spacer(); Text(ride.price).font(.headline)
                    }}.padding().background(RoundedRectangle(cornerRadius: 12).fill(surface))
                }}
                Button("Confirmer {app_name}") {{}}.frame(maxWidth: .infinity).padding().background(RoundedRectangle(cornerRadius: 10).fill(accent)).foregroundStyle(.white).font(.headline)
            }}.padding()
        }}.background(RoundedRectangle(cornerRadius: 16).fill(.regularMaterial))
    }}
}}

private struct {slug_name}ActivityScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.rides) {{ r in
                HStack {{ Image(systemName: r.icon); VStack(alignment: .leading) {{ Text(r.name); Text(r.eta).foregroundStyle(.secondary) }}; Spacer(); Text(r.price) }}
            }}.navigationTitle("Activité")
        }}
    }}
}}

private struct {slug_name}Ride: Identifiable {{ let id = UUID(); let name: String; let eta: String; let price: String; let icon: String }}
private enum {slug_name}DemoData {{
    static let rides: [{slug_name}Ride] = [
        .init(name: "UberX", eta: "3 min", price: "12,40 €", icon: "car.fill"),
        .init(name: "Comfort", eta: "5 min", price: "16,80 €", icon: "car.side.fill"),
        .init(name: "Green", eta: "4 min", price: "13,20 €", icon: "leaf.fill"),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_food(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "green", "primary")
    surface = pick_color(colors, "surface", "card", default_idx=0)
    tabs = _ensure_tabs(tabs, "food")
    screens = (
        f'        case let t where t.contains("accueil") || t.contains("home") || t.contains("favour"):\n'
        f"            {slug_name}RestaurantsScreen()\n"
        f'        case let t where t.contains("search") || t.contains("recherch"):\n'
        f"            {slug_name}SearchScreen()\n"
        f'        case let t where t.contains("account") || t.contains("compte") || t.contains("profil"):\n'
        f"            {slug_name}AccountScreen()"
    )
    body = f"""
private struct {slug_name}RestaurantsScreen: View {{
    var body: some View {{
        ZStack(alignment: .bottom) {{
            NavigationStack {{
                ScrollView {{
                    VStack(alignment: .leading, spacing: 16) {{
                        Text("Livraison à Paris 11e").font(.subheadline).foregroundStyle(.secondary).padding(.horizontal)
                        ForEach({slug_name}DemoData.restaurants) {{ r in {slug_name}RestaurantCard(r: r, accent: {slug_name}Tokens.{p}) }}
                    }}.padding(.vertical)
                }}.navigationTitle("{app_name}")
            }}
            {slug_name}CartBar(accent: {slug_name}Tokens.{p})
        }}
    }}
}}

private struct {slug_name}RestaurantCard: View {{
    let r: {slug_name}Restaurant; let accent: Color
    var body: some View {{
        VStack(alignment: .leading, spacing: 8) {{
            RoundedRectangle(cornerRadius: 12).fill(r.color.opacity(0.3)).frame(height: 140)
            HStack {{
                VStack(alignment: .leading) {{
                    Text(r.name).font(.headline)
                    Text("\\(r.cuisine) · \\(r.eta) min · \\(r.fee)").font(.subheadline).foregroundStyle(.secondary)
                }}
                Spacer()
                HStack(spacing: 2) {{ Image(systemName: "star.fill").foregroundStyle(.orange); Text(r.rating).font(.subheadline.bold()) }}
            }}.padding(.horizontal)
        }}.padding(.bottom, 8)
    }}
}}

private struct {slug_name}CartBar: View {{
    let accent: Color
    var body: some View {{
        HStack {{ Text("Panier · 2 articles").font(.headline).foregroundStyle(.white); Spacer(); Text("24,50 €").font(.headline).foregroundStyle(.white) }}
            .padding().background(RoundedRectangle(cornerRadius: 12).fill(accent)).padding()
    }}
}}

private struct {slug_name}SearchScreen: View {{
    var body: some View {{ NavigationStack {{ Text("Rechercher un restaurant").padding().navigationTitle("Rechercher") }} }}
}}

private struct {slug_name}AccountScreen: View {{
    var body: some View {{ NavigationStack {{ List {{ Label("Commandes", systemImage: "bag"); Label("Adresses", systemImage: "mappin") }}.navigationTitle("Compte") }} }}
}}

private struct {slug_name}Restaurant: Identifiable {{ let id = UUID(); let name: String; let cuisine: String; let eta: Int; let fee: String; let rating: String; let color: Color }}
private enum {slug_name}DemoData {{
    static let restaurants: [{slug_name}Restaurant] = [
        .init(name: "Le Petit Bistro", cuisine: "Français", eta: 25, fee: "1,99 €", rating: "4,8", color: .orange),
        .init(name: "Sushi Zen", cuisine: "Japonais", eta: 35, fee: "2,49 €", rating: "4,6", color: .blue),
        .init(name: "Pizza Napoli", cuisine: "Italien", eta: 20, fee: "0,99 €", rating: "4,7", color: .red),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_travel(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "pink", "primary")
    tabs = _ensure_tabs(tabs, "travel")
    screens = (
        f'        case let t where t.contains("explor") || t.contains("accueil") || t.contains("home") || t.contains("flight") || t.contains("airport"):\n'
        f"            {slug_name}ExploreScreen()\n"
        f'        case let t where t.contains("search") || t.contains("recherch"):\n'
        f"            {slug_name}SearchScreen()\n"
        f'        case let t where t.contains("trip") || t.contains("voyage") || t.contains("book") || t.contains("wish") || t.contains("saved"):\n'
        f"            {slug_name}TripsScreen()"
    )
    body = f"""
private struct {slug_name}ExploreScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 16) {{
                    {slug_name}SearchBar(accent: {slug_name}Tokens.{p})
                    Text("Logements populaires").font(.title2.bold()).padding(.horizontal)
                    LazyVStack(spacing: 20) {{ ForEach({slug_name}DemoData.listings) {{ item in {slug_name}ListingCard(item: item) }} }}.padding(.horizontal)
                }}.padding(.vertical)
            }}.navigationTitle("{app_name}")
        }}
    }}
}}

private struct {slug_name}SearchBar: View {{
    let accent: Color
    var body: some View {{
        HStack {{
            Image(systemName: "magnifyingglass").foregroundStyle(accent)
            VStack(alignment: .leading) {{ Text("Où ?").font(.headline); Text("Dates · Voyageurs").font(.caption).foregroundStyle(.secondary) }}
            Spacer(); Image(systemName: "slider.horizontal.3")
        }}.padding().background(RoundedRectangle(cornerRadius: 28).strokeBorder(Color.secondary.opacity(0.3))).padding(.horizontal)
    }}
}}

private struct {slug_name}ListingCard: View {{
    let item: {slug_name}Listing
    var body: some View {{
        VStack(alignment: .leading, spacing: 8) {{
            RoundedRectangle(cornerRadius: 12).fill(item.color.opacity(0.35)).frame(height: 200)
            HStack {{ Text(item.location).font(.subheadline); Spacer(); HStack(spacing: 2) {{ Image(systemName: "star.fill"); Text(item.rating) }}.font(.subheadline) }}
            Text(item.title).font(.headline)
            Text("\\(item.price) par nuit").font(.subheadline).foregroundStyle(.secondary)
        }}
    }}
}}

private struct {slug_name}SearchScreen: View {{
    var body: some View {{ NavigationStack {{ {slug_name}SearchBar(accent: {slug_name}Tokens.{p}).padding().navigationTitle("Rechercher") }} }}
}}

private struct {slug_name}TripsScreen: View {{
    var body: some View {{
        NavigationStack {{ ContentUnavailableView("Aucun voyage", systemImage: "suitcase", description: Text("Vos réservations apparaîtront ici")).navigationTitle("Voyages") }}
    }}
}}

private struct {slug_name}Listing: Identifiable {{ let id = UUID(); let title: String; let location: String; let price: String; let rating: String; let color: Color }}
private enum {slug_name}DemoData {{
    static let listings: [{slug_name}Listing] = [
        .init(title: "Appartement haussmannien", location: "Paris, France", price: "145 €", rating: "4,92", color: .pink),
        .init(title: "Villa avec piscine", location: "Nice, France", price: "220 €", rating: "4,88", color: .cyan),
        .init(title: "Chalet cosy", location: "Chamonix, France", price: "180 €", rating: "4,95", color: .brown),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body

def gen_ai(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "green", "primary")
    canvas = pick_color(colors, "canvas", "background", "surface", default_idx=0)
    surface = pick_color(colors, "surface", "bubble", "elevated", default_idx=0)
    tabs = _ensure_tabs(tabs, "ai")
    screens = f'        case let t where t.contains("chat") || t.contains("discover") || t.contains("histor"):\n            {slug_name}ChatScreen()'
    body = f"""
private struct {slug_name}ChatScreen: View {{
    @State private var draft = ""
    var body: some View {{
        VStack(spacing: 0) {{
            ScrollView {{
                VStack(spacing: 12) {{
                    ForEach({slug_name}DemoData.messages) {{ msg in
                        if msg.isUser {{ {slug_name}UserBubble(text: msg.text, accent: {slug_name}Tokens.{p}) }}
                        else {{ {slug_name}AssistantBubble(text: msg.text, surface: {slug_name}Tokens.{surface}) }}
                    }}
                }}.padding()
            }}.background({slug_name}Tokens.{canvas}.ignoresSafeArea())
            HStack(spacing: 12) {{
                TextField("Message {app_name}…", text: $draft, axis: .vertical).padding(10).background(RoundedRectangle(cornerRadius: 20).fill({slug_name}Tokens.{surface}))
                Button {{}} label: {{ Image(systemName: "arrow.up.circle.fill").font(.title2).foregroundStyle({slug_name}Tokens.{p}) }}
            }}.padding().background(.bar)
        }}
    }}
}}

private struct {slug_name}UserBubble: View {{
    let text: String; let accent: Color
    var body: some View {{ HStack {{ Spacer(minLength: 48); Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(accent.opacity(0.15))) }} }}
}}

private struct {slug_name}AssistantBubble: View {{
    let text: String; let surface: Color
    var body: some View {{ HStack {{ Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(surface)); Spacer(minLength: 48) }} }}
}}

private struct {slug_name}ChatMsg: Identifiable {{ let id = UUID(); let text: String; let isUser: Bool }}
private enum {slug_name}DemoData {{
    static let messages: [{slug_name}ChatMsg] = [
        .init(text: "Explique-moi le métro parisien", isUser: true),
        .init(text: "Le métro parisien compte 16 lignes numérotées. La ligne 1 traverse Paris d'ouest en est.", isUser: false),
        .init(text: "Quel ticket acheter ?", isUser: true),
        .init(text: "Pour un touriste, le pass Navigo Jour ou des tickets t+ sont les options les plus courantes.", isUser: false),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_commerce(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "orange", "primary")
    canvas = pick_color(colors, "canvas", "background", "white", default_idx=0)
    tabs = _ensure_tabs(tabs, "commerce")
    screens = f'        case let t where t.contains("accueil") || t.contains("home") || t.contains("search") || t.contains("recherch"):\n            {slug_name}ShopScreen()'
    body = f"""
private struct {slug_name}ShopScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 16) {{
                    HStack {{
                        Image(systemName: "magnifyingglass")
                        Text("Rechercher sur {app_name}").foregroundStyle(.secondary)
                        Spacer(); Image(systemName: "camera")
                    }}.padding().background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6))).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
                        ForEach({slug_name}DemoData.products) {{ prod in {slug_name}ProductTile(product: prod, accent: {slug_name}Tokens.{p}) }}
                    }}.padding(.horizontal)
                }}
            }}.background({slug_name}Tokens.{canvas}.ignoresSafeArea()).navigationTitle("{app_name}")
        }}
    }}
}}

private struct {slug_name}ProductTile: View {{
    let product: {slug_name}Product; let accent: Color
    var body: some View {{
        VStack(alignment: .leading, spacing: 6) {{
            RoundedRectangle(cornerRadius: 8).fill(product.color.opacity(0.2)).aspectRatio(1, contentMode: .fit)
            Text(product.title).font(.caption).lineLimit(2)
            Text(product.price).font(.subheadline.bold()).foregroundStyle(accent)
        }}
    }}
}}

private struct {slug_name}Product: Identifiable {{ let id = UUID(); let title: String; let price: String; let color: Color }}
private enum {slug_name}DemoData {{
    static let products: [{slug_name}Product] = [
        .init(title: "Écouteurs sans fil Pro", price: "49,99 €", color: .blue),
        .init(title: "Liseuse légère 6\\"", price: "89,00 €", color: .gray),
        .init(title: "Cafetière expresso", price: "129,00 €", color: .brown),
        .init(title: "Sac à dos urbain", price: "34,50 €", color: .green),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_reader(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "orange", "primary")
    tabs = _ensure_tabs(tabs, "reader")
    screens = (
        f'        case let t where t.contains("library") || t.contains("biblioth") || t.contains("home") || t.contains("accueil"):\n'
        f"            {slug_name}LibraryScreen()\n"
        f'        case let t where t.contains("discover") || t.contains("découvr") || t.contains("search"):\n'
        f"            {slug_name}DiscoverScreen()"
    )
    body = f"""
private struct {slug_name}LibraryScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.books) {{ book in
                HStack(spacing: 14) {{
                    RoundedRectangle(cornerRadius: 4).fill(book.color).frame(width: 48, height: 72)
                    VStack(alignment: .leading, spacing: 4) {{
                        Text(book.title).font(.headline)
                        Text(book.author).font(.subheadline).foregroundStyle(.secondary)
                        ProgressView(value: book.progress).tint({slug_name}Tokens.{p})
                        Text("\\(Int(book.progress * 100)) % lu").font(.caption).foregroundStyle(.secondary)
                    }}
                }}
            }}.navigationTitle("Bibliothèque")
        }}
    }}
}}

private struct {slug_name}DiscoverScreen: View {{
    var body: some View {{ NavigationStack {{ Text("Découvrir de nouveaux livres").padding().navigationTitle("Découvrir") }} }}
}}

private struct {slug_name}Book: Identifiable {{ let id = UUID(); let title: String; let author: String; let progress: Double; let color: Color }}
private enum {slug_name}DemoData {{
    static let books: [{slug_name}Book] = [
        .init(title: "Le Comte de Monte-Cristo", author: "Alexandre Dumas", progress: 0.42, color: .brown),
        .init(title: "L'Étranger", author: "Albert Camus", progress: 1.0, color: .orange),
        .init(title: "Les Misérables", author: "Victor Hugo", progress: 0.08, color: .blue),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_shazam(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "blue", "primary")
    canvas = pick_color(colors, "canvas", "background", "surface", default_idx=0)
    tabs = _ensure_tabs(tabs, "shazam")
    screens = f'        case let t where t.contains("découvr") || t.contains("discover") || t.contains("home"):\n            {slug_name}ListenScreen()'
    body = f"""
private struct {slug_name}ListenScreen: View {{
    @State private var listening = false
    var body: some View {{
        ZStack {{
            {slug_name}Tokens.{canvas}.ignoresSafeArea()
            VStack(spacing: 32) {{
                Spacer()
                Text(listening ? "Écoute en cours…" : "Appuyez pour identifier").font(.title3).foregroundStyle(.secondary)
                Button {{ listening.toggle() }} label: {{
                    ZStack {{
                        Circle().fill({slug_name}Tokens.{p}.gradient).frame(width: 180, height: 180)
                        Image(systemName: "shazam.logo.fill").font(.system(size: 64)).foregroundStyle(.white)
                    }}
                }}
                if listening {{ {slug_name}Waveform(accent: {slug_name}Tokens.{p}) }}
                Spacer()
                Text("Dernière identification : Édith Piaf — La Vie en Rose").font(.footnote).foregroundStyle(.secondary).padding()
            }}
        }}
    }}
}}

private struct {slug_name}Waveform: View {{
    let accent: Color
    var body: some View {{
        HStack(spacing: 4) {{
            ForEach(0..<24, id: \\.self) {{ i in
                RoundedRectangle(cornerRadius: 2).fill(accent).frame(width: 4, height: CGFloat([12, 28, 18, 36, 22, 40, 16, 32][i % 8]))
            }}
        }}.frame(height: 44)
    }}
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_calendar(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "blue", "primary")
    canvas = pick_color(colors, "canvas", "background", "white", default_idx=0)
    tabs = _ensure_tabs(tabs, "calendar")
    screens = (
        f'        case let t where t.contains("agenda") || t.contains("schedule") || t.contains("calendar"):\n'
        f"            {slug_name}CalendarScreen()\n"
        f'        case let t where t.contains("task") || t.contains("tâche"):\n'
        f"            {slug_name}TasksScreen()"
    )
    body = f"""
private struct {slug_name}CalendarScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 16) {{
                    {slug_name}MonthGrid(accent: {slug_name}Tokens.{p})
                    VStack(alignment: .leading, spacing: 12) {{
                        Text("Aujourd'hui").font(.headline)
                        ForEach({slug_name}DemoData.events) {{ ev in {slug_name}EventRow(event: ev, accent: {slug_name}Tokens.{p}) }}
                    }}.padding(.horizontal)
                }}.padding(.vertical)
            }}.background({slug_name}Tokens.{canvas}.ignoresSafeArea()).navigationTitle("Juillet 2026")
        }}
    }}
}}

private struct {slug_name}MonthGrid: View {{
    let accent: Color
    var body: some View {{
        VStack(spacing: 8) {{
            HStack {{ ForEach(["L","M","M","J","V","S","D"], id: \\.self) {{ d in Text(d).font(.caption.bold()).frame(maxWidth: .infinity) }} }}
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {{
                ForEach(1...30, id: \\.self) {{ d in
                    Text("\\(d)").font(.subheadline).frame(maxWidth: .infinity).padding(8)
                        .background(Circle().fill(d == 3 ? accent : Color.clear)).foregroundStyle(d == 3 ? .white : .primary)
                }}
            }}
        }}.padding()
    }}
}}

private struct {slug_name}EventRow: View {{
    let event: {slug_name}CalEvent; let accent: Color
    var body: some View {{
        HStack(spacing: 12) {{
            RoundedRectangle(cornerRadius: 2).fill(accent).frame(width: 4, height: 44)
            VStack(alignment: .leading) {{ Text(event.title).font(.headline); Text(event.time).font(.subheadline).foregroundStyle(.secondary) }}
        }}
    }}
}}

private struct {slug_name}TasksScreen: View {{
    var body: some View {{ NavigationStack {{ List {{ Text("Préparer la réunion"); Text("Acheter le cadeau") }}.navigationTitle("Tâches") }} }}
}}

private struct {slug_name}CalEvent: Identifiable {{ let id = UUID(); let title: String; let time: String }}
private enum {slug_name}DemoData {{
    static let events: [{slug_name}CalEvent] = [
        .init(title: "Réunion équipe", time: "10:00 – 11:00"),
        .init(title: "Déjeuner avec Marie", time: "12:30 – 13:30"),
        .init(title: "Cinéma", time: "20:00"),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_files(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "blue", "primary")
    tabs = _ensure_tabs(tabs, "files")
    screens = (
        f'        case let t where t.contains("fichier") || t.contains("file") || t.contains("offline") || t.contains("home"):\n'
        f"            {slug_name}FilesScreen()\n"
        f'        case let t where t.contains("recent") || t.contains("récent") || t.contains("account") || t.contains("compte"):\n'
        f"            {slug_name}AccountScreen()"
    )
    body = f"""
private struct {slug_name}FilesScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.files) {{ f in
                HStack(spacing: 12) {{
                    Image(systemName: f.isFolder ? "folder.fill" : "doc.fill").foregroundStyle({slug_name}Tokens.{p}).font(.title2)
                    VStack(alignment: .leading) {{ Text(f.name).font(.body); Text(f.detail).font(.caption).foregroundStyle(.secondary) }}
                    Spacer()
                    if f.isFolder {{ Image(systemName: "chevron.right").foregroundStyle(.tertiary) }}
                }}
            }}.navigationTitle("Fichiers")
        }}
    }}
}}

private struct {slug_name}AccountScreen: View {{
    var body: some View {{ NavigationStack {{ List {{ Label("Espace utilisé : 4,2 Go", systemImage: "internaldrive"); Label("Paramètres", systemImage: "gearshape") }}.navigationTitle("Compte") }} }}
}}

private struct {slug_name}FileItem: Identifiable {{ let id = UUID(); let name: String; let detail: String; let isFolder: Bool }}
private enum {slug_name}DemoData {{
    static let files: [{slug_name}FileItem] = [
        .init(name: "Documents", detail: "12 fichiers", isFolder: true),
        .init(name: "Photos vacances", detail: "Modifié hier", isFolder: true),
        .init(name: "Contrat.pdf", detail: "245 Ko", isFolder: false),
        .init(name: "Notes.txt", detail: "4 Ko", isFolder: false),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_meetings(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "blue", "primary")
    tabs = _ensure_tabs(tabs, "meetings")
    screens = (
        f'        case let t where t.contains("réunion") || t.contains("meeting") || t.contains("calendar") || t.contains("activity"):\n'
        f"            {slug_name}MeetingsScreen()\n"
        f'        case let t where t.contains("chat") || t.contains("team"):\n'
        f"            {slug_name}TeamChatScreen()"
    )
    body = f"""
private struct {slug_name}MeetingsScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({slug_name}DemoData.meetings) {{ m in
                VStack(alignment: .leading, spacing: 8) {{
                    Text(m.title).font(.headline)
                    Text(m.time).font(.subheadline).foregroundStyle(.secondary)
                    HStack {{
                        Button("Rejoindre") {{}}.buttonStyle(.borderedProminent).tint({slug_name}Tokens.{p})
                        Button("Détails") {{}}.buttonStyle(.bordered)
                    }}
                }}.padding(.vertical, 4)
            }}.navigationTitle("Réunions")
        }}
    }}
}}

private struct {slug_name}TeamChatScreen: View {{
    var body: some View {{ NavigationStack {{ Text("Messages d'équipe").padding().navigationTitle("Chat") }} }}
}}

private struct {slug_name}Meeting: Identifiable {{ let id = UUID(); let title: String; let time: String }}
private enum {slug_name}DemoData {{
    static let meetings: [{slug_name}Meeting] = [
        .init(title: "Stand-up quotidien", time: "Aujourd'hui · 09:30"),
        .init(title: "Revue de sprint", time: "Demain · 14:00"),
        .init(title: "Point client", time: "Ven. 4 juil. · 11:00"),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


def gen_fitness(slug_name: str, app_name: str, colors, fonts, tabs, rel: str) -> str:
    p = pick_color(colors, "brand", "accent", "orange", "primary")
    tabs = _ensure_tabs(tabs, "fitness")
    screens = (
        f'        case let t where t.contains("fil") || t.contains("home") || t.contains("accueil"):\n'
        f"            {slug_name}FeedScreen()\n"
        f'        case let t where t.contains("map") || t.contains("carte"):\n'
        f"            {slug_name}MapScreen()\n"
        f'        case let t where t.contains("group") || t.contains("vous") || t.contains("profil"):\n'
        f"            {slug_name}ProfileScreen()"
    )
    body = f"""
private struct {slug_name}FeedScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                LazyVStack(spacing: 16) {{
                    ForEach({slug_name}DemoData.activities) {{ act in {slug_name}ActivityCard(activity: act, accent: {slug_name}Tokens.{p}) }}
                }}.padding()
            }}.navigationTitle("Fil d'activité")
        }}
    }}
}}

private struct {slug_name}ActivityCard: View {{
    let activity: {slug_name}Activity; let accent: Color
    var body: some View {{
        VStack(alignment: .leading, spacing: 10) {{
            HStack {{
                Circle().fill(accent.gradient).frame(width: 40, height: 40).overlay(Text(activity.initials).foregroundStyle(.white))
                VStack(alignment: .leading) {{ Text(activity.athlete).font(.headline); Text(activity.date).font(.caption).foregroundStyle(.secondary) }}
                Spacer(); Image(systemName: "ellipsis")
            }}
            RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 160).overlay {{ Image(systemName: "map").font(.largeTitle).foregroundStyle(.white.opacity(0.6)) }}
            Text(activity.title).font(.headline)
            HStack(spacing: 16) {{
                Label(activity.distance, systemImage: "figure.run")
                Label(activity.duration, systemImage: "clock")
                Label(activity.pace, systemImage: "speedometer")
            }}.font(.caption).foregroundStyle(.secondary)
            HStack {{ Image(systemName: "hand.thumbsup"); Text("\\(activity.kudos) kudos").font(.caption) }}
        }}.padding().background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.06), radius: 4, y: 2))
    }}
}}

private struct {slug_name}MapScreen: View {{
    var body: some View {{ NavigationStack {{ Text("Carte des parcours").padding().navigationTitle("Carte") }} }}
}}

private struct {slug_name}ProfileScreen: View {{
    var body: some View {{ NavigationStack {{ Text("Vos statistiques").padding().navigationTitle("Vous") }} }}
}}

private struct {slug_name}Activity: Identifiable {{
    let id = UUID(); let athlete: String; let initials: String; let title: String; let date: String
    let distance: String; let duration: String; let pace: String; let kudos: Int
}}
private enum {slug_name}DemoData {{
    static let activities: [{slug_name}Activity] = [
        .init(athlete: "Camille R.", initials: "CR", title: "Course matinale — Bois de Vincennes", date: "Aujourd'hui · 07:15", distance: "8,2 km", duration: "42 min", pace: "5:07 /km", kudos: 12),
        .init(athlete: "Lucas M.", initials: "LM", title: "Sortie vélo — Seine", date: "Hier · 18:30", distance: "32 km", duration: "1h 15", pace: "25,6 km/h", kudos: 8),
    ]
}}
""" + _generic_list(slug_name, p)
    return header(app_name, rel) + tab_view(slug_name, tabs, p, screens) + "\n" + tokens_block(slug_name, colors, fonts) + body


GENERATORS = {
    "messaging": gen_messaging,
    "social": gen_social,
    "video": gen_video,
    "music": gen_music,
    "dating": gen_dating,
    "finance": gen_finance,
    "maps": gen_maps,
    "food": gen_food,
    "travel": gen_travel,
    "ai": gen_ai,
    "commerce": gen_commerce,
    "reader": gen_reader,
    "shazam": gen_shazam,
    "calendar": gen_calendar,
    "files": gen_files,
    "meetings": gen_meetings,
    "fitness": gen_fitness,
}


def generate_view(app_name: str, rel: str, design_md: Path) -> str:
    md = design_md.read_text(encoding="utf-8")
    type_slug = slug(app_name)
    colors = extract_colors(md)
    fonts = extract_fonts(md)
    tabs = extract_tabs(md)
    category = category_from_path(rel)
    gen_fn = GENERATORS.get(category, gen_social)
    return gen_fn(type_slug, app_name, colors, fonts, tabs, rel)


def main() -> int:
    design_root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("/tmp/awesome-ios-design-md/design-md")
    out_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("LostPhone/LostPhone/Apps/Awesome/Generated")
    out_dir.mkdir(parents=True, exist_ok=True)

    registry_entries: list[tuple[str, str]] = []
    failed: list[str] = []

    for app_name, rel in APP_PATHS.items():
        swift_path = design_root / rel / "DESIGN-swiftui.md"
        if not swift_path.exists():
            print(f"skip missing: {app_name} -> {swift_path}", file=sys.stderr)
            failed.append(f"{app_name} (missing spec)")
            continue
        try:
            code = generate_view(app_name, rel, swift_path)
            out_file = out_dir / f"LpspAwesome{slug(app_name)}View.swift"
            out_file.write_text(code, encoding="utf-8")
            registry_entries.append((app_name, slug(app_name)))
            print(f"generated {out_file.name}")
        except Exception as exc:
            print(f"FAILED {app_name}: {exc}", file=sys.stderr)
            failed.append(f"{app_name} ({exc})")

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
    router_path = out_dir.parent / "AwesomeShowroomRouter.swift"
    router_path.write_text(registry, encoding="utf-8")
    print(f"updated {router_path}")

    # Plans is canonical LPSP name; Google Maps is legacy alias only (not on showroom grid).
    tier_names = [name for name in APP_PATHS if name != "Google Maps"]
    tier_list = "\n".join(f'        "{name}",' for name in tier_names)
    catalog = f'''import Foundation

enum AwesomeShowroomCatalog {{
    static let tierApps: [String] = [
{tier_list}
    ]
}}
'''
    catalog_path = Path("LostPhone/LostPhone/Core/Services/AwesomeShowroomCatalog.swift")
    catalog_path.parent.mkdir(parents=True, exist_ok=True)
    catalog_path.write_text(catalog, encoding="utf-8")

    if failed:
        print(f"\n{len(failed)} app(s) failed:", file=sys.stderr)
        for f in failed:
            print(f"  - {f}", file=sys.stderr)
    print(f"\nDone: {len(registry_entries)}/{len(APP_PATHS)} apps generated.")
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
