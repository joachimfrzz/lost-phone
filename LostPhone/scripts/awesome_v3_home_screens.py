"""Spectr gallery pixel-perfect home tab (index 0) for Awesome v3 showrooms."""

from __future__ import annotations

from dataclasses import dataclass, field

from awesome_v3_spectr_manifest import template_for_app


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


def _struct(prefix: str, body: str) -> str:
    return f"""
private struct {prefix}SpectrHomeTabScreen: View {{
    var body: some View {{
{body}
    }}
}}
"""


def _delegate(prefix: str, screen: str) -> str:
    return _struct(prefix, f"        {screen}()")


def _instagram(ctx: HomeContext) -> str:
    ring = ctx.story_ring or f"{ctx.prefix}SpectrStoryPlaceholder"
    post = ctx.feed_post or f"{ctx.prefix}SpectrPostPlaceholder"
    canvas = ctx.canvas_ref
    secondary = ".secondary"
    placeholder = ""
    if not ctx.story_ring:
        placeholder = f"""
private struct {ctx.prefix}SpectrStoryPlaceholder: View {{
    let avatar: Image
    let isUnread: Bool
    var body: some View {{
        Circle().strokeBorder({ctx.accent_ref}, lineWidth: 2).frame(width: 56, height: 56)
            .overlay(Circle().fill({ctx.accent_ref}.opacity(0.15)).frame(width: 48, height: 48))
    }}
}}
"""
    if not ctx.feed_post:
        placeholder += f"""
private struct {ctx.prefix}SpectrPostPlaceholder: View {{
    var body: some View {{
        VStack(alignment: .leading, spacing: 0) {{
            HStack(spacing: 10) {{
                Circle().fill({ctx.accent_ref}.opacity(0.2)).frame(width: 30, height: 30)
                Text("maya_c").font(.system(size: 13, weight: .semibold))
                Spacer()
                Image(systemName: "ellipsis")
            }}
            .padding(.horizontal, 14).frame(height: 48)
            Rectangle()
                .fill(LinearGradient(colors: [Color(red: 0.2, green: 0.12, blue: 0.3), Color(red: 0.82, green: 0.29, blue: 0.45)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .aspectRatio(1, contentMode: .fill)
            HStack(spacing: 16) {{
                Image(systemName: "heart.fill").foregroundStyle(Color(red: 0.93, green: 0.29, blue: 0.34))
                Image(systemName: "message")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: "bookmark")
            }}
            .font(.system(size: 22)).padding(.horizontal, 14).frame(height: 44)
            Text("1,247 likes").font(.system(size: 13, weight: .semibold)).padding(.horizontal, 14)
            Text("maya_c golden hour on the walk home").font(.system(size: 13)).padding(.horizontal, 14).padding(.top, 4)
            Text("2 HOURS AGO").font(.system(size: 11)).foregroundStyle({secondary}).padding(.horizontal, 14).padding(.top, 4)
        }}
    }}
}}
"""
    stories = f"""
                    ScrollView(.horizontal, showsIndicators: false) {{
                        HStack(spacing: 12) {{
                            ForEach({ctx.prefix}SpectrStories.items) {{ s in
                                VStack(spacing: 4) {{
                                    {ring}(avatar: Image(systemName: "person.circle.fill"), isUnread: s.unread, size: 56)
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 56)
                                }}
                            }}
                        }}
                        .padding(.horizontal, 14).padding(.vertical, 10)
                    }}
                    .overlay(alignment: .bottom) {{ Divider().background(Color(red: 0.15, green: 0.15, blue: 0.15)) }}
"""
    feed = f"""
                    {post}(
                        username: "maya_c",
                        avatar: Image(systemName: "person.circle.fill"),
                        photo: Image(systemName: "photo"),
                        likes: 1247,
                        caption: "golden hour on the walk home",
                        timestamp: "2 HOURS AGO"
                    )
"""
    body = f"""
        VStack(spacing: 0) {{
            HStack {{
                Text("Instagram")
                    .font(.custom("Snell Roundhand", size: 28))
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "heart").font(.system(size: 22))
                Image(systemName: "paperplane").font(.system(size: 22))
            }}
            .padding(.horizontal, 14)
            .padding(.top, 8)
            .padding(.bottom, 6)
            ScrollView {{
                VStack(spacing: 0) {{
{stories}
{feed}
                }}
            }}
        }}
        .background({canvas}.ignoresSafeArea())
        .preferredColorScheme(.dark)
"""
    demo = f"""
private struct {ctx.prefix}SpectrStoryItem: Identifiable {{
    let id = UUID()
    let name: String
    let unread: Bool
}}

private enum {ctx.prefix}SpectrStories {{
    static let items: [{ctx.prefix}SpectrStoryItem] = [
        .init(name: "Your story", unread: true),
        .init(name: "maya_c", unread: true),
        .init(name: "jordanp", unread: true),
        .init(name: "_alex", unread: false),
    ]
}}
"""
    return placeholder + demo + _struct(ctx.prefix, body)


def _whatsapp_chat(ctx: HomeContext) -> str:
    if ctx.chat_screen and "WAChatScreen" in ctx.chat_screen:
        return _delegate(ctx.prefix, ctx.chat_screen)
    return _messaging_thread(ctx, title="Maya Rivera", subtitle="online")


def _messaging_thread(ctx: HomeContext, title: str = "Contact", subtitle: str = "online") -> str:
    initials = title[:2].upper()
    bubbles = ""
    if ctx.outgoing_bubble and "WAOutgoingBubble" in ctx.outgoing_bubble:
        out = ctx.outgoing_bubble
        inc = out.replace("Outgoing", "Incoming")
        bubbles = f"""
                        {out}(text: "Morning! Did the mockups get sent over last night?", timestamp: "9:41", readState: .read)
                        {inc}(text: "Yes — check the shared folder 📁")
"""
    elif ctx.outgoing_bubble:
        out = ctx.outgoing_bubble
        inc = out.replace("Outgoing", "Incoming") if "Outgoing" in out else f"{ctx.prefix}DemoIncomingBubble"
        bubbles = f"""
                        {out}(text: "Morning! Did the mockups get sent over last night?", timestamp: "9:41", isRead: true)
                        {inc}(text: "Yes — check the shared folder")
"""
    else:
        bubbles = f"""
                        {ctx.prefix}SpectrBubble(text: "Morning! Did the mockups get sent over last night?", outgoing: false)
                        {ctx.prefix}SpectrBubble(text: "Yes — check the shared folder", outgoing: true)
"""
    compose = f"{ctx.compose_bar}()" if ctx.compose_bar else f"{ctx.prefix}DemoComposeBar()"
    extra = ""
    if not ctx.outgoing_bubble:
        extra = f"""
private struct {ctx.prefix}SpectrBubble: View {{
    let text: String
    let outgoing: Bool
    var body: some View {{
        HStack {{
            if outgoing {{ Spacer(minLength: 48) }}
            Text(text)
                .font(.system(size: 16))
                .padding(.horizontal, 12).padding(.vertical, 8)
                .background(outgoing ? {ctx.accent_ref}.opacity(0.85) : Color(.systemGray5))
                .foregroundStyle(outgoing ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            if !outgoing {{ Spacer(minLength: 48) }}
        }}
        .padding(.horizontal, 12)
    }}
}}
"""
    body = f"""
        VStack(spacing: 0) {{
            HStack(spacing: 12) {{
                Image(systemName: "chevron.left").font(.system(size: 17, weight: .semibold))
                Circle().fill({ctx.accent_ref}.opacity(0.25)).frame(width: 36, height: 36)
                    .overlay(Text("{initials}").font(.caption.bold()))
                VStack(alignment: .leading, spacing: 0) {{
                    Text("{title}").font(.system(size: 16, weight: .semibold))
                    Text("{subtitle}").font(.system(size: 12)).foregroundStyle(.secondary)
                }}
                Spacer()
                Image(systemName: "video").font(.system(size: 20))
                Image(systemName: "phone").font(.system(size: 20))
            }}
            .padding(.horizontal, 12).padding(.vertical, 8)
            ScrollView {{
                VStack(spacing: 8) {{
                    Text("Messages and calls are end-to-end encrypted.")
                        .font(.system(size: 12)).foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 8)
{bubbles}
                }}
                .padding(.vertical, 8)
            }}
            {compose}
        }}
        .background({ctx.canvas_ref}.ignoresSafeArea())
"""
    return extra + _struct(ctx.prefix, body)


def _spotify_np(ctx: HomeContext) -> str:
    if ctx.now_playing:
        return _struct(
            ctx.prefix,
            f"""        {ctx.now_playing}(
            trackTitle: "Midnight Wavelength",
            artist: "Nova Palmer",
            artwork: Image(systemName: "music.note"),
            dominantColor: {ctx.accent_ref}
        )
        .background({ctx.canvas_ref}.ignoresSafeArea())""",
        )
    return _delegate(ctx.prefix, f"{ctx.prefix}MusicNowPlayingTabScreen")


def _tiktok(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}ShortVideoFeedTabScreen")


def _uber_map(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}RideHomeTabScreen")


def _netflix_hero(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}VideoHomeTabScreen")


def _maps_google(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}MapsHomeTabScreen")


def _tinder_swipe(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}DatingDiscoverTabScreen")


def _ai_chat(ctx: HomeContext, model_label: str) -> str:
    if ctx.user_bubble and ctx.assistant and "UserMessageBubble" in (ctx.user_bubble or ""):
        chat = f"""
                        {ctx.user_bubble}(text: "Write me a short poem about Paris")
                        {ctx.assistant}(text: "Beneath the zinc and morning light,\\nThe Seine holds silver in its arms…")
"""
    else:
        chat = f"""
                        {ctx.prefix}SpectrBubble(text: "Write me a short poem about Paris", outgoing: true)
                        {ctx.prefix}SpectrBubble(text: "Beneath the zinc and morning light, the Seine holds silver in its arms…", outgoing: false)
"""
    compose = f"{ctx.composer}()" if ctx.composer else f"{ctx.prefix}DemoComposeBar()"
    extra = ""
    if not (ctx.user_bubble and ctx.assistant):
        extra = f"""
private struct {ctx.prefix}SpectrBubble: View {{
    let text: String
    let outgoing: Bool
    var body: some View {{
        HStack {{
            if outgoing {{ Spacer(minLength: 32) }}
            Text(text).font(.system(size: 16)).padding(12)
                .background(outgoing ? {ctx.accent_ref}.opacity(0.15) : Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            if !outgoing {{ Spacer(minLength: 32) }}
        }}
        .padding(.horizontal, 16)
    }}
}}
"""
    body = f"""
        VStack(spacing: 0) {{
            HStack {{
                Image(systemName: "line.3.horizontal").font(.title3)
                Spacer()
                Text("{model_label}").font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(Color(.systemGray6)).clipShape(Capsule())
                Spacer()
                Image(systemName: "square.and.pencil").font(.title3)
            }}
            .padding(.horizontal, 16).padding(.vertical, 10)
            ScrollView {{
                VStack(spacing: 16) {{
{chat}
                }}
                .padding(.vertical, 12)
            }}
            {compose}
        }}
        .background({ctx.canvas_ref}.ignoresSafeArea())
"""
    return extra + _struct(ctx.prefix, body)


def _social_feed(ctx: HomeContext) -> str:
    if ctx.feed_post:
        return _delegate(ctx.prefix, f"{ctx.prefix}FeedTabScreen")
    if ctx.post_card:
        return _delegate(ctx.prefix, f"{ctx.prefix}FeedTabScreen")
    return _delegate(ctx.prefix, f"{ctx.prefix}FeedTabScreen")


def _discord_rail(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}DiscordServersTabScreen")


def _shazam_listen(ctx: HomeContext) -> str:
    if ctx.shazam_home:
        return _delegate(ctx.prefix, ctx.shazam_home)
    return _delegate(ctx.prefix, f"{ctx.prefix}ShazamHomeTabScreen")


def _youtube_feed(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}YoutubeHomeTabScreen")


def _finance_revolut(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}FinanceHomeTabScreen")


def _commerce_amazon(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}CommerceHomeTabScreen")


def _food_eats(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}FoodHomeTabScreen")


def _travel_airbnb(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}TravelExploreTabScreen")


def _fitness_strava(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}FitnessFeedTabScreen")


def _calendar_home(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}CalendarScheduleTabScreen")


def _files_dropbox(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}FilesHomeTabScreen")


def _meetings_zoom(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}MeetingsChatTabScreen")


def _reader_kindle(ctx: HomeContext) -> str:
    return _delegate(ctx.prefix, f"{ctx.prefix}ReaderReadingTabScreen")


def _snapchat_camera(ctx: HomeContext) -> str:
    body = f"""
        ZStack {{
            Color.black.ignoresSafeArea()
            VStack {{
                HStack {{
                    Circle().fill(Color.yellow).frame(width: 32, height: 32)
                    Spacer()
                    Image(systemName: "magnifyingglass").foregroundStyle(.white)
                    Image(systemName: "person.badge.plus").foregroundStyle(.white)
                }}
                .padding()
                Spacer()
                Circle().strokeBorder(.white, lineWidth: 4).frame(width: 72, height: 72)
                    .overlay(Circle().fill(.white.opacity(0.15)).frame(width: 60, height: 60))
                Spacer()
            }}
        }}
"""
    return _struct(ctx.prefix, body)


def _pinterest_masonry(ctx: HomeContext) -> str:
    cols = "[GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]"
    body = f"""
        ScrollView {{
            LazyVGrid(columns: {cols}, spacing: 8) {{
                ForEach(0..<8, id: \\.self) {{ i in
                    RoundedRectangle(cornerRadius: 16)
                        .fill({ctx.accent_ref}.opacity(0.08 + Double(i) * 0.05))
                        .frame(height: CGFloat(120 + (i % 3) * 40))
                }}
            }}
            .padding(12)
        }}
        .background({ctx.canvas_ref}.ignoresSafeArea())
"""
    return _struct(ctx.prefix, body)


_TEMPLATES: dict[str, object] = {
    "instagram_feed": _instagram,
    "whatsapp_chat": _whatsapp_chat,
    "signal_thread": lambda c: _messaging_thread(c, "Renata Vogel", "1 week"),
    "telegram_chat": lambda c: _messaging_thread(c, "Alex Martin", "last seen recently"),
    "messenger_thread": lambda c: _messaging_thread(c, "Léa Dupont", "Active now"),
    "messaging_chat": _whatsapp_chat,
    "discord_rail": _discord_rail,
    "teams_home": lambda c: _delegate(c.prefix, f"{c.prefix}MeetingsChatTabScreen"),
    "tiktok_video": _tiktok,
    "snapchat_camera": _snapchat_camera,
    "x_feed": _social_feed,
    "reddit_feed": _social_feed,
    "linkedin_feed": _social_feed,
    "facebook_feed": _social_feed,
    "threads_feed": _social_feed,
    "pinterest_masonry": _pinterest_masonry,
    "tinder_swipe": _tinder_swipe,
    "bumble_swipe": _tinder_swipe,
    "hinge_profile": lambda c: _delegate(c.prefix, f"{c.prefix}DatingProfileTabScreen"),
    "happn_timeline": _tinder_swipe,
    "spotify_np": _spotify_np,
    "apple_music_np": _spotify_np,
    "deezer_np": _spotify_np,
    "soundcloud_np": _spotify_np,
    "ytmusic_np": _spotify_np,
    "shazam_listen": _shazam_listen,
    "audible_home": _reader_kindle,
    "youtube_feed": _youtube_feed,
    "netflix_hero": _netflix_hero,
    "disney_billboard": _netflix_hero,
    "prime_billboard": _netflix_hero,
    "appletv_home": _netflix_hero,
    "twitch_player": _netflix_hero,
    "ai_chatgpt": lambda c: _ai_chat(c, "ChatGPT"),
    "ai_gemini": lambda c: _ai_chat(c, "Gemini"),
    "ai_claude": lambda c: _ai_chat(c, "Claude"),
    "ai_perplexity": lambda c: _ai_chat(c, "Perplexity"),
    "ai_grok": lambda c: _ai_chat(c, "Grok"),
    "finance_revolut": _finance_revolut,
    "finance_wise": _finance_revolut,
    "finance_paypal": _finance_revolut,
    "finance_binance": _finance_revolut,
    "finance_coinbase": _finance_revolut,
    "commerce_amazon": _commerce_amazon,
    "uber_map": _uber_map,
    "food_eats": _food_eats,
    "food_deliveroo": _food_eats,
    "maps_waze": _maps_google,
    "maps_google": _maps_google,
    "travel_booking": _travel_airbnb,
    "travel_airbnb": _travel_airbnb,
    "travel_expedia": _travel_airbnb,
    "travel_flighty": _travel_airbnb,
    "travel_tripadvisor": _travel_airbnb,
    "fitness_strava": _fitness_strava,
    "calendar_home": _calendar_home,
    "files_dropbox": _files_dropbox,
    "meetings_zoom": _meetings_zoom,
    "reader_kindle": _reader_kindle,
    "social_feed": _social_feed,
}


def spectr_home_screen(ctx: HomeContext) -> str:
    """Return Swift source for {prefix}SpectrHomeTabScreen matching Spectr gallery preview."""
    template_id = template_for_app(ctx.app_name, ctx.category)
    renderer = _TEMPLATES.get(template_id, _social_feed)
    assert callable(renderer)
    return renderer(ctx)  # type: ignore[operator]
