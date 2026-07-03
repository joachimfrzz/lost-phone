import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/social/pinterest/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/pinterest
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomePinterestView: View {
    var body: some View {
        LpspPinterestShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspPinterestTokens {
    // MARK: - Brand
    static let pinterestRed        = Color(red: 0.902, green: 0.0,   blue: 0.137)  // #E60023
    static let pinterestRedPressed = Color(red: 0.678, green: 0.031, blue: 0.106)  // #AD081B
    static let pinterestRedHover   = Color(red: 0.8,   green: 0.0,   blue: 0.125)  // #CC0020

    // MARK: - Canvas (Light)
    static let pinterestCanvasLight   = LpspPinterestTokens.white                                 // #FFFFFF
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
    static let pinterestTextPrimaryDark    = LpspPinterestTokens.white                                   // #FFFFFF
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

private struct LpspPinterestPinterestSaveButton: View {
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

private struct LpspPinterestPinterestPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.75),
                       value: configuration.isPressed)
    }
}

private struct LpspPinterestPinterestPillButton: View {
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

private struct LpspPinterestPinTile: View {
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

private struct LpspPinterestPin: Identifiable {
    let id = UUID()
    let imageURL: URL
    let aspectRatio: CGFloat
    let title: String
    let creatorName: String
    let creatorAvatarURL: URL
}

private struct LpspPinterestMasonryGrid: View {
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

private struct LpspPinterestFloatingSearchBar: View {
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
            Capsule().fill(LpspPinterestTokens.white)
                .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        )
        .padding(.horizontal, 16)
    }
}

private struct LpspPinterestPinDetailHero: View {
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

private struct LpspPinterestPinterestTabBar: View {
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

private struct LpspPinterestPinterestRefreshSpinner: View {
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

private struct LpspPinterestSharedPinImage: View {
    let imageURL: URL
    let namespace: Namespace.ID
    let id: UUID
    var body: some View {
        AsyncImage(url: imageURL) { img in img.resizable().scaledToFill() } placeholder: { LpspPinterestTokens.gray }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .matchedGeometryEffect(id: id, in: namespace)
    }
}

// Fade-up entrance on newly loaded pins
// Apply on each LpspPinterestPinTile via .transition(.move(edge: .bottom).combined(with: .opacity))
// With insertion: .spring(response: 0.4, dampingFraction: 0.85)

// Idea LpspPinterestPin advance
// Use a TabView(selection:) with PageTabViewStyle and custom onTap logic for tap-left/right

// MARK: - Écrans showroom

private struct LpspPinterestShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspPinterestFeedTabScreen()
                .tabItem { Label("Accueil", systemImage: "house.fill") }
                .tag(0)
            LpspPinterestExploreTabScreen()
                .tabItem { Label("Explorer", systemImage: "magnifyingglass") }
                .tag(1)
            LpspPinterestProfileTabScreen()
                .tabItem { Label("Profil", systemImage: "person.circle") }
                .tag(2)
        }
        .tint(LpspPinterestTokens.pinterestRed)
        
    }
}


private struct LpspPinterestGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspPinterestTokens.pinterestRed.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspPinterestTokens.pinterestRed))
                    VStack(alignment: .leading) {
                        Text("\(title) \(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}


private struct LpspPinterestDemoStory: Identifiable {
    let id = UUID()
    let name: String
    let unread: Bool
}

private enum LpspPinterestDemoStories {
    static let items: [LpspPinterestDemoStory] = [
        .init(name: "Votre story", unread: false),
        .init(name: "Alex", unread: true),
        .init(name: "Léa", unread: true),
    ]
}

private struct LpspPinterestFeedTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(LpspPinterestDemoStories.items) { s in
                                VStack(spacing: 4) {
                                    Circle().strokeBorder(LpspPinterestTokens.pinterestRed, lineWidth: 2).frame(width: 66, height: 66)
                                        .overlay(Circle().fill(LpspPinterestTokens.pinterestRed.opacity(0.2)).frame(width: 58, height: 58))
                                    Text(s.name).font(.system(size: 11)).lineLimit(1).frame(width: 72)
                                }
                            }
                        }
                        .padding(.horizontal, 12).padding(.vertical, 10)
                    }


                    ForEach(0..<3, id: \.self) { i in
                        LpspPinterestGenericFeedCard(index: i, accent: LpspPinterestTokens.pinterestRed)
                    }

                }
            }
            .background(LpspPinterestTokens.pinterestCanvasLight.ignoresSafeArea())
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct LpspPinterestExploreTabScreen: View {
    let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: cols, spacing: 2) {
                    ForEach(0..<15, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(LpspPinterestTokens.pinterestRed.opacity(0.08 + Double(i) * 0.04))
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .navigationTitle("Explorer")
        }
    }
}

private struct LpspPinterestReelsTabScreen: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "play.rectangle.fill").font(.system(size: 64)).foregroundStyle(.white.opacity(0.85))
                Text("Reels").font(.title2.bold()).foregroundStyle(.white)
                Spacer()
            }
        }
    }
}

private struct LpspPinterestProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Circle().fill(LpspPinterestTokens.pinterestRed.gradient).frame(width: 88, height: 88)
                        .overlay(Text("LP").font(.title.bold()).foregroundStyle(.white))
                    Text("lost.phone").font(.system(size: 20, weight: .bold))
                    Text("Paris · Showroom").font(.subheadline).foregroundStyle(.secondary)
                    HStack(spacing: 32) {
                        VStack { Text("128").font(.headline); Text("Publications").font(.caption) }
                        VStack { Text("1,2 k").font(.headline); Text("Abonnés").font(.caption) }
                        VStack { Text("340").font(.headline); Text("Abonnements").font(.caption) }
                    }
                }
                .padding()
            }
            .navigationTitle("Profil")
        }
    }
}

private struct LpspPinterestSocialTabScreen: View {
    let title: String
    var body: some View { LpspPinterestGenericTabScreen(title: title, tabIndex: 0) }
}

private struct LpspPinterestGenericFeedCard: View {
    let index: Int
    let accent: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Circle().fill(accent.opacity(0.2)).frame(width: 32, height: 32)
                Text("utilisateur_\(index)").font(.system(size: 14, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 12)
            RoundedRectangle(cornerRadius: 0).fill(accent.opacity(0.12)).frame(height: 280)
            HStack(spacing: 16) {
                Image(systemName: "heart"); Image(systemName: "bubble.right"); Spacer(); Image(systemName: "bookmark")
            }
            .font(.system(size: 22)).padding(.horizontal, 12).padding(.bottom, 12)
        }
    }
}


