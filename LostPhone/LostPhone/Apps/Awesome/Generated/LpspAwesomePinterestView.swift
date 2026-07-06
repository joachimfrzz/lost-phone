import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/pinterest
// Meliwat/awesome-ios-design-md/social/pinterest/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePinterestView: View {
    var body: some View {
        LpspPinterestShowroomRoot(store: LpspPinterestStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPinterestTokens {
    // MARK: - Brand
    static let pinterestRed        = Color(red: 0.902, green: 0.0,   blue: 0.137)  // #E60023
    static let pinterestRedPressed = Color(red: 0.678, green: 0.031, blue: 0.106)  // #AD081B
    static let pinterestRedHover   = Color(red: 0.8,   green: 0.0,   blue: 0.125)  // #CC0020

    // MARK: - Canvas (Light)
    static let pinterestCanvasLight   = Color.white                                 // #FFFFFF
    static let pinterestSurface1Light = Color(red: 0.973, green: 0.973, blue: 0.973) // #F8F8F8
    static let pinterestInputLight    = Color(red: 0.937, green: 0.937, blue: 0.937) // #EFEFEF
    static let pinterestDividerLight  = Color(red: 0.914, green: 0.914, blue: 0.914) // #E9E9E9

    // MARK: - Canvas (Dark)
    static let pinterestCanvasDark   = Color(red: 0.071, green: 0.071, blue: 0.071) // #121212
    static let pinterestSurface1Dark = Color(red: 0.118, green: 0.118, blue: 0.118) // #1E1E1E
    static let pinterestSurface2Dark = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let pinterestDividerDark  = Color(red: 0.180, green: 0.180, blue: 0.180) // #2E2E2E

    // MARK: - Text
    static let pinterestTextPrimaryLight   = Color(red: 0.067, green: 0.067, blue: 0.067) // #111111
    static let pinterestTextSecondaryLight = Color(red: 0.463, green: 0.463, blue: 0.463) // #767676
    static let pinterestTextTertiaryLight  = Color(red: 0.710, green: 0.710, blue: 0.710) // #B5B5B5
    static let pinterestTextPrimaryDark    = Color.white                                   // #FFFFFF
    static let pinterestTextSecondaryDark  = Color(red: 0.667, green: 0.667, blue: 0.667) // #AAAAAA

    // MARK: - Semantic
    static let pinterestSuccess = Color(red: 0.0, green: 0.541, blue: 0.235) // #008A3C
    static let pinterestInfo    = Color(red: 0.0, green: 0.455, blue: 0.910) // #0074E8
}

private enum LpspPinterestFonts {
    static let pinterestPinDetailTitle = Font.system(size: 28, weight: .regular)
    static let pinterestLargeTitle     = Font.system(size: 24, weight: .regular)
    static let pinterestSectionHeader  = Font.system(size: 20, weight: .regular)
    static let pinterestBoardName      = Font.system(size: 17, weight: .regular)
    static let pinterestPinTitle       = Font.system(size: 14, weight: .regular)
    static let pinterestUsername       = Font.system(size: 14, weight: .regular)
    static let pinterestBody           = Font.system(size: 15, weight: .regular)
    static let pinterestComment        = Font.system(size: 14, weight: .regular)
    static let pinterestMeta           = Font.system(size: 12, weight: .regular)
    static let pinterestButton         = Font.system(size: 16, weight: .regular)
    static let pinterestButtonSmall    = Font.system(size: 14, weight: .regular)
    static let pinterestTabLabel       = Font.system(size: 10, weight: .regular)
    static let pinterestMicro          = Font.system(size: 11, weight: .regular)

    // System fallback if Pinterest Sans isn't bundled
    static func pinterest(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

fileprivate struct LpspPinterestPinterestSaveButton: View {
    @Binding var isSaved: Bool
    var onTap: () -> Void = {}

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.8)) {
                isSaved.toggle()
            }
            onTap()
        } label: {
            Text(isSaved ? "Saved" : "Save")
                .font(LpspPinterestFonts.pinterestButton)
                .foregroundStyle(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    Capsule().fill(isSaved ? LpspPinterestTokens.pinterestTextPrimaryLight : LpspPinterestTokens.pinterestRed)
                )
        }
        .sensoryFeedback(.success, trigger: isSaved)
        .buttonStyle(LpspPinterestPinterestPressableStyle(pressedScale: 0.97))
    }
}

fileprivate struct LpspPinterestPinterestPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.75),
                       value: configuration.isPressed)
    }
}

fileprivate struct LpspPinterestPinterestPillButton: View {
    let title: String
    var style: LpspPinterestStyle = .primary
    let action: () -> Void

    enum LpspPinterestStyle { case primary, secondary }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LpspPinterestFonts.pinterestButton)
                .foregroundStyle(style == .primary ? .white : LpspPinterestTokens.pinterestTextPrimaryLight)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(
                    Capsule().fill(style == .primary ? LpspPinterestTokens.pinterestRed : LpspPinterestTokens.pinterestInputLight)
                )
        }
        .buttonStyle(LpspPinterestPinterestPressableStyle())
    }
}

fileprivate struct LpspPinterestPinTile: View {
    let imageURL: URL
    let title: String
    let creatorName: String
    let creatorAvatarURL: URL
    let aspectRatio: CGFloat  // width / height — e.g. 0.75 for a 3:4 pin
    let width: CGFloat
    @State private var isSaved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: imageURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Rectangle().fill(LpspPinterestTokens.pinterestSurface1Light)
                }
                .frame(width: width, height: width / aspectRatio)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                LpspPinterestPinterestSaveButton(isSaved: $isSaved)
                    .padding(12)
            }

            Text(title)
                .font(LpspPinterestFonts.pinterestPinTitle)
                .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                .lineLimit(2)
                .padding(.top, 4)

            HStack(spacing: 6) {
                AsyncImage(url: creatorAvatarURL) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Circle().fill(LpspPinterestTokens.pinterestSurface1Light)
                }
                .frame(width: 20, height: 20)
                .clipShape(Circle())

                Text(creatorName)
                    .font(LpspPinterestFonts.pinterestMeta)
                    .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)
                    .lineLimit(1)
            }
        }
    }
}

fileprivate struct LpspPinterestPin: Identifiable {
    let id = UUID()
    let imageURL: URL
    let aspectRatio: CGFloat
    let title: String
    let creatorName: String
    let creatorAvatarURL: URL
}

fileprivate struct LpspPinterestMasonryGrid: View {
    let pins: [LpspPinterestPin]
    let columnGap: CGFloat = 8
    let horizontalMargin: CGFloat = 16

    var body: some View {
        GeometryReader { geo in
            let columnWidth = (geo.size.width - horizontalMargin * 2 - columnGap) / 2
            let (left, right) = distribute(pins: pins, columnWidth: columnWidth)

            ScrollView {
                HStack(alignment: .top, spacing: columnGap) {
                    column(pins: left, width: columnWidth)
                    column(pins: right, width: columnWidth)
                }
                .padding(.horizontal, horizontalMargin)
                .padding(.vertical, 12)
            }
        }
    }

    private func column(pins: [LpspPinterestPin], width: CGFloat) -> some View {
        VStack(spacing: 8) {
            ForEach(pins) { pin in
                LpspPinterestPinTile(
                    imageURL: pin.imageURL,
                    title: pin.title,
                    creatorName: pin.creatorName,
                    creatorAvatarURL: pin.creatorAvatarURL,
                    aspectRatio: pin.aspectRatio,
                    width: width
                )
            }
        }
    }

    // Split pins into two columns by cumulative height so the shorter column gets the next pin.
    private func distribute(pins: [LpspPinterestPin], columnWidth: CGFloat) -> ([LpspPinterestPin], [LpspPinterestPin]) {
        var leftHeight: CGFloat = 0, rightHeight: CGFloat = 0
        var left: [LpspPinterestPin] = [], right: [LpspPinterestPin] = []
        for pin in pins {
            let h = columnWidth / pin.aspectRatio + 60 // ~60pt for caption + creator row
            if leftHeight <= rightHeight {
                left.append(pin); leftHeight += h + 8
            } else {
                right.append(pin); rightHeight += h + 8
            }
        }
        return (left, right)
    }
}

fileprivate struct LpspPinterestFloatingSearchBar: View {
    @Binding var query: String
    @State private var isVisible = true

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
            TextField("Search for ideas", text: $query)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
        }
        .padding(.horizontal, 18)
        .frame(height: 48)
        .background(
            Capsule().fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        )
        .padding(.horizontal, 16)
    }
}

fileprivate struct LpspPinterestPinDetailHero: View {
    let imageURL: URL
    let aspectRatio: CGFloat
    let title: String
    let description: String
    let creatorName: String
    let creatorAvatarURL: URL

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: imageURL) { img in
                        img.resizable().scaledToFill()
                    } placeholder: { LpspPinterestTokens.pinterestSurface1Light }
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    LpspPinterestPinterestSaveButton(isSaved: .constant(false))
                        .padding(12)
                }
                .padding(.horizontal, 16)

                HStack(spacing: 12) {
                    AsyncImage(url: creatorAvatarURL) { img in
                        img.resizable().scaledToFill()
                    } placeholder: { LpspPinterestTokens.pinterestSurface1Light }
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())

                    Text(creatorName)
                        .font(LpspPinterestFonts.pinterestBoardName)
                        .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                    Spacer()
                    LpspPinterestPinterestPillButton(title: "Follow") {}
                }
                .padding(.horizontal, 16)

                Text(title)
                    .font(LpspPinterestFonts.pinterestPinDetailTitle)
                    .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                    .padding(.horizontal, 16)

                Text(description)
                    .font(LpspPinterestFonts.pinterestBody)
                    .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                    .lineSpacing(3)
                    .padding(.horizontal, 16)
            }
        }
    }
}

fileprivate struct LpspPinterestPinterestTabBar: View {
    @Binding var selected: LpspPinterestTab

    enum LpspPinterestTab { case home, search, create, notifications, profile }

    var body: some View {
        HStack(spacing: 0) {
            tabButton(.home, icon: "house", filledIcon: "house.fill")
            tabButton(.search, icon: "magnifyingglass", filledIcon: "magnifyingglass")
            createButton
            tabButton(.notifications, icon: "bell", filledIcon: "bell.fill")
            tabButton(.profile, icon: "person", filledIcon: "person.fill")
        }
        .padding(.horizontal, 8)
        .frame(height: 56)
        .background(
            LpspPinterestTokens.pinterestCanvasLight
                .overlay(Rectangle().fill(LpspPinterestTokens.pinterestDividerLight).frame(height: 1), alignment: .top)
        )
    }

    private func tabButton(_ tab: LpspPinterestTab, icon: String, filledIcon: String) -> some View {
        Button {
            selected = tab
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            Image(systemName: selected == tab ? filledIcon : icon)
                .font(.system(size: 26, weight: .regular))
                .foregroundStyle(selected == tab ? LpspPinterestTokens.pinterestTextPrimaryLight : LpspPinterestTokens.pinterestTextSecondaryLight)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var createButton: some View {
        Button {
            selected = .create
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(RoundedRectangle(cornerRadius: 14).fill(LpspPinterestTokens.pinterestRed))
        }
        .frame(maxWidth: .infinity)
    }
}

fileprivate struct LpspPinterestPinterestRefreshSpinner: View {
    @State private var rotation: Double = 0

    var body: some View {
        Image("PinterestLogoP") // your asset — the red 'P' logomark
            .resizable()
            .scaledToFit()
            .frame(width: 28, height: 28)
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

fileprivate struct LpspPinterestSharedPinImage: View {
    let imageURL: URL
    let namespace: Namespace.ID
    let id: UUID
    var body: some View {
        AsyncImage(url: imageURL) { img in img.resizable().scaledToFill() } placeholder: { Color.gray }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .matchedGeometryEffect(id: id, in: namespace)
    }
}

// Fade-up entrance on newly loaded pins
// Apply on each LpspPinterestPinTile via .transition(.move(edge: .bottom).combined(with: .opacity))
// With insertion: .spring(response: 0.4, dampingFraction: 0.85)

// Idea LpspPinterestPin advance
// Use a TabView(selection:) with PageTabViewStyle and custom onTap logic for tap-left/right

// MARK: - Showroom data & store

private enum LpspPinterestShowroomTab: String, CaseIterable, Identifiable {
    case home, search, create, notifications, profile

    var id: String { rawValue }
}

private struct LpspPinterestShowroomPin: Identifiable, Equatable {
    let id: String
    let title: String
    let creator: String
    let gradient: [Color]
    let aspectRatio: CGFloat
    var isSaved: Bool
}

private enum LpspPinterestShowroomData {
    static let feedPins: [LpspPinterestShowroomPin] = [
        LpspPinterestShowroomPin(
            id: "kitchen",
            title: "Cozy rustic kitchen corner inspiration",
            creator: "hanaruiz",
            gradient: [Color(red: 0.72, green: 0.55, blue: 0.38), Color(red: 0.45, green: 0.32, blue: 0.22)],
            aspectRatio: 0.78,
            isSaved: false
        ),
        LpspPinterestShowroomPin(
            id: "garden",
            title: "Tiny garden ideas for small balconies",
            creator: "plantnook",
            gradient: [Color(red: 0.42, green: 0.68, blue: 0.45), Color(red: 0.22, green: 0.48, blue: 0.32)],
            aspectRatio: 0.92,
            isSaved: false
        ),
        LpspPinterestShowroomPin(
            id: "street",
            title: "Blue hour street",
            creator: "kvoss",
            gradient: [Color(red: 0.18, green: 0.32, blue: 0.62), Color(red: 0.08, green: 0.14, blue: 0.35)],
            aspectRatio: 0.68,
            isSaved: false
        ),
        LpspPinterestShowroomPin(
            id: "twilight",
            title: "Purple twilight sky",
            creator: "novap",
            gradient: [Color(red: 0.55, green: 0.38, blue: 0.78), Color(red: 0.28, green: 0.18, blue: 0.48)],
            aspectRatio: 0.75,
            isSaved: true
        ),
        LpspPinterestShowroomPin(
            id: "fall",
            title: "Golden fall walk",
            creator: "amberleaf",
            gradient: [Color(red: 0.92, green: 0.62, blue: 0.28), Color(red: 0.72, green: 0.38, blue: 0.18)],
            aspectRatio: 0.85,
            isSaved: false
        ),
        LpspPinterestShowroomPin(
            id: "breakfast",
            title: "Warm breakfast",
            creator: "slowplates",
            gradient: [Color(red: 0.95, green: 0.78, blue: 0.55), Color(red: 0.82, green: 0.52, blue: 0.32)],
            aspectRatio: 0.7,
            isSaved: false
        ),
    ]

    static let searchIdeas = ["Kitchen decor", "Balcony garden", "Blue hour photos", "Fall outfits"]

    static let notifications = [
        ("hanaruiz saved your pin", "2h"),
        ("plantnook followed you", "1d"),
        ("New ideas in Home decor", "2d"),
    ]
}

@MainActor
fileprivate final class LpspPinterestStore: ObservableObject {
    @Published var selectedTab: LpspPinterestShowroomTab = .home
    @Published var pins: [LpspPinterestShowroomPin] = LpspPinterestShowroomData.feedPins
    @Published var searchQuery = ""
    @Published var selectedPinID: String?

    var selectedPin: LpspPinterestShowroomPin? {
        guard let selectedPinID else { return nil }
        return pins.first { $0.id == selectedPinID }
    }

    func toggleSave(_ pinID: String) {
        pins = pins.map { pin in
            guard pin.id == pinID else { return pin }
            var copy = pin
            copy.isSaved.toggle()
            return copy
        }
    }

    func setSaved(_ pinID: String, to saved: Bool) {
        pins = pins.map { pin in
            guard pin.id == pinID else { return pin }
            var copy = pin
            copy.isSaved = saved
            return copy
        }
    }

    func openDetail(_ pinID: String) {
        selectedPinID = pinID
    }

    func closeDetail() {
        selectedPinID = nil
    }

    func moreLikeThis(excluding pinID: String) -> [LpspPinterestShowroomPin] {
        pins.filter { $0.id != pinID }.prefix(4).map { $0 }
    }
}

// MARK: - Écrans showroom

private struct LpspPinterestShowroomRoot: View {
    @ObservedObject var store: LpspPinterestStore

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch store.selectedTab {
                case .home:
                    LpspPinterestHomeTabScreen(store: store)
                case .search:
                    LpspPinterestSearchTabScreen(store: store)
                case .create:
                    LpspPinterestCreateTabScreen(store: store)
                case .notifications:
                    LpspPinterestNotificationsTabScreen()
                case .profile:
                    LpspPinterestShowroomProfileTabScreen()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LpspPinterestShowroomTabBar(store: store)
        }
        .background(LpspPinterestTokens.pinterestCanvasLight.ignoresSafeArea())
        .preferredColorScheme(.light)
        .sheet(isPresented: Binding(
            get: { store.selectedPinID != nil },
            set: { if !$0 { store.closeDetail() } }
        )) {
            if let pinID = store.selectedPinID,
               let pin = store.pins.first(where: { $0.id == pinID }) {
                LpspPinterestPinDetailSheet(store: store, pin: pin)
            }
        }
    }
}

private struct LpspPinterestShowroomTabBar: View {
    @ObservedObject var store: LpspPinterestStore

    var body: some View {
        HStack(spacing: 0) {
            tabButton(.home, icon: "house", filledIcon: "house.fill")
            tabButton(.search, icon: "magnifyingglass", filledIcon: "magnifyingglass")
            createButton
            tabButton(.notifications, icon: "bell", filledIcon: "bell.fill")
            tabButton(.profile, icon: "person", filledIcon: "person.fill")
        }
        .padding(.horizontal, 8)
        .frame(height: 56)
        .background(
            LpspPinterestTokens.pinterestCanvasLight
                .overlay(
                    Rectangle()
                        .fill(LpspPinterestTokens.pinterestDividerLight)
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }

    private func tabButton(_ tab: LpspPinterestShowroomTab, icon: String, filledIcon: String) -> some View {
        Button {
            store.selectedTab = tab
        } label: {
            Image(systemName: store.selectedTab == tab ? filledIcon : icon)
                .font(.system(size: 26, weight: .regular))
                .foregroundStyle(
                    store.selectedTab == tab
                        ? LpspPinterestTokens.pinterestTextPrimaryLight
                        : LpspPinterestTokens.pinterestTextSecondaryLight
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.plain)
    }

    private var createButton: some View {
        Button {
            store.selectedTab = .create
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(LpspPinterestTokens.pinterestRed)
                )
        }
        .frame(maxWidth: .infinity)
    }
}

private struct LpspPinterestHomeTabScreen: View {
    @ObservedObject var store: LpspPinterestStore

    var body: some View {
        VStack(spacing: 0) {
            LpspPinterestFloatingSearchBar(query: $store.searchQuery)
                .padding(.top, 8)
                .padding(.bottom, 4)

            LpspPinterestShowroomMasonryGrid(
                pins: store.pins,
                setSaved: { store.setSaved($0, to: $1) },
                onOpen: { store.openDetail($0) }
            )
        }
    }
}

private struct LpspPinterestShowroomMasonryGrid: View {
    let pins: [LpspPinterestShowroomPin]
    let setSaved: (String, Bool) -> Void
    let onOpen: (String) -> Void

    private let columnGap: CGFloat = 8
    private let horizontalMargin: CGFloat = 8

    var body: some View {
        GeometryReader { geo in
            let columnWidth = (geo.size.width - horizontalMargin * 2 - columnGap) / 2
            let (left, right) = distribute(pins: pins, columnWidth: columnWidth)

            ScrollView {
                HStack(alignment: .top, spacing: columnGap) {
                    column(pins: left, width: columnWidth)
                    column(pins: right, width: columnWidth)
                }
                .padding(.horizontal, horizontalMargin)
                .padding(.vertical, 8)
            }
        }
    }

    private func column(pins: [LpspPinterestShowroomPin], width: CGFloat) -> some View {
        VStack(spacing: 8) {
            ForEach(pins) { pin in
                LpspPinterestShowroomPinTile(
                    pin: pin,
                    width: width,
                    setSaved: { setSaved(pin.id, $0) },
                    onTap: { onOpen(pin.id) }
                )
            }
        }
    }

    private func distribute(
        pins: [LpspPinterestShowroomPin],
        columnWidth: CGFloat
    ) -> ([LpspPinterestShowroomPin], [LpspPinterestShowroomPin]) {
        var leftHeight: CGFloat = 0
        var rightHeight: CGFloat = 0
        var left: [LpspPinterestShowroomPin] = []
        var right: [LpspPinterestShowroomPin] = []

        for pin in pins {
            let imageHeight = columnWidth / pin.aspectRatio
            let totalHeight = imageHeight + 52
            if leftHeight <= rightHeight {
                left.append(pin)
                leftHeight += totalHeight + 8
            } else {
                right.append(pin)
                rightHeight += totalHeight + 8
            }
        }
        return (left, right)
    }
}

private struct LpspPinterestShowroomPinTile: View {
    let pin: LpspPinterestShowroomPin
    let width: CGFloat
    let setSaved: (Bool) -> Void
    let onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Button(action: onTap) {
                    LinearGradient(
                        colors: pin.gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: width, height: width / pin.aspectRatio)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)

                LpspPinterestPinterestSaveButton(
                    isSaved: Binding(
                        get: { pin.isSaved },
                        set: { setSaved($0) }
                    )
                )
                .padding(10)
            }

            Text(pin.title)
                .font(LpspPinterestFonts.pinterestPinTitle.weight(.medium))
                .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                .lineLimit(2)
                .padding(.top, 2)

            Text("by \(pin.creator)")
                .font(LpspPinterestFonts.pinterestMeta)
                .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)
                .lineLimit(1)
        }
    }
}

private struct LpspPinterestPinDetailSheet: View {
    @ObservedObject var store: LpspPinterestStore
    let pin: LpspPinterestShowroomPin
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .topTrailing) {
                        LinearGradient(
                            colors: pin.gradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                        LpspPinterestPinterestSaveButton(
                            isSaved: Binding(
                                get: { store.pins.first(where: { $0.id == pin.id })?.isSaved ?? false },
                                set: { store.setSaved(pin.id, to: $0) }
                            )
                        )
                        .padding(12)
                    }
                    .padding(.horizontal, 16)

                    HStack(spacing: 12) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: pin.gradient,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 44, height: 44)

                        Text(pin.creator)
                            .font(LpspPinterestFonts.pinterestBoardName.weight(.semibold))
                            .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)

                        Spacer()

                        LpspPinterestPinterestPillButton(title: "Follow", style: .secondary, action: {})
                    }
                    .padding(.horizontal, 16)

                    Text(pin.title)
                        .font(LpspPinterestFonts.pinterestPinDetailTitle.weight(.bold))
                        .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                        .padding(.horizontal, 16)

                    Text("Inspired by everyday spaces and warm natural light.")
                        .font(LpspPinterestFonts.pinterestBody)
                        .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                        .lineSpacing(3)
                        .padding(.horizontal, 16)

                    Text("More like this")
                        .font(LpspPinterestFonts.pinterestSectionHeader.weight(.semibold))
                        .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(store.moreLikeThis(excluding: pin.id)) { related in
                                Button {
                                    store.openDetail(related.id)
                                } label: {
                                    VStack(alignment: .leading, spacing: 6) {
                                        LinearGradient(
                                            colors: related.gradient,
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                        .frame(width: 140, height: 140 / related.aspectRatio)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))

                                        Text(related.title)
                                            .font(LpspPinterestFonts.pinterestPinTitle.weight(.medium))
                                            .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                                            .lineLimit(2)
                                            .frame(width: 140, alignment: .leading)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                .padding(.bottom, 24)
            }
            .background(LpspPinterestTokens.pinterestCanvasLight)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

private struct LpspPinterestSearchTabScreen: View {
    @ObservedObject var store: LpspPinterestStore

    var body: some View {
        VStack(spacing: 16) {
            LpspPinterestFloatingSearchBar(query: $store.searchQuery)
                .padding(.top, 8)

            List {
                Section("Trending searches") {
                    ForEach(LpspPinterestShowroomData.searchIdeas, id: \.self) { idea in
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)
                            Text(idea)
                                .font(LpspPinterestFonts.pinterestBody)
                                .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

private struct LpspPinterestCreateTabScreen: View {
    @ObservedObject var store: LpspPinterestStore

    var body: some View {
        VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(LpspPinterestTokens.pinterestInputLight)
                    .frame(height: 200)
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 40))
                                .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)
                            Text("Add a photo or video")
                                .font(LpspPinterestFonts.pinterestBody)
                                .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)
                        }
                    }
                    .padding(.horizontal, 16)

                TextField("Add a title", text: .constant(""))
                    .font(LpspPinterestFonts.pinterestBody)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LpspPinterestTokens.pinterestInputLight)
                    )
                    .padding(.horizontal, 16)

                LpspPinterestPinterestPillButton(title: "Create Pin", action: { store.selectedTab = .home })
                    .padding(.horizontal, 16)

                Spacer()
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LpspPinterestTokens.pinterestCanvasLight)
        }
    }
}

private struct LpspPinterestNotificationsTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspPinterestShowroomData.notifications.indices, id: \.self) { index in
                let item = LpspPinterestShowroomData.notifications[index]
                HStack {
                    Circle()
                        .fill(LpspPinterestTokens.pinterestRed.opacity(0.15))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "bell.fill")
                                .foregroundStyle(LpspPinterestTokens.pinterestRed)
                        }
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.0)
                            .font(LpspPinterestFonts.pinterestBody)
                            .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                        Text(item.1)
                            .font(LpspPinterestFonts.pinterestMeta)
                            .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspPinterestTokens.pinterestCanvasLight)
    }
}

private struct LpspPinterestShowroomProfileTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Circle()
                    .fill(LpspPinterestTokens.pinterestRed)
                    .frame(width: 80, height: 80)
                    .overlay {
                        Text("P")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(.white)
                    }

                Text("Your boards")
                    .font(LpspPinterestFonts.pinterestLargeTitle.weight(.bold))
                    .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)

                Text("24 pins · 6 boards")
                    .font(LpspPinterestFonts.pinterestMeta)
                    .foregroundStyle(LpspPinterestTokens.pinterestTextSecondaryLight)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(["Home", "Recipes", "Travel", "Style"], id: \.self) { board in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LpspPinterestTokens.pinterestSurface1Light)
                            .frame(height: 100)
                            .overlay {
                                Text(board)
                                    .font(LpspPinterestFonts.pinterestBoardName.weight(.semibold))
                                    .foregroundStyle(LpspPinterestTokens.pinterestTextPrimaryLight)
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 24)
        }
    }
}


