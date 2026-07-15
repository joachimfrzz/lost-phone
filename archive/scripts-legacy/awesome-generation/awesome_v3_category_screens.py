"""Category-specific showroom screen builders for Awesome v3 full Spectr fidelity."""

from __future__ import annotations


def ai_screens(
    prefix: str,
    canvas: str,
    accent: str,
    composer: str | None,
    user_bubble: str | None,
    assistant: str | None,
    sidebar: str | None,
    search_input: str | None,
    answer_block: str | None,
) -> str:
    if composer and "Composer" in composer:
        composer_block = f"""
            {composer}(
                text: .constant(""),
                onSend: {{}},
                onVoice: {{}},
                onAttach: {{}},
                onWebSearch: {{}}
            )
"""
    else:
        composer_block = f"{prefix}DemoComposeBar()"

    if user_bubble and assistant and "UserMessageBubble" in user_bubble:
        assistant_call = (
            f'{assistant}(content: "SwiftUI est le framework déclaratif d\'Apple pour construire des interfaces iOS.", onRegenerate: {{}}, onCopy: {{}}, onThumbUp: {{}}, onThumbDown: {{}})'
            if "AssistantMessage" in assistant
            else f'{assistant}(text: "SwiftUI est le framework déclaratif d\'Apple pour construire des interfaces iOS.")'
        )
        chat_body = f"""
                    {user_bubble}(text: "Explique-moi SwiftUI", attachmentUrl: nil)
                    {assistant_call}
"""
    elif user_bubble and assistant:
        assistant_call = (
            f'{assistant}(content: "Comment puis-je vous aider ?", onRegenerate: {{}}, onCopy: {{}}, onThumbUp: {{}}, onThumbDown: {{}})'
            if "AssistantMessage" in assistant
            else f'{assistant}(text: "Comment puis-je vous aider ?")'
        )
        chat_body = f"""
                    {user_bubble}(text: "Bonjour !")
                    {assistant_call}
"""
    else:
        chat_body = f"""
                    {prefix}DemoBubble(text: "Bonjour !", outgoing: true)
                    {prefix}DemoBubble(text: "Comment puis-je vous aider ?", outgoing: false)
"""

    if sidebar and "GPTSidebar" in sidebar:
        history_screen = f"""
private struct {prefix}AiHistoryTabScreen: View {{
    var body: some View {{
        {sidebar}(
            sections: [
                .init(title: "Aujourd'hui", items: [
                    .init(title: "Showroom Lost Phone", isPinned: true),
                    .init(title: "SwiftUI tips", isPinned: false),
                ]),
            ],
            onSelect: {{ _ in }}
        )
    }}
}}
"""
    elif search_input and answer_block:
        history_screen = f"""
private struct {prefix}AiHistoryTabScreen: View {{
    @State private var query = "Meilleurs cafés Paris"
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                {search_input}(text: $query, onSubmit: {{}}, onAttach: {{}})
                ScrollView {{
                    {answer_block}(content: AttributedString("Voici trois adresses recommandées…"), isStreaming: false)
                }}
            }}
            .padding()
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Historique")
        }}
    }}
}}
"""
    else:
        history_screen = f"""
private struct {prefix}AiHistoryTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Showroom Lost Phone", "SwiftUI tips"], id: \\.self) {{ Label($0, systemImage: "bubble.left") }}
            .navigationTitle("Historique")
        }}
    }}
}}
"""

    return f"""
private struct {prefix}DemoBubble: View {{
    let text: String
    var outgoing: Bool
    var body: some View {{
        HStack {{
            if outgoing {{ Spacer(minLength: 40) }}
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? {accent}.opacity(0.2) : Color(.systemGray5)))
            if !outgoing {{ Spacer(minLength: 40) }}
        }}
    }}
}}

private struct {prefix}DemoComposeBar: View {{
    @State private var text = ""
    var body: some View {{
        HStack {{
            TextField("Message…", text: $text).padding(10).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
            Image(systemName: "paperplane.fill").foregroundStyle({accent})
        }}
        .padding(8)
    }}
}}

private struct {prefix}AiChatTabScreen: View {{
    var body: some View {{
        VStack(spacing: 0) {{
            ScrollView {{
                LazyVStack(spacing: 12) {{
{chat_body}
                }}
                .padding()
            }}
            .background({canvas}.ignoresSafeArea())
            {composer_block}
        }}
    }}
}}

{history_screen}

private struct {prefix}AiTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        if tabIndex == 0 || title.lowercased().contains("chat") {{ {prefix}AiChatTabScreen() }}
        else {{ {prefix}AiHistoryTabScreen() }}
    }}
}}
"""


def commerce_screens(prefix: str, canvas: str, accent: str, top_nav: str | None, product_card: str | None) -> str:
    if top_nav:
        if "AmazonTopNav" in top_nav:
            nav_block = f"{top_nav}(onSearch: {{}}, onMicOrScan: {{}}).padding(.horizontal)"
        else:
            nav_block = f"{top_nav}(cartCount: 2, onSearch: {{}}).padding(.horizontal)"
    else:
        nav_block = ""
    if product_card:
        cards = f"""
                        {product_card}(
                            title: "Echo Dot (5e gen)",
                            rating: 4.5,
                            reviewCount: 12840,
                            price: "€49,99",
                            originalPrice: "€59,99",
                            isPrime: true,
                            deliveryLine: "Demain",
                            imageUrl: URL(string: "https://picsum.photos/seed/amz/200/200")
                        )
"""
    else:
        cards = """
                        ForEach(0..<4, id: \\.self) { _ in
                            RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.12)).frame(height: 120)
                        }
"""

    return f"""
private struct {prefix}CommerceHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                VStack(alignment: .leading, spacing: 12) {{
                    {nav_block}
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
{cards}
                    }}
                    .padding(.horizontal)
                }}
            }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Accueil")
        }}
    }}
}}

private struct {prefix}CommerceCartTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{ Label("Echo Dot", systemImage: "shippingbox"); Label("Coque iPhone", systemImage: "iphone") }}
            .navigationTitle("Panier")
        }}
    }}
}}

private struct {prefix}CommerceTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("accueil") || low.contains("home") {{ {prefix}CommerceHomeTabScreen() }}
        else if low.contains("panier") || low.contains("cart") {{ {prefix}CommerceCartTabScreen() }}
        else {{ {prefix}CommerceHomeTabScreen() }}
    }}
}}
"""


def food_screens(
    prefix: str,
    canvas: str,
    accent: str,
    restaurant_card: str | None,
    menu_row: str | None,
    basket_bar: str | None,
    order_tracking: str | None,
) -> str:
    if restaurant_card:
        if "UERestaurantCard" in restaurant_card:
            home = f"""
                    ForEach({prefix}DemoRestaurants.items, id: \\.name) {{ r in
                        {restaurant_card}(
                            name: r.name,
                            rating: String(format: "%.1f", r.rating),
                            eta: r.meta,
                            fee: r.fee,
                            photo: Image(systemName: "fork.knife")
                        )
                            .padding(.horizontal)
                    }}
"""
        else:
            home = f"""
                    ForEach({prefix}DemoRestaurants.items, id: \\.name) {{ r in
                        {restaurant_card}(name: r.name, meta: r.meta, rating: r.rating, fee: r.fee, badge: r.badge, badgeIsPromo: r.promo, imageName: "photo")
                            .padding(.horizontal)
                    }}
"""
    else:
        home = """
                    ForEach(0..<3, id: \\.self) { _ in RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.12)).frame(height: 140).padding(.horizontal) }
"""

    if menu_row:
        if "UEMenuItemRow" in menu_row:
            search = f"""
                    ForEach({prefix}DemoMenu.items, id: \\.title) {{ item in
                        {menu_row}(name: item.title, desc: item.sub, price: item.price, photo: Image(systemName: "fork.knife"), onAdd: {{}}).padding(.horizontal)
                    }}
"""
        elif "MenuItemRow" in menu_row:
            search = f"""
                    ForEach({prefix}DemoMenu.items, id: \\.title) {{ item in
                        {menu_row}(name: item.title, desc: item.sub, price: item.price, imageName: "photo", onAdd: {{}}).padding(.horizontal)
                    }}
"""
        else:
            search = f"""
                    ForEach({prefix}DemoMenu.items, id: \\.title) {{ item in
                        {menu_row}(title: item.title, subtitle: item.sub, price: item.price, quantity: .constant(1)).padding(.horizontal)
                    }}
"""
    else:
        search = """
                    ForEach(0..<4, id: \\.self) { i in HStack { Text("Plat \\(i+1)"); Spacer(); Text("€12") }.padding(.horizontal) }
"""

    if basket_bar and "StickyCartBar" in basket_bar:
        basket = f'.safeAreaInset(edge: .bottom) {{ {basket_bar}(count: 2, total: "€24,50", onView: {{}}) }}'
    elif basket_bar and "BasketBar" in basket_bar:
        basket = f'.safeAreaInset(edge: .bottom) {{ {basket_bar}(itemCount: 2, total: "€24,50", onTap: {{}}) }}'
    elif basket_bar:
        basket = f'.safeAreaInset(edge: .bottom) {{ {basket_bar}(itemCount: 2, subtotal: "€24,50", onCheckout: {{}}) }}'
    else:
        basket = ""

    if order_tracking and "OrderTrackingView" in order_tracking:
        orders = f"""{order_tracking}(
                route: [
                    CLLocationCoordinate2D(latitude: 48.86, longitude: 2.35),
                    CLLocationCoordinate2D(latitude: 48.87, longitude: 2.36),
                ],
                etaText: "Arrivée dans 12 min"
            )"""
    elif order_tracking:
        orders = f"{order_tracking}()"
    else:
        orders = 'List(["Commande en cours"], id: \\.self) { Label($0, systemImage: "bag") }'

    return f"""
private struct {prefix}DemoRestaurant {{ let name: String; let meta: String; let rating: Double; let fee: String; let badge: String?; let promo: Bool }}
private enum {prefix}DemoRestaurants {{
    static let items: [{prefix}DemoRestaurant] = [
        .init(name: "Sushi Shop", meta: "Japonais · 25 min", rating: 4.8, fee: "€1,99", badge: "Promo", promo: true),
        .init(name: "Pizza Roma", meta: "Italien · 20 min", rating: 4.6, fee: "€0,99", badge: nil, promo: false),
    ]
}}
private struct {prefix}DemoMenuItem {{ let title: String; let sub: String; let price: String }}
private enum {prefix}DemoMenu {{
    static let items: [{prefix}DemoMenuItem] = [
        .init(title: "Poke saumon", sub: "Riz, avocat", price: "€13,50"),
    ]
}}

private struct {prefix}FoodHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{ VStack(spacing: 16) {{ {home} }} .padding(.vertical) }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Accueil")
            {basket}
        }}
    }}
}}

private struct {prefix}FoodSearchTabScreen: View {{
    var body: some View {{ NavigationStack {{ ScrollView {{ VStack {{ {search} }} }} .navigationTitle("Rechercher") }} }}
}}

private struct {prefix}FoodOrdersTabScreen: View {{
    var body: some View {{ NavigationStack {{ {orders} .navigationTitle("Commandes") }} }}
}}

private struct {prefix}FoodAccountTabScreen: View {{
    var body: some View {{ NavigationStack {{ List {{ Label("Adresses", systemImage: "mappin"); Label("Paiements", systemImage: "creditcard") }} .navigationTitle("Compte") }} }}
}}

private struct {prefix}FoodTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if tabIndex == 0 || low.contains("home") || low.contains("accueil") {{ {prefix}FoodHomeTabScreen() }}
        else if low.contains("recherch") || low.contains("search") {{ {prefix}FoodSearchTabScreen() }}
        else if low.contains("command") || low.contains("order") || low.contains("activity") {{ {prefix}FoodOrdersTabScreen() }}
        else {{ {prefix}FoodAccountTabScreen() }}
    }}
}}
"""


def fitness_screens(prefix: str, canvas: str, accent: str, activity_card: str | None, record_btn: str | None) -> str:
    if activity_card:
        feed = f"""
                    {activity_card}(
                        athleteAvatar: Image(systemName: "person.circle.fill"),
                        athleteName: "Alex Martin",
                        timestamp: "Aujourd'hui · 07:42",
                        activityTitle: "Course matinale",
                        routeCoords: [CLLocationCoordinate2D(latitude: 48.86, longitude: 2.35), CLLocationCoordinate2D(latitude: 48.87, longitude: 2.36)],
                        distance: "5,2 km",
                        elapsed: "28:14",
                        pace: "5:26 /km",
                        kudosCount: 12
                    )
                    .padding(.horizontal)
"""
    else:
        feed = """
                    RoundedRectangle(cornerRadius: 12).fill(Color.gray.opacity(0.12)).frame(height: 100).padding(.horizontal)
"""

    rec_block = (
        f"{record_btn}(onRecord: {{}}).padding(.bottom, 40)"
        if record_btn and "RecordButton" in record_btn
        else f"{record_btn}(action: {{}}).padding(.bottom, 40)"
        if record_btn
        else 'Button("Enregistrer") {}.buttonStyle(.borderedProminent).padding(.bottom, 40)'
    )

    return f"""
private struct {prefix}FitnessFeedTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{ VStack(spacing: 12) {{ {feed} }} }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Fil")
        }}
    }}
}}

private struct {prefix}FitnessMapTabScreen: View {{
    var body: some View {{
        ZStack {{
            Color.gray.opacity(0.12).ignoresSafeArea()
            VStack {{ Spacer(); {rec_block} }}
        }}
    }}
}}

private struct {prefix}FitnessYouTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            VStack(spacing: 16) {{
                Circle().fill({accent}.gradient).frame(width: 72, height: 72)
                Text("lost.phone").font(.title2.bold())
            }}
            .navigationTitle("Vous")
        }}
    }}
}}

private struct {prefix}FitnessTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if low.contains("carte") || low.contains("map") {{ {prefix}FitnessMapTabScreen() }}
        else if low.contains("vous") || low.contains("profile") || low.contains("profil") {{ {prefix}FitnessYouTabScreen() }}
        else {{ {prefix}FitnessFeedTabScreen() }}
    }}
}}
"""


def calendar_screens(prefix: str, canvas: str, accent: str, event_card: str | None, month_cell: str | None, fab: str | None) -> str:
    if event_card:
        schedule = f"""
                    {event_card}(title: "Standup Lost Phone", timeRange: "9:00 – 9:30", location: "Zoom", calendarColor: {accent})
                    {event_card}(title: "Review Spectr", timeRange: "14:00 – 15:00", location: nil, calendarColor: {accent}.opacity(0.7))
                        .padding(.horizontal)
"""
    else:
        schedule = """
                    ForEach(0..<3, id: \\.self) { _ in RoundedRectangle(cornerRadius: 8).fill(Color.blue.opacity(0.15)).frame(height: 56).padding(.horizontal) }
"""

    if month_cell:
        month = f"""
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 4) {{
                        ForEach(1...28, id: \\.self) {{ day in
                            {month_cell}(day: day, isToday: day == 4, isCurrentMonth: true, events: [{accent}])
                        }}
                    }}
                    .padding()
"""
    else:
        month = 'Text("Vue mois").padding()'

    fab_overlay = f".overlay(alignment: .bottomTrailing) {{ {fab}(action: {{}}).padding() }}" if fab else ""

    return f"""
private struct {prefix}CalendarScheduleTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{ VStack(spacing: 12) {{ {schedule} }} }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Agenda")
            {fab_overlay}
        }}
    }}
}}

private struct {prefix}CalendarMonthTabScreen: View {{
    var body: some View {{ NavigationStack {{ ScrollView {{ {month} }} .navigationTitle("Mois") }} }}
}}

private struct {prefix}CalendarTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        if title.lowercased().contains("mois") || title.lowercased().contains("month") {{ {prefix}CalendarMonthTabScreen() }}
        else {{ {prefix}CalendarScheduleTabScreen() }}
    }}
}}
"""


def meetings_screens(
    prefix: str,
    canvas: str,
    accent: str,
    meeting_row: str | None,
    gallery_grid: str | None,
    channel_row: str | None,
    message_card: str | None,
) -> str:
    if meeting_row:
        meetings = f"""
                    {meeting_row}(time: "10:00", topic: "Standup Lost Phone", subtitle: "ID: 123 456 789", onJoin: {{}})
                    {meeting_row}(time: "14:00", topic: "Review Spectr", subtitle: "Récurrent", onJoin: {{}})
                        .padding(.vertical, 4)
"""
    else:
        meetings = """
                    ForEach(0..<3, id: \\.self) { i in HStack { Text("10:00"); Text("Réunion \\(i+1)") }.padding(.horizontal) }
"""

    if gallery_grid:
        chat = f"{gallery_grid}(participants: {prefix}DemoParticipants.items)"
    elif channel_row and message_card and "TeamsChannelRow" in channel_row:
        chat = f"""
                ScrollView {{
                    LazyVStack(alignment: .leading) {{
                        {channel_row}(channel: {prefix}DemoChannel.general, isActive: true)
                        {message_card}(author: "Alex", initials: "AM", presence: .available, timestamp: "10:24", postText: "Showroom prêt !", replyCount: 3)
                    }}
                }}
"""
    elif channel_row and message_card:
        chat = f"""
            VStack(spacing: 0) {{
                ScrollView {{
                    LazyVStack(alignment: .leading) {{
                        {channel_row}(name: "general", isUnread: false, mentionCount: 0, isActive: true)
                        {message_card}(senderName: "Alex", preview: "Showroom prêt", timestamp: "10:24", channelName: "general")
                    }}
                }}
            }}
"""
    else:
        chat = 'List(["Alex: Showroom prêt"], id: \\.self) { Text($0) }'

    teams_channel = ""
    if channel_row and "TeamsChannelRow" in (channel_row or ""):
        teams_channel = f"""
private enum {prefix}DemoChannel {{
    static let general = {prefix}Channel(name: "general", unread: false)
}}
"""

    participant_type = f"{prefix}Participant" if gallery_grid else f"{prefix}DemoParticipant"
    demo_participant_struct = ""
    if not gallery_grid:
        demo_participant_struct = f"""
private struct {prefix}DemoParticipant {{ let name: String; let isMuted: Bool; let isSpeaking: Bool }}
"""

    return f"""
{teams_channel}
{demo_participant_struct}
private enum {prefix}DemoParticipants {{
    static let items: [{participant_type}] = [
        .init(name: "Alex", isMuted: false, isSpeaking: true),
        .init(name: "Léa", isMuted: true, isSpeaking: false),
    ]
}}

private struct {prefix}MeetingsListTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{ VStack(spacing: 8) {{ {meetings} }} }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Meetings")
        }}
    }}
}}

private struct {prefix}MeetingsChatTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            {chat}
            .navigationTitle("Chat")
        }}
    }}
}}

private struct {prefix}MeetingsMailTabScreen: View {{
    var body: some View {{ NavigationStack {{ List(["Inbox", "Sent"], id: \\.self) {{ Label($0, systemImage: "envelope") }} .navigationTitle("Mail") }} }}
}}

private struct {prefix}MeetingsPhoneTabScreen: View {{
    var body: some View {{ NavigationStack {{ List(["Alex Martin", "Léa Dupont"], id: \\.self) {{ Label($0, systemImage: "phone") }} .navigationTitle("Phone") }} }}
}}

private struct {prefix}MeetingsMoreTabScreen: View {{
    var body: some View {{ NavigationStack {{ List(["Settings", "Help"], id: \\.self) {{ Label($0, systemImage: "gearshape") }} .navigationTitle("More") }} }}
}}

private struct {prefix}MeetingsTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if low.contains("meeting") || low.contains("video") || tabIndex == 0 {{ {prefix}MeetingsListTabScreen() }}
        else if low.contains("chat") || low.contains("team") {{ {prefix}MeetingsChatTabScreen() }}
        else if low.contains("mail") {{ {prefix}MeetingsMailTabScreen() }}
        else if low.contains("phone") {{ {prefix}MeetingsPhoneTabScreen() }}
        else {{ {prefix}MeetingsMoreTabScreen() }}
    }}
}}
"""


def files_screens(prefix: str, canvas: str, accent: str, file_row: str | None) -> str:
    if file_row and "DbxFileRow" in file_row:
        rows = f"""
                    ForEach({prefix}DemoFiles.items, id: \\.name) {{ f in
                        {file_row}(name: f.name, meta: f.meta, kind: f.kind, isSelected: false, onTap: {{}})
                    }}
"""
        file_enum = f"""
private struct {prefix}DemoFile {{ let name: String; let meta: String; let kind: {prefix}DbxFileKind }}
private enum {prefix}DemoFiles {{
    static let items: [{prefix}DemoFile] = [
        .init(name: "Showroom.pdf", meta: "Modifié hier", kind: .pdf),
        .init(name: "Screenshots", meta: "12 fichiers", kind: .folder),
    ]
}}
"""
    elif file_row:
        rows = f"""
                    ForEach({prefix}DemoFiles.items, id: \\.name) {{ f in
                        {file_row}(name: f.name, icon: f.icon, meta: f.meta, isSelected: false)
                    }}
"""
        file_enum = f"""
private struct {prefix}DemoFile {{ let name: String; let icon: String; let meta: String }}
private enum {prefix}DemoFiles {{
    static let items: [{prefix}DemoFile] = [
        .init(name: "Showroom.pdf", icon: "doc.fill", meta: "Modifié hier"),
        .init(name: "Screenshots", icon: "folder.fill", meta: "12 fichiers"),
    ]
}}
"""
    else:
        rows = """
                    ForEach(["Documents", "Photos", "Partages"], id: \\.self) { n in Label(n, systemImage: "folder") }
"""
        file_enum = ""

    return f"""
{file_enum}
private struct {prefix}FilesHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List {{ {rows} }}
            .navigationTitle("Fichiers")
        }}
    }}
}}

private struct {prefix}FilesRecentsTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            List(["Showroom.pdf", "Design.fig"], id: \\.self) {{ Label($0, systemImage: "clock") }}
            .navigationTitle("Récents")
        }}
    }}
}}

private struct {prefix}FilesTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        if title.lowercased().contains("récent") || title.lowercased().contains("recent") {{ {prefix}FilesRecentsTabScreen() }}
        else {{ {prefix}FilesHomeTabScreen() }}
    }}
}}
"""


def reader_screens(prefix: str, canvas: str, accent: str, library_cover: str | None, reading_page: str | None) -> str:
    if library_cover:
        library = f"""
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {{
                        ForEach({prefix}DemoBooks.items, id: \\.title) {{ b in
                        {library_cover}(imageUrl: nil, progress: b.progress, author: b.author)
                        }}
                    }}
                    .padding()
"""
    else:
        library = """
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(0..<6, id: \\.self) { _ in RoundedRectangle(cornerRadius: 4).fill(Color.gray.opacity(0.15)).frame(height: 120) }
                    }.padding()
"""

    if reading_page and "ReadingPage" in reading_page:
        read = f"""
            {reading_page}(
                chapter: "CHAPITRE I",
                title: "Le phare au matin",
                paragraphs: [
                    "La brume s'accrochait aux falaises comme une écharpe de laine mouillée.",
                    "Personne ne savait encore que cette matinée allait tout changer.",
                ],
                percent: 42,
                minsLeft: 18,
                settings: {prefix}KindleReadingSettings(),
                chromeShown: .constant(false)
            )
"""
        reading_tab = f"""
private struct {prefix}ReaderReadingTabScreen: View {{
    var body: some View {{
        ZStack {{
            {canvas}.ignoresSafeArea()
            {read}
        }}
    }}
}}
"""
    else:
        read = f"{reading_page}()" if reading_page else 'Text("Chapitre 1…").padding()'
        reading_tab = f"""
private struct {prefix}ReaderReadingTabScreen: View {{
    var body: some View {{
        ZStack {{
            {canvas}.ignoresSafeArea()
            {read}
        }}
    }}
}}
"""

    return f"""
private struct {prefix}DemoBook {{ let title: String; let author: String; let progress: Double }}
private enum {prefix}DemoBooks {{
    static let items: [{prefix}DemoBook] = [
        .init(title: "SwiftUI Patterns", author: "Meliwat", progress: 0.42),
        .init(title: "Design Systems", author: "Spectr", progress: 0.08),
    ]
}}

private struct {prefix}ReaderLibraryTabScreen: View {{
    var body: some View {{ NavigationStack {{ ScrollView {{ {library} }} .navigationTitle("Bibliothèque") }} }}
}}

{reading_tab}

private struct {prefix}ReaderTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if low.contains("read") || low.contains("lecture") {{ {prefix}ReaderReadingTabScreen() }}
        else {{ {prefix}ReaderLibraryTabScreen() }}
    }}
}}
"""


def shazam_screens(prefix: str, shazam_home: str | None, result_card: str | None) -> str:
    home = f"{shazam_home}()" if shazam_home else f"{prefix}DemoShazamPlaceholder()"
    result = f"""
private struct {prefix}ShazamLibraryTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{
                {result_card}(title: "Blinding Lights", artist: "The Weeknd", artwork: Image(systemName: "music.note"))
                    .padding()
            }}
            .navigationTitle("Bibliothèque")
        }}
    }}
}}
""" if result_card else f"""
private struct {prefix}ShazamLibraryTabScreen: View {{
    var body: some View {{ NavigationStack {{ List(["Blinding Lights — The Weeknd"], id: \\.self) {{ Text($0) }} .navigationTitle("Bibliothèque") }} }}
}}
"""

    placeholder = "" if shazam_home else f"""
private struct {prefix}DemoShazamPlaceholder: View {{
    var body: some View {{ Text("Shazam").font(.largeTitle) }}
}}
"""

    return f"""
{placeholder}
private struct {prefix}ShazamHomeTabScreen: View {{
    var body: some View {{ {home} }}
}}

{result}

private struct {prefix}ShazamTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        if tabIndex == 0 || title.lowercased().contains("shazam") || title.lowercased().contains("accueil") {{ {prefix}ShazamHomeTabScreen() }}
        else {{ {prefix}ShazamLibraryTabScreen() }}
    }}
}}
"""


def youtube_screens(
    prefix: str,
    canvas: str,
    accent: str,
    video_card: str | None,
    shorts_rail: str | None,
    mini_player: str | None,
) -> str:
    if video_card:
        home = f"""
                    {video_card}(
                        thumbnailURL: URL(string: "https://picsum.photos/seed/yt/320/180")!,
                        duration: "10:24",
                        isLive: false,
                        title: "Showroom Lost Phone",
                        channelName: "lost.phone",
                        channelAvatarURL: URL(string: "https://picsum.photos/seed/ytav/40/40")!,
                        viewCount: "12 k vues",
                        uploadedAgo: "il y a 2 j"
                    )
                    .padding(.horizontal)
"""
    else:
        home = """
                    ForEach(0..<4, id: \\.self) { _ in RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.12)).frame(height: 180).padding(.horizontal) }
"""

    if shorts_rail:
        shorts = f"""
        ZStack {{
            Color.black.ignoresSafeArea()
            VStack {{
                Spacer()
                HStack {{
                    Spacer()
                    {shorts_rail}(
                        creatorAvatarURL: URL(string: "https://picsum.photos/seed/ytcreator/44/44")!,
                        likeCount: "4,2 k",
                        commentCount: "120",
                        isLiked: .constant(true)
                    )
                }}
            }}
        }}
"""
    else:
        shorts = "Color.black.ignoresSafeArea()"

    return f"""
private struct {prefix}YoutubeHomeTabScreen: View {{
    var body: some View {{
        NavigationStack {{
            ScrollView {{ VStack(spacing: 12) {{ {home} }} }}
            .background({canvas}.ignoresSafeArea())
            .navigationTitle("Accueil")
        }}
    }}
}}

private struct {prefix}YoutubeShortsTabScreen: View {{
    var body: some View {{ {shorts} }}
}}

private struct {prefix}YoutubeSubscriptionsTabScreen: View {{
    var body: some View {{ NavigationStack {{ List(["lost.phone", "Apple Dev"], id: \\.self) {{ Label($0, systemImage: "play.rectangle") }} .navigationTitle("Abonnements") }} }}
}}

private struct {prefix}YoutubeLibraryTabScreen: View {{
    var body: some View {{ NavigationStack {{ List(["Historique", "Playlists"], id: \\.self) {{ Label($0, systemImage: "clock") }} .navigationTitle("Bibliothèque") }} }}
}}

private struct {prefix}YoutubeTabScreen: View {{
    let title: String
    let tabIndex: Int
    var body: some View {{
        let low = title.lowercased()
        if low.contains("short") {{ {prefix}YoutubeShortsTabScreen() }}
        else if low.contains("abonn") || low.contains("subscri") {{ {prefix}YoutubeSubscriptionsTabScreen() }}
        else if low.contains("biblio") || low.contains("library") {{ {prefix}YoutubeLibraryTabScreen() }}
        else {{ {prefix}YoutubeHomeTabScreen() }}
    }}
}}
"""
