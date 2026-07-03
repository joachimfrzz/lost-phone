"""Assemble showroom root views using spec-extracted components."""

from __future__ import annotations

from awesome_templates import category_from_path, extract_tabs, pick_color


def _tabs_or_default(md: str, category: str) -> list[tuple[str, str]]:
    tabs = extract_tabs(md)
    defaults: dict[str, list[tuple[str, str]]] = {
        "messaging": [("Chats", "message.fill"), ("Appels", "phone.fill"), ("Réglages", "gearshape.fill")],
        "social": [("Accueil", "house.fill"), ("Explorer", "magnifyingglass"), ("Profil", "person.circle")],
        "video": [("Accueil", "house.fill"), ("Nouveautés", "play.rectangle"), ("Profil", "person.crop.circle")],
        "music": [("Accueil", "house.fill"), ("Rechercher", "magnifyingglass"), ("Bibliothèque", "books.vertical")],
        "finance": [("Accueil", "house.fill"), ("Cartes", "creditcard.fill"), ("Plus", "ellipsis")],
        "dating": [("Découvrir", "flame.fill"), ("Messages", "bubble.left"), ("Profil", "person.fill")],
        "fitness": [("Fil", "house.fill"), ("Carte", "map.fill"), ("Vous", "person.fill")],
        "travel": [("Explorer", "safari"), ("Rechercher", "magnifyingglass"), ("Voyages", "suitcase")],
        "food": [("Accueil", "house.fill"), ("Rechercher", "magnifyingglass"), ("Compte", "person")],
        "maps": [("Carte", "map.fill"), ("Itinéraire", "arrow.triangle.turn.up.right.diamond"), ("Profil", "person")],
        "ai": [("Chat", "bubble.left.fill"), ("Historique", "clock")],
        "commerce": [("Accueil", "house.fill"), ("Panier", "cart.fill")],
        "productivity": [("Accueil", "folder.fill"), ("Récents", "clock")],
        "misc": [("Accueil", "house.fill"), ("Explorer", "magnifyingglass")],
    }
    return tabs if tabs else defaults.get(category, defaults["misc"])


def _find_component(components: set[str], *needles: str) -> str | None:
    for c in sorted(components, key=len, reverse=True):
        for n in needles:
            if n.lower() in c.lower():
                return c
    return None


def assemble_root(
    app_name: str,
    prefix: str,
    category: str,
    md: str,
    components: set[str],
    token_names: list[str],
) -> str:
    tabs = _tabs_or_default(md, category)
    root = f"{prefix}ShowroomRoot"
    tokens = f"{prefix}Tokens"
    canvas = pick_color([(t, "") for t in token_names], "canvas", "Canvas", "background", "surface", default_idx=0)
    accent = pick_color([(t, "") for t in token_names], "brand", "coral", "action", "accent", "yellow", "red", "green", "primary", default_idx=0)
    dark_categories = {"video", "music", "fitness"}
    color_scheme = (
        ".preferredColorScheme(.dark)"
        if category in dark_categories
        or any("netflix" in t.lower() or "spotify" in t.lower() for t in token_names)
        else ""
    )

    tab_views = []
    for i, (label, icon) in enumerate(tabs):
        screen = _screen_for_tab(prefix, category, label, components, tokens, accent, canvas, i)
        tab_views.append(
            f"""            {screen}
                .tabItem {{ Label("{label}", systemImage: "{icon}") }}
                .tag({i})"""
        )

    tint_line = f".tint({tokens}.{accent})" if accent in token_names else ""

    return f"""
private struct {root}: View {{
    @State private var selectedTab = 0
    var body: some View {{
        TabView(selection: $selectedTab) {{
{chr(10).join(tab_views)}
        }}
        {tint_line}
        {color_scheme}
    }}
}}

{ _screens_impl(prefix, category, components, tokens, accent, canvas, tabs) }
"""


def _screen_for_tab(
    prefix: str,
    category: str,
    label: str,
    components: set[str],
    tokens: str,
    accent: str,
    canvas: str,
    index: int,
) -> str:
    low = label.lower()
    if category == "messaging":
        if "chat" in low or "message" in low:
            return f"{prefix}ChatsTabScreen()"
        if "call" in low or "appel" in low:
            return f"{prefix}CallsTabScreen()"
        return f"{prefix}MessagingTabScreen(title: \"{label}\")"
    if category == "social":
        if any(x in low for x in ("accueil", "home", "feed")):
            return f"{prefix}FeedTabScreen()"
        if "explor" in low or "search" in low:
            return f"{prefix}ExploreTabScreen()"
        if "reel" in low:
            return f"{prefix}ReelsTabScreen()"
        if "profil" in low or "profile" in low:
            return f"{prefix}ProfileTabScreen()"
        return f"{prefix}SocialTabScreen(title: \"{label}\")"
    if category == "video":
        if "profil" in low or "netflix" in low or "watch" in low:
            return f"{prefix}ProfilePickerTabScreen()"
        return f"{prefix}VideoHomeTabScreen()"
    if category == "music":
        if "recherch" in low or "search" in low:
            return f"{prefix}MusicSearchTabScreen()"
        if "biblio" in low or "library" in low:
            return f"{prefix}MusicLibraryTabScreen()"
        return f"{prefix}MusicHomeTabScreen()"
    if category == "finance":
        if "carte" in low or "card" in low:
            return f"{prefix}FinanceCardsTabScreen()"
        return f"{prefix}FinanceHomeTabScreen()"
    if category == "dating":
        if "découv" in low or "discover" in low:
            return f"{prefix}DatingDiscoverTabScreen()"
        return f"{prefix}GenericTabScreen(title: \"{label}\", tabIndex: {index})"
    return f"{prefix}GenericTabScreen(title: \"{label}\", tabIndex: {index})"


def _screens_impl(
    prefix: str,
    category: str,
    components: set[str],
    tokens: str,
    accent: str,
    canvas: str,
    tabs: list[tuple[str, str]],
) -> str:
    chat_row = _find_component(components, "ChatListRow", "WAChatListRow")
    chat_screen = _find_component(components, "ChatScreen", "WAChatScreen")
    feed_post = _find_component(components, "FeedPost", "IGFeedPost")
    story_ring = _find_component(components, "StoryRing")
    post_card = _find_component(components, "PostCard", "RDPostCard")
    vote_col = _find_component(components, "VoteColumn", "RDVoteColumn")
    play_btn = _find_component(components, "PlayButton", "NetflixPlayButton")
    profile_picker = _find_component(components, "ProfilePicker")
    outgoing_bubble = _find_component(components, "OutgoingBubble", "WAOutgoingBubble")
    compose_bar = _find_component(components, "ComposeBar", "WAComposeBar")
    swipe_card = _find_component(components, "SwipeCard", "TinderCard")

    canvas_ref = f"{tokens}.{canvas}" if canvas else "Color(.systemBackground)"
    accent_ref = f"{tokens}.{accent}" if accent else "Color.accentColor"

    parts: list[str] = []

    # Generic fallback
    parts.append(
        f"""
private struct {prefix}GenericTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        NavigationStack {{
            List(0..<6, id: \\.self) {{ i in
                HStack(spacing: 12) {{
                    RoundedRectangle(cornerRadius: 8)
                        .fill({accent_ref}.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle({accent_ref}))
                    VStack(alignment: .leading) {{
                        Text("\\(title) \\(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }}
                }}
            }}
            .navigationTitle(title)
        }}
    }}
}}
"""
    )

    if category == "messaging":
        parts.append(_messaging_screens(prefix, tokens, canvas_ref, accent_ref, chat_row, chat_screen, outgoing_bubble, compose_bar))
    elif category == "social":
        parts.append(_social_screens(prefix, tokens, canvas_ref, accent_ref, feed_post, story_ring, post_card, vote_col))
    elif category == "video":
        parts.append(_video_screens(prefix, tokens, play_btn, profile_picker))
    elif category == "music":
        parts.append(_music_screens(prefix, tokens, canvas_ref, accent_ref))
    elif category == "finance":
        parts.append(_finance_screens(prefix, tokens, canvas_ref, accent_ref))
    elif category == "dating":
        parts.append(_dating_screens(prefix, tokens, accent_ref, swipe_card))
    else:
        parts.append(
            f"""
private struct {prefix}MessagingTabScreen: View {{
    let title: String
    var body: some View {{ {prefix}GenericTabScreen(title: title, tabIndex: 0) }}
}}
"""
        )

    return "\n".join(parts)


def _messaging_screens(prefix, tokens, canvas, accent, chat_row, chat_screen, outgoing, compose) -> str:
    row = chat_row or f"{prefix}PlaceholderChatRow"
    if not chat_row:
        row_def = f"""
private struct {prefix}PlaceholderChatRow: View {{
    let name: String
    let preview: String
    let time: String
    var body: some View {{
        HStack(spacing: 12) {{
            Circle().fill({accent}.opacity(0.2)).frame(width: 48, height: 48)
                .overlay(Text(String(name.prefix(1))).font(.headline).foregroundStyle({accent}))
            VStack(alignment: .leading) {{
                Text(name).font(.system(size: 17, weight: .semibold))
                Text(preview).font(.system(size: 15)).foregroundStyle(.secondary).lineLimit(1)
            }}
            Spacer()
            Text(time).font(.system(size: 12)).foregroundStyle(.secondary)
        }}
        .padding(.horizontal, 16)
        .frame(height: 72)
    }}
}}
"""
    else:
        row_def = ""

    list_body = f"""
                ForEach({prefix}DemoChats.chats) {{ chat in
                    NavigationLink {{
                        {prefix}ChatDetailScreen(chat: chat)
                    }} label: {{
                        {row}(avatar: Image(systemName: "person.circle.fill"), name: chat.name, preview: chat.preview, timestamp: chat.time, unreadCount: chat.unread, isPinned: false, isMuted: !chat.hasRing)
                    }}
                }}
""" if chat_row else f"""
                ForEach({prefix}DemoChats.chats) {{ chat in
                    NavigationLink {{
                        {prefix}ChatDetailScreen(chat: chat)
                    }} label: {{
                        {row}(name: chat.name, preview: chat.preview, time: chat.time)
                    }}
                }}
"""

    bubble_block = ""
    if outgoing:
        bubble_block = f"""
                    {outgoing}(text: "Salut, tu es dispo ?", timestamp: "10:24", isRead: true)
                    {outgoing.replace('Outgoing', 'Incoming') if 'Outgoing' in outgoing else prefix + 'IncomingBubbleWrapper'}(text: "Oui, j'arrive !")
"""
    else:
        bubble_block = f"""
                    {prefix}DemoBubble(text: "Salut, tu es dispo ?", outgoing: true)
                    {prefix}DemoBubble(text: "Oui, j'arrive !", outgoing: false)
"""

    compose_block = f"{compose}()" if compose else f"{prefix}DemoComposeBar()"

    return (
        row_def
        + f"""
private struct {prefix}DemoChat: Identifiable {{
    let id = UUID()
    let name: String
    let preview: String
    let time: String
    let unread: Int
    let hasRing: Bool
}}

private enum {prefix}DemoChats {{
    static let chats: [{prefix}DemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24", unread: 2, hasRing: true),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier", unread: 0, hasRing: false),
        .init(name: "Famille", preview: "Photo: vacances", time: "Lun.", unread: 5, hasRing: true),
    ]
}}

private struct {prefix}ChatsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{
{list_body}
            }}
            .listStyle(.plain)
            .navigationTitle("Chats")
        }}
    }}
}}

private struct {prefix}ChatDetailScreen: View {{
    let chat: {prefix}DemoChat
    var body: some View {{
        VStack(spacing: 0) {{
            ScrollView {{
                LazyVStack(spacing: 8) {{
{bubble_block}
                }}
                .padding(.vertical, 8)
            }}
            .background({canvas}.ignoresSafeArea())
            {compose_block}
        }}
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }}
}}

private struct {prefix}CallsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List({prefix}DemoChats.chats) {{ chat in
                HStack {{
                    Circle().fill({accent}.opacity(0.15)).frame(width: 40, height: 40)
                        .overlay(Image(systemName: "phone.fill").foregroundStyle({accent}))
                    VStack(alignment: .leading) {{
                        Text(chat.name).font(.system(size: 17, weight: .semibold))
                        Text("Appel vocal · Hier").font(.subheadline).foregroundStyle(.secondary)
                    }}
                    Spacer()
                    Image(systemName: "info.circle").foregroundStyle(.secondary)
                }}
            }}
            .navigationTitle("Appels")
        }}
    }}
}}

private struct {prefix}MessagingTabScreen: View {{
    let title: String
    var body: some View {{ {prefix}GenericTabScreen(title: title, tabIndex: 0) }}
}}

private struct {prefix}DemoBubble: View {{
    let text: String
    var outgoing: Bool = true
    var body: some View {{
        HStack {{
            if outgoing {{ Spacer(minLength: 60) }}
            Text(text)
                .font(.system(size: 17))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? {accent}.opacity(0.2) : Color(.systemGray5)))
            if !outgoing {{ Spacer(minLength: 60) }}
        }}
        .padding(.horizontal, 8)
    }}
}}

private struct {prefix}DemoComposeBar: View {{
    @State private var text = ""
    var body: some View {{
        HStack {{
            TextField("Message", text: $text)
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill")
                .foregroundStyle({accent})
                .font(.title2)
        }}
        .padding(8)
        .background(.ultraThinMaterial)
    }}
}}
"""
    )


def _social_screens(prefix, tokens, canvas, accent, feed_post, story_ring, post_card, vote_col) -> str:
    if post_card and vote_col:
        feed_body = f"""
                    ForEach({prefix}DemoPosts.items) {{ post in
                        {post_card}(
                            subredditName: post.sub,
                            subredditAvatar: nil,
                            subredditAccent: {accent},
                            timestamp: post.time,
                            commentCount: post.comments,
                            title: post.title,
                            postText: post.body,
                            flairs: [],
                            mediaUri: nil,
                            baseKarma: post.karma
                        )
                    }}
"""
        demo_posts = f"""
private struct {prefix}DemoPostItem: Identifiable {{
    let id = UUID()
    let sub: String
    let title: String
    let body: String?
    let time: String
    let comments: Int
    let karma: Int
}}

private enum {prefix}DemoPosts {{
    static let items: [{prefix}DemoPostItem] = [
        .init(sub: "paris", title: "Meilleur café du 11e ?", body: "Je cherche vos recommandations…", time: "2 h", comments: 48, karma: 128),
        .init(sub: "swiftui", title: "Spectr + SwiftUI", body: nil, time: "5 h", comments: 22, karma: 89),
    ]
}}
"""
    elif feed_post:
        feed_body = f"""
                    ForEach({prefix}DemoPosts.items.indices, id: \\.self) {{ i in
                        let post = {prefix}DemoPosts.items[i]
                        {feed_post}(
                            username: post.user,
                            avatar: Image(systemName: "person.circle.fill"),
                            photo: Image(systemName: "photo"),
                            likes: post.likes,
                            caption: post.caption,
                            timestamp: post.time
                        )
                    }}
"""
        demo_posts = f"""
private struct {prefix}DemoPostItem: Identifiable {{
    let id = UUID()
    let user: String
    let likes: Int
    let caption: String
    let time: String
}}

private enum {prefix}DemoPosts {{
    static let items: [{prefix}DemoPostItem] = [
        .init(user: "lost.phone", likes: 128, caption: "Showroom Lost Phone — Paris", time: "2 H"),
        .init(user: "alex.m", likes: 42, caption: "Week-end en Bretagne", time: "5 H"),
    ]
}}
"""
    else:
        feed_body = f"""
                    ForEach(0..<3, id: \\.self) {{ i in
                        {prefix}GenericFeedCard(index: i, accent: {accent})
                    }}
"""
        demo_posts = ""

    stories = ""
    if story_ring:
        stories = f"""
                    ScrollView(.horizontal, showsIndicators: false) {{
                        HStack(spacing: 14) {{
                            ForEach({prefix}DemoStories.items) {{ s in
                                VStack(spacing: 4) {{
                                    {story_ring}(avatar: Image(systemName: "person.circle.fill"), isUnread: s.unread)
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }}
                            }}
                        }}
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }}
"""
    else:
        stories = f"""
                    ScrollView(.horizontal, showsIndicators: false) {{
                        HStack(spacing: 14) {{
                            ForEach({prefix}DemoStories.items) {{ s in
                                VStack(spacing: 4) {{
                                    Circle().strokeBorder({accent}, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill({accent}.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }}
                            }}
                        }}
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }}
"""

    return (
        demo_posts
        + f"""
private struct {prefix}DemoStory: Identifiable {{
    let id = UUID()
    let name: String
    let unread: Bool
}}

private enum {prefix}DemoStories {{
    static let items: [{prefix}DemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}}

private struct {prefix}FeedTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 0) {{
{stories}
{feed_body}
                }}
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }}
    }}
}}

private struct {prefix}ExploreTabScreen: View {{
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                LazyVGrid(columns: cols, spacing: 2) {{
                    ForEach(0..<15, id: \\.self) {{ i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill({accent}.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }}
                }}
            }}
            .navigationTitle("Explorer")
        }}
    }}
}}

private struct {prefix}ReelsTabScreen: View {{
    var body: some View {{
        ZStack {{
            Color.black.ignoresSafeArea()
            VStack {{
                Spacer()
                Image(systemName: "play.rectangle.fill").font(.system(size: 64)).foregroundStyle(.white.opacity(0.85))
                Text("Reels").font(.title2.bold()).foregroundStyle(.white)
                Spacer()
            }}
        }}
    }}
}}

private struct {prefix}ProfileTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 16) {{
                    Circle().fill({accent}.gradient).frame(width: 88, height: 88)
                        .overlay(Text("LP").font(.title.bold()).foregroundStyle(.white))
                    Text("lost.phone").font(.system(size: 20, weight: .bold))
                    Text("Paris · Showroom").font(.subheadline).foregroundStyle(.secondary)
                    HStack(spacing: 32) {{
                        VStack {{ Text("128").font(.headline); Text("Publications").font(.caption) }}
                        VStack {{ Text("1,2 k").font(.headline); Text("Abonnés").font(.caption) }}
                        VStack {{ Text("340").font(.headline); Text("Abonnements").font(.caption) }}
                    }}
                }}
                .padding()
            }}
            .navigationTitle("Profil")
        }}
    }}
}}

private struct {prefix}SocialTabScreen: View {{
    let title: String
    var body: some View {{ {prefix}GenericTabScreen(title: title, tabIndex: 0) }}
}}

private struct {prefix}GenericFeedCard: View {{
    let index: Int
    let accent: Color
    var body: some View {{
        VStack(alignment: .leading, spacing: 8) {{
            HStack {{
                Circle().fill(accent.opacity(0.2)).frame(width: 32, height: 32)
                Text("utilisateur_\\(index)").font(.system(size: 14, weight: .semibold))
                Spacer()
            }}
            .padding(.horizontal, 12)
            RoundedRectangle(cornerRadius: 0).fill(accent.opacity(0.12)).frame(height: 280)
            HStack(spacing: 16) {{
                Image(systemName: "heart"); Image(systemName: "bubble.right"); Spacer(); Image(systemName: "bookmark")
            }}
            .font(.system(size: 22)).padding(.horizontal, 12).padding(.bottom, 12)
        }}
    }}
}}
"""
    )


def _video_screens(prefix, tokens, play_btn, profile_picker) -> str:
    play = f"{play_btn}(title: \"Lecture\", action: {{}})" if play_btn else "Button(\"Lecture\") {}.buttonStyle(.borderedProminent).tint(.red)"
    picker = (
        f"{profile_picker}(profiles: {prefix}DemoProfiles.items, onSelect: {{ _ in }})"
        if profile_picker
        else f"{prefix}DemoProfilePicker()"
    )

    return f"""
private struct {prefix}DemoProfile: Identifiable {{
    let id = UUID()
    let name: String
    let color: Color
    let isKids: Bool
}}

private enum {prefix}DemoProfiles {{
    static let items: [{prefix}DemoProfile] = [
        .init(name: "Lost Phone", color: .red, isKids: false),
        .init(name: "Enfants", color: .orange, isKids: true),
    ]
}}

private struct {prefix}VideoHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 16) {{
                    ZStack(alignment: .bottom) {{
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.08, green: 0.08, blue: 0.08), Color.black],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(height: 220)
                            .overlay(alignment: .center) {{
                                Image(systemName: "play.circle.fill").font(.system(size: 56)).foregroundStyle(.white.opacity(0.9))
                            }}
                        LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                            .frame(height: 80)
                    }}
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.horizontal, 12)
                    {play}
                        .padding(.horizontal, 12)
                    Text("Tendances").font(.system(size: 17, weight: .bold)).foregroundStyle(.white).padding(.horizontal, 12)
                    ScrollView(.horizontal, showsIndicators: false) {{
                        HStack(spacing: 8) {{
                            ForEach(0..<6, id: \\.self) {{ i in
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
                                    .frame(width: 110, height: 165)
                            }}
                        }}
                        .padding(.horizontal, 12)
                    }}
                }}
                .padding(.vertical, 8)
            }}
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("")
            .toolbarBackground(.hidden, for: .navigationBar)
        }}
    }}
}}

private struct {prefix}ProfilePickerTabScreen: View {{
    var body: some View {{
        {picker}
    }}
}}

private struct {prefix}DemoProfilePicker: View {{
    var body: some View {{
        ZStack {{
            Color.black.ignoresSafeArea()
            VStack(spacing: 32) {{
                Text("Qui regarde ?").font(.system(size: 32, weight: .bold)).foregroundStyle(.white)
                ForEach({prefix}DemoProfiles.items) {{ p in
                    VStack(spacing: 8) {{
                        Circle().fill(p.color).frame(width: 72, height: 72)
                        Text(p.name).foregroundStyle(.gray)
                    }}
                }}
            }}
        }}
    }}
}}
"""


def _music_screens(prefix, tokens, canvas, accent) -> str:
    return f"""
private struct {prefix}MusicHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 20) {{
                    Text("Bonsoir").font(.system(size: 28, weight: .bold)).padding(.horizontal)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
                        ForEach(0..<4, id: \\.self) {{ i in
                            RoundedRectangle(cornerRadius: 8).fill({accent}.opacity(0.15 + Double(i) * 0.05))
                                .frame(height: 100)
                                .overlay(alignment: .bottomLeading) {{
                                    Text("Playlist \\(i + 1)").font(.subheadline.bold()).padding(8)
                                }}
                        }}
                    }}
                    .padding(.horizontal)
                }}
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("")
        }}
    }}
}}

private struct {prefix}MusicSearchTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack {{
                HStack {{
                    Image(systemName: "magnifyingglass").foregroundStyle(.secondary)
                    Text("Artistes, titres ou podcasts").foregroundStyle(.secondary)
                    Spacer()
                }}
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                .padding()
                Spacer()
            }}
            .navigationTitle("Rechercher")
        }}
    }}
}}

private struct {prefix}MusicLibraryTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Titres likés", "Playlists", "Albums", "Artistes"], id: \\.self) {{ item in
                HStack {{
                    RoundedRectangle(cornerRadius: 4).fill({accent}.opacity(0.2)).frame(width: 48, height: 48)
                    Text(item).font(.body)
                }}
            }}
            .navigationTitle("Bibliothèque")
        }}
    }}
}}
"""


def _finance_screens(prefix, tokens, canvas, accent) -> str:
    return f"""
private struct {prefix}FinanceHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 20) {{
                    VStack(alignment: .leading, spacing: 4) {{
                        Text("Solde total").font(.subheadline).foregroundStyle(.secondary)
                        Text("2 847,50 €").font(.system(size: 36, weight: .bold))
                    }}
                    .padding(.horizontal)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [{accent}, {accent}.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {{
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }}
                        .padding(.horizontal)
                    Text("Transactions").font(.headline).padding(.horizontal)
                    ForEach({prefix}DemoTx.items) {{ tx in
                        HStack {{
                            Circle().fill({accent}.opacity(0.15)).frame(width: 40, height: 40)
                            VStack(alignment: .leading) {{ Text(tx.title); Text(tx.date).font(.caption).foregroundStyle(.secondary) }}
                            Spacer()
                            Text(tx.amount).font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(tx.amount.hasPrefix("-") ? Color.primary : Color.green)
                        }}
                        .padding(.horizontal)
                    }}
                }}
                .padding(.vertical)
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Accueil")
        }}
    }}
}}

private struct {prefix}FinanceCardsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            Text("Gérez vos cartes").padding().navigationTitle("Cartes")
        }}
    }}
}}

private struct {prefix}DemoTx: Identifiable {{
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    static let items: [{prefix}DemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €"),
    ]
}}
"""


def _dating_screens(prefix, tokens, accent, swipe_card) -> str:
    card = (
        f"""{swipe_card}(
                name: "Alex",
                age: 28,
                distance: "5 km",
                occupation: "Designer",
                photoURLs: []
            )"""
        if swipe_card
        else f"{prefix}DemoSwipeCard(accent: {accent})"
    )
    return f"""
private struct {prefix}DemoDatingProfile {{
    let name: String
    let age: Int
    let bio: String
    static let sample = {prefix}DemoDatingProfile(name: "Alex", age: 28, bio: "Paris · Photo · Voyage")
}}

private struct {prefix}DatingDiscoverTabScreen: View {{
    var body: some View {{
        ZStack {{
            Color(.systemBackground).ignoresSafeArea()
            {card}
        }}
    }}
}}

private struct {prefix}DemoSwipeCard: View {{
    let accent: Color
    var body: some View {{
        RoundedRectangle(cornerRadius: 16)
            .fill(LinearGradient(colors: [accent.opacity(0.3), .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            .frame(width: 320, height: 480)
            .overlay(alignment: .bottomLeading) {{
                VStack(alignment: .leading) {{
                    Text("Alex, 28").font(.title.bold()).foregroundStyle(.white)
                    Text("Paris · Photo · Voyage").foregroundStyle(.white.opacity(0.9))
                }}
                .padding(20)
            }}
    }}
}}
"""
