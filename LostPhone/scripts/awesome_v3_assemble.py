"""Assemble showroom root views using spec-extracted components."""

from __future__ import annotations

from awesome_templates import category_from_path, extract_tabs, pick_color
from awesome_v3_category_screens import (
    ai_screens,
    calendar_screens,
    commerce_screens,
    files_screens,
    fitness_screens,
    food_screens,
    meetings_screens,
    reader_screens,
    shazam_screens,
    youtube_screens,
)
from awesome_v3_home_screens import HomeContext, spectr_home_screen


def _resolve_category(app_name: str, category: str, components: set[str]) -> str:
    """Map raw path category + extracted components to an assembler profile."""
    if app_name == "TikTok" or (
        _find_component(components, "CaptionOverlay") and _find_component(components, "ActionRail")
    ):
        return "short-video"
    if app_name == "YouTube" or _find_component(components, "ShortsActionRail"):
        return "youtube"
    if _find_component(components, "DCServerRail"):
        return "discord"
    if category == "ride" or _find_component(components, "UberMapView", "WhereToInput", "RideOptionCard"):
        return "ride"
    if category == "shazam" or _find_component(components, "ShazamHome", "ShazamButton"):
        return "shazam"
    if category == "files" or category == "productivity":
        if _find_component(components, "DbxFileRow", "DrawerRow"):
            return "files"
    return category


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
        "ride": [("Home", "house.fill"), ("Services", "square.grid.2x2.fill"), ("Activity", "clock.fill"), ("Account", "person.fill")],
        "short-video": [("Home", "house.fill"), ("Discover", "magnifyingglass"), ("Inbox", "tray.fill"), ("Profile", "person.fill")],
        "discord": [("Servers", "square.grid.2x2.fill"), ("Messages", "bubble.left.and.bubble.right.fill"), ("Notifications", "bell.fill"), ("You", "person.crop.circle.fill")],
        "shazam": [("Shazam", "waveform.circle")],
        "reader": [("Bibliothèque", "books.vertical"), ("Lecture", "book")],
        "meetings": [("Meetings", "video.fill"), ("Team Chat", "bubble.left.and.bubble.right.fill"), ("Mail", "envelope.fill"), ("Phone", "phone.fill"), ("More", "ellipsis")],
        "calendar": [("Agenda", "calendar"), ("Mois", "calendar.circle")],
        "youtube": [("Accueil", "house.fill"), ("Shorts", "play.rectangle.fill"), ("Abonnements", "play.square.stack"), ("Bibliothèque", "rectangle.stack")],
        "files": [("Fichiers", "folder.fill"), ("Récents", "clock")],
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
    category = _resolve_category(app_name, category, components)
    tabs = _tabs_or_default(md, category)
    root = f"{prefix}ShowroomRoot"
    tokens = f"{prefix}Tokens"
    canvas = pick_color([(t, "") for t in token_names], "canvas", "Canvas", "background", "surface", default_idx=0)
    accent = pick_color([(t, "") for t in token_names], "brand", "coral", "action", "accent", "yellow", "red", "green", "primary", default_idx=0)
    dark_categories = {"video", "music", "fitness", "short-video", "discord", "ride"}
    dark_tokens = any(
        x in t.lower()
        for t in token_names
        for x in ("netflix", "spotify", "revolut", "discord", "tiktok", "whatsapp", "dcchat", "wacanvas", "wawallpaper")
    )
    color_scheme = (
        ".preferredColorScheme(.dark)"
        if category in dark_categories or dark_tokens
        else ""
    )

    tab_views = []
    for i, (label, icon) in enumerate(tabs):
        screen = _screen_for_tab(app_name, prefix, category, label, components, tokens, accent, canvas, i)
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

{ _screens_impl(app_name, prefix, category, components, tokens, accent, canvas, tabs) }
"""


def _screen_for_tab(
    app_name: str,
    prefix: str,
    category: str,
    label: str,
    components: set[str],
    tokens: str,
    accent: str,
    canvas: str,
    index: int,
) -> str:
    if index == 0:
        return f"{prefix}SpectrHomeTabScreen()"
    low = label.lower()
    if category == "ride":
        return f"{prefix}RideTabScreen(title: \"{label}\", tabIndex: {index})"
    if category == "short-video":
        if any(x in low for x in ("home", "accueil", "feed")):
            return f"{prefix}ShortVideoFeedTabScreen()"
        if "discover" in low or "explor" in low:
            return f"{prefix}ShortVideoDiscoverTabScreen()"
        if "inbox" in low or "boîte" in low:
            return f"{prefix}ShortVideoInboxTabScreen()"
        if "profil" in low or "profile" in low:
            return f"{prefix}ShortVideoProfileTabScreen()"
        return f"{prefix}ShortVideoDiscoverTabScreen()"
    if category == "youtube":
        return f"{prefix}YoutubeTabScreen(title: \"{label}\", tabIndex: {index})"
    if category == "discord":
        if "server" in low:
            return f"{prefix}DiscordServersTabScreen()"
        if "message" in low or "chat" in low:
            return f"{prefix}DiscordMessagesTabScreen()"
        if "notif" in low:
            return f"{prefix}DiscordNotificationsTabScreen()"
        if "you" in low or "profil" in low:
            return f"{prefix}DiscordYouTabScreen()"
        return f"{prefix}DiscordYouTabScreen()"
    if category == "maps":
        return f"{prefix}MapsTabScreen(title: \"{label}\", tabIndex: {index})"
    if category == "travel":
        return f"{prefix}TravelTabScreen(title: \"{label}\", tabIndex: {index})"
    if category == "messaging":
        if "chat" in low or "message" in low:
            return f"{prefix}ChatsTabScreen()"
        if "call" in low or "appel" in low:
            return f"{prefix}CallsTabScreen()"
        if "update" in low or "status" in low:
            return f"{prefix}UpdatesTabScreen()"
        if "setting" in low or "réglage" in low:
            return f"{prefix}SettingsTabScreen()"
        if "communit" in low:
            return f"{prefix}CommunitiesTabScreen()"
        if "contact" in low:
            return f"{prefix}ContactsTabScreen()"
        return f"{prefix}MessagingTabScreen(title: \"{label}\")"
    if category == "social":
        if any(x in low for x in ("accueil", "home", "feed")):
            return f"{prefix}FeedTabScreen()"
        if "explor" in low or "search" in low:
            return f"{prefix}ExploreTabScreen()"
        if "reel" in low:
            return f"{prefix}ReelsTabScreen()"
        if "créer" in low or "create" in low:
            return f"{prefix}CreateTabScreen()"
        if "communit" in low:
            return f"{prefix}CommunitiesTabScreen()"
        if "profil" in low or "profile" in low:
            return f"{prefix}ProfileTabScreen()"
        return f"{prefix}SocialTabScreen(title: \"{label}\")"
    if category == "video":
        if "profil" in low or "netflix" in low or "watch" in low or "my " in low:
            return f"{prefix}ProfilePickerTabScreen()"
        if "download" in low:
            return f"{prefix}VideoDownloadsTabScreen()"
        if "new" in low or "hot" in low or "nouveaut" in low:
            return f"{prefix}VideoNewTabScreen()"
        return f"{prefix}VideoHomeTabScreen()"
    if category == "music":
        if "recherch" in low or "search" in low:
            return f"{prefix}MusicSearchTabScreen()"
        if "biblio" in low or "library" in low or "your library" in low:
            return f"{prefix}MusicLibraryTabScreen()"
        if "premium" in low or "now playing" in low:
            return f"{prefix}MusicNowPlayingTabScreen()"
        return f"{prefix}MusicHomeTabScreen()"
    if category == "finance":
        if "carte" in low or "card" in low:
            return f"{prefix}FinanceCardsTabScreen()"
        return f"{prefix}FinanceHomeTabScreen()"
    if category == "dating":
        if any(x in low for x in ("découv", "discover", "swipe", "flame")):
            return f"{prefix}DatingDiscoverTabScreen()"
        if "message" in low or "chat" in low or "bubble" in low:
            return f"{prefix}DatingMessagesTabScreen()"
        if "star" in low or "top" in low or "gold" in low or "standout" in low:
            return f"{prefix}DatingTopPicksTabScreen()"
        if "profil" in low or "person" in low:
            return f"{prefix}DatingProfileTabScreen()"
        return f"{prefix}DatingTabScreen(title: \"{label}\", tabIndex: {index})"
    _category_tab: dict[str, str] = {
        "ai": "AiTabScreen",
        "commerce": "CommerceTabScreen",
        "food": "FoodTabScreen",
        "fitness": "FitnessTabScreen",
        "calendar": "CalendarTabScreen",
        "meetings": "MeetingsTabScreen",
        "files": "FilesTabScreen",
        "reader": "ReaderTabScreen",
        "shazam": "ShazamTabScreen",
        "productivity": "FilesTabScreen",
        "misc": "AiTabScreen",
    }
    if category in _category_tab:
        return f"{prefix}{_category_tab[category]}(title: \"{label}\", tabIndex: {index})"
    return f"{prefix}GenericTabScreen(title: \"{label}\", tabIndex: {index})"


def _screens_impl(
    app_name: str,
    prefix: str,
    category: str,
    components: set[str],
    tokens: str,
    accent: str,
    canvas: str,
    tabs: list[tuple[str, str]],
) -> str:
    chat_row = _find_component(components, "ChatListRow", "WAChatListRow", "TgChatListRow")
    chat_screen = _find_component(components, "ChatScreen", "WAChatScreen")
    feed_post = _find_component(components, "FeedPost", "IGFeedPost")
    story_ring = _find_component(components, "StoryRing")
    post_card = _find_component(components, "PostCard", "RDPostCard")
    vote_col = _find_component(components, "VoteColumn", "RDVoteColumn")
    play_btn = _find_component(components, "PlayButton", "NetflixPlayButton")
    profile_picker = _find_component(components, "ProfilePicker")
    outgoing_bubble = _find_component(components, "OutgoingBubble", "WAOutgoingBubble")
    compose_bar = _find_component(components, "ComposeBar", "WAComposeBar", "DCComposeBar")
    swipe_card = _find_component(components, "SwipeCard", "TinderCard")
    map_view = _find_component(components, "UberMapView", "MapView")
    where_to = _find_component(components, "WhereToInput")
    ride_card = _find_component(components, "RideOptionCard")
    action_rail = _find_component(components, "ActionRail")
    caption_overlay = _find_component(components, "CaptionOverlay")
    server_rail = _find_component(components, "DCServerRail")
    message_row = _find_component(components, "DCMessageRow")
    channel_row = _find_component(components, "DCChannelRow")
    metal_card = _find_component(components, "MetalCardHero")
    tx_row = _find_component(components, "TransactionRow")
    track_row = _find_component(components, "TrackRow")
    now_playing = _find_component(components, "NowPlayingScreen")
    poster_row = _find_component(components, "PosterRow")
    top10_row = _find_component(components, "Top10Row")

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
        parts.append(_messaging_screens(prefix, tokens, canvas_ref, accent_ref, chat_row, chat_screen, outgoing_bubble, compose_bar, message_row))
    elif category == "discord":
        parts.append(_discord_screens(prefix, tokens, canvas_ref, accent_ref, server_rail, message_row, channel_row, compose_bar))
    elif category == "social":
        parts.append(_social_screens(prefix, tokens, canvas_ref, accent_ref, feed_post, story_ring, post_card, vote_col))
    elif category == "short-video":
        parts.append(_short_video_screens(prefix, tokens, canvas_ref, accent_ref, action_rail, caption_overlay, _find_component(components, "VideoScrubber")))
    elif category == "ride":
        parts.append(_ride_screens(prefix, tokens, canvas_ref, accent_ref, map_view, where_to, ride_card))
    elif category == "maps":
        parts.append(_maps_screens(prefix, tokens, canvas_ref, accent_ref, map_view))
    elif category == "travel":
        parts.append(_travel_screens(prefix, tokens, canvas_ref, accent_ref))
    elif category == "video":
        parts.append(_video_screens(prefix, tokens, play_btn, profile_picker, poster_row, top10_row))
    elif category == "music":
        parts.append(_music_screens(prefix, tokens, canvas_ref, accent_ref, track_row, now_playing))
    elif category == "finance":
        parts.append(_finance_screens(prefix, tokens, canvas_ref, accent_ref, metal_card, tx_row))
    elif category == "dating":
        parts.append(_dating_screens(prefix, tokens, accent_ref, swipe_card, components))
    elif category == "ai":
        parts.append(
            ai_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "Composer"),
                _find_component(components, "UserMessageBubble", "OutgoingBubble"),
                _find_component(components, "AssistantMessage"),
                _find_component(components, "GPTSidebar", "Sidebar"),
                _find_component(components, "SearchInput"),
                _find_component(components, "AnswerBlock"),
            )
        )
    elif category == "commerce":
        parts.append(
            commerce_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "TopNav", "AmazonTopNav"),
                _find_component(components, "ProductCard"),
            )
        )
    elif category == "food":
        parts.append(
            food_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "RestaurantCard"),
                _find_component(components, "MenuItemRow"),
                _find_component(components, "BasketBar", "StickyCartBar"),
                _find_component(components, "OrderTracking", "TrackingView"),
            )
        )
    elif category == "fitness":
        parts.append(
            fitness_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "ActivityCard"),
                _find_component(components, "RecordButton"),
            )
        )
    elif category == "calendar":
        parts.append(
            calendar_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "EventCard"),
                _find_component(components, "MonthCell"),
                _find_component(components, "FAB", "GcalFAB"),
            )
        )
    elif category == "meetings":
        parts.append(
            meetings_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "MeetingRow"),
                _find_component(components, "GalleryGrid"),
                _find_component(components, "ChannelRow"),
                _find_component(components, "MessageCard"),
            )
        )
    elif category == "files":
        parts.append(
            files_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "DbxFileRow", "FileRow", "DrawerRow"),
            )
        )
    elif category == "reader":
        parts.append(
            reader_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "LibraryCover"),
                _find_component(components, "ReadingPage"),
            )
        )
    elif category == "shazam":
        parts.append(
            shazam_screens(
                prefix,
                _find_component(components, "ShazamHome"),
                _find_component(components, "ShazamResultCard", "ResultCard"),
            )
        )
    elif category == "youtube":
        parts.append(
            youtube_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "VideoCard"),
                _find_component(components, "ShortsActionRail"),
                _find_component(components, "MiniPlayer"),
            )
        )
    elif category == "productivity":
        parts.append(
            files_screens(
                prefix,
                canvas_ref,
                accent_ref,
                _find_component(components, "DbxFileRow", "FileRow"),
            )
        )

    shazam_home = _find_component(components, "ShazamHome")
    composer = _find_component(components, "Composer")
    user_bubble = _find_component(components, "UserMessageBubble", "OutgoingBubble")
    assistant = _find_component(components, "AssistantMessage")
    video_card = _find_component(components, "VideoCard")
    scrubber = _find_component(components, "VideoScrubber")

    parts.append(
        spectr_home_screen(
            HomeContext(
                app_name=app_name,
                prefix=prefix,
                category=category,
                tokens=tokens,
                canvas=canvas,
                accent=accent,
                canvas_ref=canvas_ref,
                accent_ref=accent_ref,
                components=components,
                feed_post=feed_post,
                story_ring=story_ring,
                post_card=post_card,
                vote_col=vote_col,
                chat_screen=chat_screen,
                outgoing_bubble=outgoing_bubble,
                compose_bar=compose_bar,
                now_playing=now_playing,
                map_view=map_view,
                where_to=where_to,
                ride_card=ride_card,
                action_rail=action_rail,
                caption_overlay=caption_overlay,
                swipe_card=swipe_card,
                play_btn=play_btn,
                poster_row=poster_row,
                top10_row=top10_row,
                metal_card=metal_card,
                shazam_home=shazam_home,
                composer=composer,
                user_bubble=user_bubble,
                assistant=assistant,
                video_card=video_card,
                server_rail=server_rail,
            )
        )
    )

    return "\n".join(parts)


def _messaging_screens(prefix, tokens, canvas, accent, chat_row, chat_screen, outgoing, compose, message_row=None) -> str:
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

    if chat_row and "TgChatListRow" in chat_row:
        row_call = (
            f'{row}(avatar: Image(systemName: "person.circle.fill"), name: chat.name, '
            f"preview: chat.preview, timestamp: chat.time, unreadCount: chat.unread, "
            f"isPinned: false, isMuted: !chat.hasRing)"
        )
    elif chat_row:
        row_call = (
            f'{row}(avatar: Image(systemName: "person.circle.fill"), name: chat.name, '
            f"preview: chat.preview, timestamp: chat.time, unreadCount: chat.unread, "
            f"hasStatusRing: chat.hasRing)"
        )
    else:
        row_call = f'{row}(name: chat.name, preview: chat.preview, time: chat.time)'

    list_body = f"""
                ForEach({prefix}DemoChats.chats) {{ chat in
                    NavigationLink {{
                        {prefix}ChatDetailScreen(chat: chat)
                    }} label: {{
                        {row_call}
                    }}
                }}
""" if chat_row else f"""
                ForEach({prefix}DemoChats.chats) {{ chat in
                    NavigationLink {{
                        {prefix}ChatDetailScreen(chat: chat)
                    }} label: {{
                        {row_call}
                    }}
                }}
"""

    bubble_block = ""
    if outgoing:
        if "MessengerOutgoingBubble" in outgoing:
            bubble_block = f"""
                    {prefix}DemoBubble(text: "Salut, tu es dispo ?", outgoing: true)
                    {prefix}DemoBubble(text: "Oui, j'arrive !", outgoing: false)
"""
        elif "WAOutgoingBubble" in outgoing:
            bubble_out = f'{outgoing}(text: "Salut, tu es dispo ?", timestamp: "10:24", readState: .read)'
            incoming = outgoing.replace("Outgoing", "Incoming") if "Outgoing" in outgoing else prefix + "IncomingBubbleWrapper"
            bubble_block = f"""
                    {bubble_out}
                    {incoming}(text: "Oui, j'arrive !")
"""
        elif "TgOutgoingBubble" in outgoing:
            bubble_out = f'{outgoing}(text: "Salut, tu es dispo ?", timestamp: "10:24", isRead: true)'
            incoming_type = outgoing.replace("Outgoing", "Incoming")
            bubble_block = f"""
                    {bubble_out}
                    {incoming_type}(text: "Oui, j'arrive !", senderName: nil, senderId: nil)
"""
        else:
            bubble_out = f'{outgoing}(text: "Salut, tu es dispo ?", timestamp: "10:24", isRead: true)'
            incoming = outgoing.replace("Outgoing", "Incoming") if "Outgoing" in outgoing else prefix + "IncomingBubbleWrapper"
            bubble_block = f"""
                    {bubble_out}
                    {incoming}(text: "Oui, j'arrive !")
"""
    else:
        bubble_block = f"""
                    {prefix}DemoBubble(text: "Salut, tu es dispo ?", outgoing: true)
                    {prefix}DemoBubble(text: "Oui, j'arrive !", outgoing: false)
"""

    if compose and "DCComposeBar" in compose:
        compose_block = f"{compose}(channelName: chat.name)"
    elif compose and "WAComposeBar" in compose:
        compose_block = f"{compose}()"
    elif compose:
        compose_block = f"{compose}()"
    else:
        compose_block = f"{prefix}DemoComposeBar()"

    detail_bg = canvas
    if "WAChatScreen" in (chat_screen or ""):
        detail_screen = f"""
private struct {prefix}ChatDetailScreen: View {{
    let chat: {prefix}DemoChat
    var body: some View {{
        {chat_screen}()
            .navigationTitle(chat.name)
            .navigationBarTitleDisplayMode(.inline)
    }}
}}
"""
    else:
        detail_screen = f"""
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
            .background({detail_bg}.ignoresSafeArea())
            {compose_block}
        }}
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }}
}}
"""

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

{detail_screen}

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
    var body: some View {{
        let low = title.lowercased()
        if low.contains("update") {{ {prefix}UpdatesTabScreen() }}
        else if low.contains("setting") || low.contains("réglage") {{ {prefix}SettingsTabScreen() }}
        else if low.contains("communit") {{ {prefix}CommunitiesTabScreen() }}
        else if low.contains("contact") {{ {prefix}ContactsTabScreen() }}
        else {{ {prefix}ChatsTabScreen() }}
    }}
}}

private struct {prefix}UpdatesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView(.horizontal, showsIndicators: false) {{
                HStack(spacing: 14) {{
                    ForEach({prefix}DemoStories.items) {{ s in
                        VStack(spacing: 4) {{
                            Circle().strokeBorder({accent}, lineWidth: 2).frame(width: 66, height: 66)
                            Text(s.name).font(.caption).lineLimit(1).frame(width: 72)
                        }}
                    }}
                }}
                .padding(.horizontal, 12).padding(.vertical, 10)
            }}
            .navigationTitle("Updates")
        }}
    }}
}}

private struct {prefix}DemoStoryItem: Identifiable {{ let id = UUID(); let name: String }}
private enum {prefix}DemoStories {{
    static let items: [{prefix}DemoStoryItem] = [
        .init(name: "Votre statut"), .init(name: "Alex"), .init(name: "Léa"),
    ]
}}

private struct {prefix}SettingsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{
                Section("Compte") {{ Label("Profil", systemImage: "person.circle"); Label("Confidentialité", systemImage: "lock") }}
                Section("App") {{ Label("Notifications", systemImage: "bell"); Label("Stockage", systemImage: "internaldrive") }}
            }}
            .navigationTitle("Settings")
        }}
    }}
}}

private struct {prefix}CommunitiesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Famille", "Équipe projet"], id: \\.self) {{ Label($0, systemImage: "person.3") }}
            .navigationTitle("Communities")
        }}
    }}
}}

private struct {prefix}ContactsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Alex Martin", "Léa Dupont"], id: \\.self) {{ Label($0, systemImage: "person.circle") }}
            .navigationTitle("Contacts")
        }}
    }}
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


def _discord_screens(prefix, tokens, canvas, accent, server_rail, message_row, channel_row, compose) -> str:
    rail = server_rail or f"{prefix}DemoServerRail"
    msg = message_row or f"{prefix}DemoMessageRow"
    ch = channel_row or f"{prefix}DemoChannelRow"
    compose_call = f"{compose}(channelName: \"general\")" if compose else f"{prefix}DemoComposeBar()"

    return f"""
private struct {prefix}DiscordDemoServer: Identifiable {{
    let id: String
    let name: String
    let initials: String
    let unreadCount: Int
    let mentionCount: Int
}}

private enum {prefix}DiscordDemoData {{
    static let servers: [{prefix}DiscordDemoServer] = [
        .init(id: "s1", name: "Lost Phone", initials: "LP", unreadCount: 0, mentionCount: 2),
        .init(id: "s2", name: "SwiftUI", initials: "SW", unreadCount: 3, mentionCount: 0),
        .init(id: "s3", name: "Paris", initials: "PA", unreadCount: 0, mentionCount: 0),
    ]
    static let channels = ["general", "showroom", "design-review"]
}}

private struct {prefix}DiscordServersTabScreen: View {{
    @State private var activeServerId: String? = "s1"
    var body: some View {{
        HStack(spacing: 0) {{
            {rail}(servers: {prefix}DiscordDemoData.servers.map {{
                {prefix}Server(id: $0.id, name: $0.name, imageUri: nil, initials: $0.initials, unreadCount: $0.unreadCount, mentionCount: $0.mentionCount)
            }}, activeServerId: $activeServerId)
            VStack(spacing: 0) {{
                ScrollView {{
                    LazyVStack(alignment: .leading, spacing: 0) {{
                        Text("TEXT CHANNELS").font(.caption.bold()).foregroundStyle(.secondary).padding(.horizontal, 12).padding(.top, 8)
                        ForEach(Array({prefix}DiscordDemoData.channels.enumerated()), id: \\.offset) {{ idx, name in
                            {ch}(name: name, type: .text, isActive: idx == 0, unreadCount: idx == 1 ? 2 : 0, mentionCount: idx == 0 ? 1 : 0)
                        }}
                        ForEach(0..<4, id: \\.self) {{ i in
                            {msg}(
                                avatar: Image(systemName: "person.circle.fill"),
                                username: i == 0 ? "Alex" : "Léa",
                                roleColor: {accent},
                                timestamp: "10:2\\(i)",
                                message: i == 0 ? "Showroom Spectr prêt !" : "Super rendu 👍",
                                presenceStatus: .online,
                                isGroupedWithPrevious: i > 0
                            )
                        }}
                    }}
                }}
                .background({canvas}.ignoresSafeArea())
                {compose_call}
            }}
        }}
        .background({canvas}.ignoresSafeArea())
    }}
}}

private struct {prefix}DiscordMessagesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{
                ForEach({prefix}DemoChats.chats) {{ chat in
                    NavigationLink {{
                        {prefix}DiscordDMDetailScreen(chat: chat)
                    }} label: {{
                        HStack(spacing: 12) {{
                            Circle().fill({accent}.opacity(0.2)).frame(width: 48, height: 48)
                            VStack(alignment: .leading) {{
                                Text(chat.name).font(.headline)
                                Text(chat.preview).font(.subheadline).foregroundStyle(.secondary).lineLimit(1)
                            }}
                            Spacer()
                            Text(chat.time).font(.caption).foregroundStyle(.secondary)
                        }}
                    }}
                }}
            }}
            .scrollContentBackground(.hidden)
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Messages")
        }}
    }}
}}

private struct {prefix}DiscordDMDetailScreen: View {{
    let chat: {prefix}DemoChat
    var body: some View {{
        VStack(spacing: 0) {{
            ScrollView {{
                LazyVStack(spacing: 8) {{
                    {msg}(
                        avatar: Image(systemName: "person.circle.fill"),
                        username: chat.name,
                        roleColor: {accent},
                        timestamp: "10:24",
                        message: "On se voit ce soir ?",
                        presenceStatus: .online,
                        isGroupedWithPrevious: false
                    )
                    {msg}(
                        avatar: Image(systemName: "person.circle.fill"),
                        username: "Vous",
                        roleColor: .white,
                        timestamp: "10:25",
                        message: "Oui, j'arrive !",
                        presenceStatus: .online,
                        isGroupedWithPrevious: false
                    )
                }}
                .padding(.vertical, 8)
            }}
            .background({canvas}.ignoresSafeArea())
            {compose_call}
        }}
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }}
}}

private struct {prefix}DiscordNotificationsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Mention in #general", "Nouveau message de Alex", "Invitation serveur"], id: \\.self) {{ item in
                Label(item, systemImage: "bell.fill")
            }}
            .scrollContentBackground(.hidden)
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Notifications")
        }}
    }}
}}

private struct {prefix}DiscordYouTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                Circle().fill({accent}.gradient).frame(width: 80, height: 80)
                Text("lost.phone").font(.title2.bold())
                Text("En ligne").foregroundStyle(.green)
            }}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("You")
        }}
    }}
}}

private struct {prefix}DemoChat: Identifiable {{
    let id = UUID()
    let name: String
    let preview: String
    let time: String
}}

private enum {prefix}DemoChats {{
    static let chats: [{prefix}DemoChat] = [
        .init(name: "Alex Martin", preview: "On se voit ce soir ?", time: "10:24"),
        .init(name: "Léa Dupont", preview: "Merci pour hier", time: "Hier"),
    ]
}}
"""


def _short_video_screens(prefix, tokens, canvas, accent, action_rail, caption_overlay, scrubber=None) -> str:
    rail = action_rail or f"{prefix}DemoActionRail"
    caption = caption_overlay or f"{prefix}DemoCaption"
    scrubber_view = scrubber or f"{prefix}DemoScrubber"

    return f"""
private struct {prefix}ShortVideoFeedTabScreen: View {{
    @State private var isFollowed = false
    @State private var isLiked = true
    @State private var likeCount = 12800
    var body: some View {{
        ZStack {{
            LinearGradient(
                colors: [Color(red: 0.1, green: 0.05, blue: 0.15), {canvas}, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {{
                Spacer()
                HStack(alignment: .bottom) {{
                    {caption}(username: "lost.phone", caption: "Showroom Lost Phone #fyp #swiftui", musicTitle: "Original Sound - lost.phone")
                    {rail}(
                        avatarURL: nil,
                        isFollowed: $isFollowed,
                        likeCount: $likeCount,
                        isLiked: $isLiked,
                        commentCount: 420,
                        bookmarkCount: 89,
                        shareCount: 156,
                        musicArtwork: nil
                    )
                }}
                {scrubber_view}(progress: 0.42)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }}
        }}
    }}
}}

private struct {prefix}ShortVideoDiscoverTabScreen: View {{
    let cols = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                LazyVGrid(columns: cols, spacing: 4) {{
                    ForEach(0..<12, id: \\.self) {{ i in
                        RoundedRectangle(cornerRadius: 4)
                            .fill({accent}.opacity(0.12 + Double(i) * 0.04))
                            .aspectRatio(9/16, contentMode: .fit)
                            .overlay(alignment: .bottomLeading) {{
                                Text("#trend \\(i + 1)").font(.caption.bold()).foregroundStyle(.white).padding(6)
                            }}
                    }}
                }}
                .padding(8)
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Discover")
        }}
    }}
}}

private struct {prefix}ShortVideoInboxTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Alex t'a mentionné", "Nouveau follower", "Live maintenant"], id: \\.self) {{ item in
                HStack {{
                    Circle().fill({accent}.opacity(0.2)).frame(width: 40, height: 40)
                    Text(item)
                }}
            }}
            .scrollContentBackground(.hidden)
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Inbox")
        }}
    }}
}}

private struct {prefix}ShortVideoProfileTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(spacing: 16) {{
                    Circle().fill({accent}.gradient).frame(width: 88, height: 88)
                        .overlay(Text("LP").font(.title.bold()).foregroundStyle(.white))
                    Text("@lost.phone").font(.title3.bold()).foregroundStyle(.white)
                    HStack(spacing: 24) {{
                        VStack {{ Text("128").bold(); Text("Following").font(.caption) }}
                        VStack {{ Text("12.4K").bold(); Text("Followers").font(.caption) }}
                        VStack {{ Text("89K").bold(); Text("Likes").font(.caption) }}
                    }}
                    .foregroundStyle(.white)
                }}
                .padding()
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Profile")
        }}
    }}
}}
"""


def _ride_screens(prefix, tokens, canvas, accent, map_view, where_to, ride_card) -> str:
    map_block = f"{map_view}().ignoresSafeArea()" if map_view else "Color.gray.opacity(0.2).ignoresSafeArea()"
    where = where_to or f"{prefix}DemoWhereTo()"
    ride_comp = ride_card or f"{prefix}DemoRideCard"

    return f"""
private struct {prefix}RideHomeTabScreen: View {{
    @State private var selectedRide = 0
    var body: some View {{
        ZStack(alignment: .top) {{
            {map_block}
            VStack {{
                Spacer()
                VStack(spacing: 0) {{
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 36, height: 4)
                        .padding(.top, 8)
                    {where}
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                    ForEach(Array({prefix}DemoRides.items.enumerated()), id: \\.offset) {{ idx, option in
                        {ride_comp}(
                            name: option.name,
                            eta: option.eta,
                            capacity: option.capacity,
                            price: option.price,
                            isSelected: selectedRide == idx,
                            carImage: Image(systemName: "car.fill"),
                            action: {{ selectedRide = idx }}
                        )
                        .padding(.horizontal, 12)
                    }}
                    .padding(.vertical, 8)
                }}
                .background(RoundedRectangle(cornerRadius: 16).fill({canvas}).ignoresSafeArea(edges: .bottom))
            }}
        }}
    }}
}}

private struct {prefix}DemoRideOption {{
    let name: String
    let eta: String
    let capacity: Int
    let price: String
}}

private enum {prefix}DemoRides {{
    static let items: [{prefix}DemoRideOption] = [
        .init(name: "UberX", eta: "3 min", capacity: 4, price: "€12.40"),
        .init(name: "Comfort", eta: "5 min", capacity: 4, price: "€16.80"),
        .init(name: "Green", eta: "4 min", capacity: 4, price: "€13.20"),
    ]
}}

private struct {prefix}RideServicesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["UberX", "Uber Black", "Uber Green", "Uber Eats"], id: \\.self) {{ Label($0, systemImage: "square.grid.2x2") }}
            .navigationTitle("Services")
        }}
    }}
}}

private struct {prefix}RideActivityTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Course vers Gare du Nord", "Uber Eats · Sushi Shop"], id: \\.self) {{ Label($0, systemImage: "clock") }}
            .navigationTitle("Activity")
        }}
    }}
}}

private struct {prefix}RideAccountTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{ Label("Paiements", systemImage: "creditcard"); Label("Sécurité", systemImage: "lock") }}
            .navigationTitle("Account")
        }}
    }}
}}

private struct {prefix}RideTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("home") {{ {prefix}RideHomeTabScreen() }}
        else if low.contains("service") {{ {prefix}RideServicesTabScreen() }}
        else if low.contains("activ") {{ {prefix}RideActivityTabScreen() }}
        else {{ {prefix}RideAccountTabScreen() }}
    }}
}}
"""


def _maps_screens(prefix, tokens, canvas, accent, map_view) -> str:
    map_block = f"{map_view}().ignoresSafeArea()" if map_view else "Color.gray.opacity(0.15).ignoresSafeArea()"
    return f"""
private struct {prefix}MapsHomeTabScreen: View {{
    var body: some View {{
        ZStack {{
            {map_block}
            VStack {{
                HStack {{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.ultraThinMaterial)
                        .frame(height: 48)
                        .overlay(HStack {{ Image(systemName: "magnifyingglass"); Text("Rechercher") }}.foregroundStyle(.secondary))
                        .padding()
                    Spacer()
                }}
                Spacer()
            }}
        }}
    }}
}}

private struct {prefix}MapsRoutesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Maison → Bureau", "Bureau → Gare"], id: \\.self) {{ Label($0, systemImage: "arrow.triangle.turn.up.right.diamond") }}
            .navigationTitle("Itinéraire")
        }}
    }}
}}

private struct {prefix}MapsProfileTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{ Label("Adresses enregistrées", systemImage: "mappin"); Label("Historique", systemImage: "clock") }}
            .navigationTitle("Profil")
        }}
    }}
}}

private struct {prefix}MapsTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("carte") || low.contains("map") || low.contains("home") {{ {prefix}MapsHomeTabScreen() }}
        else if low.contains("itin") || low.contains("route") {{ {prefix}MapsRoutesTabScreen() }}
        else {{ {prefix}MapsProfileTabScreen() }}
    }}
}}
"""


def _travel_screens(prefix, tokens, canvas, accent) -> str:
    return f"""
private struct {prefix}TravelExploreTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
                    ForEach(0..<6, id: \\.self) {{ i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill({accent}.opacity(0.1 + Double(i) * 0.05))
                            .frame(height: 180)
                            .overlay(alignment: .bottomLeading) {{
                                Text("Logement \\(i + 1)").font(.headline).padding(8)
                            }}
                    }}
                }}
                .padding()
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Explore")
        }}
    }}
}}

private struct {prefix}TravelTripsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Paris · 12–15 juil.", "Lisbonne · 3–7 août"], id: \\.self) {{ trip in
                Label(trip, systemImage: "airplane")
            }}
            .navigationTitle("Trips")
        }}
    }}
}}

private struct {prefix}TravelInboxTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Message hôte · Paris", "Rappel check-in"], id: \\.self) {{ msg in
                Label(msg, systemImage: "message")
            }}
            .navigationTitle("Inbox")
        }}
    }}
}}

private struct {prefix}TravelProfileTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                Circle().fill({accent}.gradient).frame(width: 72, height: 72)
                Text("lost.phone").font(.title2.bold())
            }}
            .navigationTitle("Profile")
        }}
    }}
}}

private struct {prefix}TravelWishlistsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Paris loft", "Bretagne bord de mer"], id: \\.self) {{ Label($0, systemImage: "heart") }}
            .navigationTitle("Wishlists")
        }}
    }}
}}

private struct {prefix}TravelTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if low.contains("wishlist") || low.contains("favori") {{ {prefix}TravelWishlistsTabScreen() }}
        else if low.contains("explor") || low.contains("search") || low.contains("recherch") {{ {prefix}TravelExploreTabScreen() }}
        else if low.contains("trip") || low.contains("voyage") {{ {prefix}TravelTripsTabScreen() }}
        else if low.contains("inbox") || low.contains("message") {{ {prefix}TravelInboxTabScreen() }}
        else if low.contains("profil") || low.contains("profile") {{ {prefix}TravelProfileTabScreen() }}
        else if tabIndex == 0 {{ {prefix}TravelExploreTabScreen() }}
        else {{ {prefix}TravelTripsTabScreen() }}
    }}
}}
"""


def _social_screens(prefix, tokens, canvas, accent, feed_post, story_ring, post_card, vote_col) -> str:
    if post_card and vote_col and "RDPostCard" in post_card:
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
    elif post_card and "FeedPostCard" in post_card:
        feed_body = f"""
                    ForEach({prefix}DemoPosts.items) {{ post in
                        {post_card}(
                            authorName: post.author,
                            connectionDegree: post.degree,
                            headline: post.headline,
                            timeAgo: post.time,
                            postText: post.text,
                            mediaImage: Image(systemName: "photo"),
                            isPremium: post.premium,
                            isOpenToWork: post.openToWork
                        )
                    }}
"""
        demo_posts = f"""
private struct {prefix}DemoPostItem: Identifiable {{
    let id = UUID()
    let author: String
    let degree: String
    let headline: String
    let time: String
    let text: String
    let premium: Bool
    let openToWork: Bool
}}

private enum {prefix}DemoPosts {{
    static let items: [{prefix}DemoPostItem] = [
        .init(author: "Alex Martin", degree: "1er", headline: "Designer · Lost Phone", time: "3 j •", text: "Showroom Lost Phone — clone Spectr en SwiftUI.", premium: true, openToWork: false),
        .init(author: "Léa Dupont", degree: "2e", headline: "iOS Engineer", time: "1 sem •", text: "Retour d'expérience sur la génération v3.", premium: false, openToWork: true),
    ]
}}
"""
    elif feed_post:
        feed_body = f"""
                    ForEach({prefix}DemoPosts.items) {{ post in
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

private struct {prefix}CommunitiesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["r/swiftui", "r/paris", "r/design"], id: \\.self) {{ Label($0, systemImage: "person.3") }}
            .navigationTitle("Communities")
        }}
    }}
}}

private struct {prefix}CreateTabScreen: View {{
    var body: some View {{
        VStack(spacing: 16) {{
            Image(systemName: "plus.app.fill").font(.system(size: 56)).foregroundStyle({accent})
            Text("Nouvelle publication").font(.title2.bold())
            Text("Photo, reel ou story").foregroundStyle(.secondary)
        }}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background({canvas}.ignoresSafeArea())
    }}
}}

private struct {prefix}SocialTabScreen: View {{
    let title: String
    var body: some View {{
        let low = title.lowercased()
        if low.contains("créer") || low.contains("create") {{ {prefix}CreateTabScreen() }}
        else if low.contains("explor") || low.contains("search") {{ {prefix}ExploreTabScreen() }}
        else if low.contains("reel") {{ {prefix}ReelsTabScreen() }}
        else if low.contains("profil") || low.contains("profile") {{ {prefix}ProfileTabScreen() }}
        else {{ {prefix}FeedTabScreen() }}
    }}
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


def _video_screens(prefix, tokens, play_btn, profile_picker, poster_row=None, top10_row=None) -> str:
    if play_btn and "DPPlayButton" in play_btn:
        play = f'{play_btn}(label: "Lecture", action: {{}})'
    elif play_btn:
        play = f'{play_btn}(title: "Lecture", action: {{}})'
    else:
        play = 'Button("Lecture") {}.buttonStyle(.borderedProminent).tint(.red)'
    if profile_picker:
        picker = f"""{profile_picker}(
            profiles: {prefix}DemoProfiles.items.map {{
                {profile_picker}.Profile(name: $0.name, avatarColor: $0.color, isKids: $0.isKids)
            }},
            onSelect: {{ _ in }}
        )"""
    else:
        picker = f"{prefix}DemoProfilePicker()"

    poster_block = ""
    if poster_row:
        poster_block = f"""
                    {poster_row}(title: "Trending Now", posters: {prefix}DemoPosterURLs.items)
                    {poster_row}(title: "Continue Watching", posters: {prefix}DemoPosterURLs.items)
"""
    if top10_row:
        poster_block += f"""
                    {top10_row}(posters: {prefix}DemoPosterURLs.items)
"""

    return f"""
private struct {prefix}DemoPosterURLs {{
    static let items: [URL] = [
        URL(string: "https://picsum.photos/seed/nfx1/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx2/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx3/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx4/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx5/200/300")!,
        URL(string: "https://picsum.photos/seed/nfx6/200/300")!,
    ]
}}
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
{poster_block}
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

private struct {prefix}VideoNewTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 16) {{
{poster_block if poster_row else ""}
                    Text("Nouveautés").font(.title2.bold()).foregroundStyle(.white).padding(.horizontal, 12)
                }}
                .padding(.vertical, 8)
            }}
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("New & Hot")
        }}
    }}
}}

private struct {prefix}VideoDownloadsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Stranger Things S4E1", "The Crown S6E2"], id: \\.self) {{ title in
                HStack {{
                    RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.3)).frame(width: 80, height: 120)
                    VStack(alignment: .leading) {{
                        Text(title).font(.headline).foregroundStyle(.white)
                        Text("Téléchargé").font(.caption).foregroundStyle(.secondary)
                    }}
                }}
            }}
            .scrollContentBackground(.hidden)
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Downloads")
        }}
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


def _music_screens(prefix, tokens, canvas, accent, track_row=None, now_playing=None) -> str:
    track_block = ""
    if track_row:
        track_block = f"""
                    ForEach({prefix}DemoTracks.items) {{ track in
                        {track_row}(
                            title: track.title,
                            artist: track.artist,
                            artwork: Image(systemName: "music.note"),
                            isPlaying: track.isPlaying
                        )
                    }}
"""
    else:
        track_block = """
                    ForEach(0..<4, id: \\.self) { i in
                        RoundedRectangle(cornerRadius: 8).fill(Color.white.opacity(0.08))
                            .frame(height: 56)
                            .padding(.horizontal)
                    }
"""

    now_playing_screen = ""
    if now_playing:
        now_playing_screen = f"""
private struct {prefix}MusicNowPlayingTabScreen: View {{
    var body: some View {{
        {now_playing}(
            trackTitle: "Blinding Lights",
            artist: "The Weeknd",
            artwork: Image(systemName: "music.note"),
            dominantColor: {accent}
        )
    }}
}}
"""

    return f"""
private enum {prefix}DemoTracks {{
    struct Item: Identifiable {{
        let id = UUID()
        let title: String
        let artist: String
        let isPlaying: Bool
    }}
    static let items: [Item] = [
        .init(title: "Blinding Lights", artist: "The Weeknd", isPlaying: true),
        .init(title: "As It Was", artist: "Harry Styles", isPlaying: false),
        .init(title: "Flowers", artist: "Miley Cyrus", isPlaying: false),
    ]
}}
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
                    Text("Récemment joué").font(.headline).padding(.horizontal)
{track_block}
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
{now_playing_screen}
"""


def _finance_screens(prefix, tokens, canvas, accent, metal_card=None, tx_row=None) -> str:
    hero_block = ""
    if metal_card:
        hero_block = f"""
                    {metal_card}()
                        .padding(.horizontal)
"""
    else:
        hero_block = f"""
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [{accent}, {accent}.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 180)
                        .overlay(alignment: .bottomLeading) {{
                            Text("•••• 4829").font(.title2.bold()).foregroundStyle(.white).padding(20)
                        }}
                        .padding(.horizontal)
"""

    tx_block = ""
    if tx_row:
        tx_block = f"""
                    ForEach({prefix}DemoTx.items) {{ tx in
                        {tx_row}(
                            merchant: tx.title,
                            meta: tx.date,
                            amount: tx.amount,
                            incoming: tx.incoming,
                            logo: Image(systemName: tx.icon)
                        )
                    }}
"""
    else:
        tx_block = f"""
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
"""

    cards_hero = f"{metal_card}()" if metal_card else f"RoundedRectangle(cornerRadius: 16).fill({accent}).frame(height: 180).padding(.horizontal)"

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
{hero_block}
                    Text("Transactions").font(.headline).padding(.horizontal)
{tx_block}
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
            ScrollView {{
                VStack(spacing: 16) {{
                    {cards_hero}
                    Text("Gérez vos cartes").font(.headline)
                }}
                .padding(.vertical)
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Cartes")
        }}
    }}
}}

private struct {prefix}DemoTx: Identifiable {{
    let id = UUID()
    let title: String
    let date: String
    let amount: String
    let incoming: Bool
    let icon: String
    static let items: [{prefix}DemoTx] = [
        .init(title: "Carrefour", date: "Aujourd'hui", amount: "-42,30 €", incoming: false, icon: "cart.fill"),
        .init(title: "Virement reçu", date: "Hier", amount: "+150,00 €", incoming: true, icon: "arrow.down.circle.fill"),
    ]
}}
"""


def _dating_swipe_card_call(swipe_card: str | None, prefix: str, accent: str) -> str:
    if swipe_card and "BumbleSwipeCard" in swipe_card:
        return f"""{swipe_card}(
                photos: [Image(systemName: "person.fill")],
                name: "Alex",
                age: 28,
                bio: "Paris · Photo · Voyage",
                isVerified: true
            )"""
    if swipe_card and "TinderSwipeCard" in swipe_card:
        return f"""{swipe_card}(
                name: "Alex",
                age: 28,
                distance: "5 km",
                occupation: "Designer",
                photoURLs: []
            )"""
    if swipe_card:
        return f"{swipe_card}(name: \"Alex\", age: 28, bio: \"Paris · Photo · Voyage\", isVerified: false)"
    return f"{prefix}DemoSwipeCard(accent: {accent})"


def _dating_screens(prefix, tokens, accent, swipe_card, components: set[str]) -> str:
    card = _dating_swipe_card_call(swipe_card, prefix, accent)
    photo_card = _find_component(components, "PhotoCard", "PromptCard", "StandoutsCard")
    chat_bubble = _find_component(components, "ChatBubble", "TinderChatBubble")

    messages_body = ""
    if chat_bubble and "TinderChatBubble" in chat_bubble:
        messages_body = f"""
                    {chat_bubble}(text: "Salut ! On se voit ce week-end ?", sender: .them)
                    {chat_bubble}(text: "Avec plaisir 😊", sender: .me)
"""
    elif chat_bubble:
        messages_body = f"""
                    {chat_bubble}(text: "Salut ! On se voit ce week-end ?", isOutgoing: false)
                    {chat_bubble}(text: "Avec plaisir 😊", isOutgoing: true)
"""
    else:
        messages_body = f"""
                    {prefix}DemoChatBubble(text: "Salut ! On se voit ce week-end ?", outgoing: false)
                    {prefix}DemoChatBubble(text: "Avec plaisir 😊", outgoing: true)
"""

    top_picks = ""
    if photo_card and "StandoutsCard" in photo_card:
        top_picks = f'{photo_card}(photo: Image(systemName: "person.fill"), answer: "Mon spot préféré à Paris", onSendRose: {{}})'
    elif photo_card and "PromptCard" in photo_card:
        top_picks = f"{photo_card}(question: \"Deux vérités et un mensonge\", answer: \"J'ai vécu au Japon\", onCommentTap: {{}})"
    elif photo_card and "PhotoCard" in photo_card:
        top_picks = f"{photo_card}(image: Image(systemName: \"person.fill\"), onCommentTap: {{}})"
    else:
        top_picks = f'{prefix}DemoSwipeCard(accent: {accent})'

    return f"""
private struct {prefix}DemoChatBubble: View {{
    let text: String
    var outgoing: Bool
    var body: some View {{
        HStack {{
            if outgoing {{ Spacer(minLength: 40) }}
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? {accent}.opacity(0.2) : Color(.systemGray5)))
            if !outgoing {{ Spacer(minLength: 40) }}
        }}.padding(.horizontal)
    }}
}}

private struct {prefix}DatingDiscoverTabScreen: View {{
    var body: some View {{
        ZStack {{
            Color(.systemBackground).ignoresSafeArea()
            {card}
        }}
    }}
}}

private struct {prefix}DatingMessagesTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 0) {{
                ScrollView {{ LazyVStack(spacing: 8) {{ {messages_body} }} .padding(.vertical) }}
                HStack {{
                    TextField("Message", text: .constant(""))
                        .padding(10).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
                }}.padding(8)
            }}
            .navigationTitle("Messages")
        }}
    }}
}}

private struct {prefix}DatingTopPicksTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{ {top_picks}.padding() }}
            .navigationTitle("Top Picks")
        }}
    }}
}}

private struct {prefix}DatingProfileTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                Circle().fill({accent}.gradient).frame(width: 88, height: 88)
                Text("Alex, 28").font(.title2.bold())
                Text("Paris · Design · Voyage").foregroundStyle(.secondary)
            }}
            .navigationTitle("Profil")
        }}
    }}
}}

private struct {prefix}DatingTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if low.contains("découv") || low.contains("discover") || low.contains("flame") || low.contains("swipe") {{ {prefix}DatingDiscoverTabScreen() }}
        else if low.contains("message") || low.contains("chat") {{ {prefix}DatingMessagesTabScreen() }}
        else if low.contains("star") || low.contains("top") {{ {prefix}DatingTopPicksTabScreen() }}
        else {{ {prefix}DatingProfileTabScreen() }}
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
