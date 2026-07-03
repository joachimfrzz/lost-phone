import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/travel/tripadvisor/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/tripadvisor
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeTripAdvisorView: View {
    var body: some View {
        LpspTripAdvisorShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspTripAdvisorFonts {
    static let taTitleLarge  = Font.system(size: 28, weight: .regular)
    static let taPlaceHero   = Font.system(size: 24, weight: .regular)
    static let taSection     = Font.system(size: 22, weight: .regular)
    static let taPlaceName   = Font.system(size: 17, weight: .regular)
    static let taCardTitle   = Font.system(size: 16, weight: .regular)
    static let taReviewBody  = Font.system(size: 15, weight: .regular)
    static let taButton      = Font.system(size: 16, weight: .regular)
    static let taButtonSec   = Font.system(size: 15, weight: .regular)
    static let taMeta        = Font.system(size: 13, weight: .regular)
    static let taTab         = Font.system(size: 11, weight: .regular)
    static let taBadge       = Font.system(size: 11, weight: .regular)
    static let taCaption     = Font.system(size: 12, weight: .regular)
    static func ta(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspTripAdvisorTokens {
    // MARK: - Canvas & Surfaces
    static let taCanvas        = Color.white                                    // #FFFFFF
    static let taSurface       = Color(red: 0.949, green: 0.949, blue: 0.949)   // #F2F2F2
    static let taDivider       = Color(red: 0.878, green: 0.878, blue: 0.878)   // #E0E0E0
    static let taSurfacePressed = Color(red: 0.910, green: 0.910, blue: 0.910)  // #E8E8E8

    // MARK: - Text
    static let taTextPrimary   = Color.black                                    // #000000
    static let taTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420)   // #6B6B6B
    static let taTextTertiary  = Color(red: 0.608, green: 0.608, blue: 0.608)   // #9B9B9B

    // MARK: - Brand
    static let taGreen         = Color(red: 0.204, green: 0.878, blue: 0.631)   // #34E0A1
    static let taGreenPressed  = Color(red: 0.129, green: 0.773, blue: 0.537)   // #21C589
    static let taOwlBlack      = Color.black                                    // #000000

    // MARK: - Semantic
    static let taEmptyBubble   = Color(red: 0.851, green: 0.851, blue: 0.851)   // #D9D9D9
    static let taErrorRed      = Color(red: 0.839, green: 0.071, blue: 0.180)   // #D6122E
}





fileprivate struct LpspTripAdvisorBubbleRating: View {
    let value: Double          // 0.0 ... 5.0
    var size: CGFloat = 16
    var reviewCount: Int? = nil

    var body: some View {
        HStack(spacing: 6) {
            HStack(spacing: 2) {
                ForEach(0..<5) { i in
                    bubble(at: i)
                }
            }
            if let count = reviewCount {
                Text("\(String(format: "%.1f", value)) (\(count.formatted()))")
                    .font(LpspTripAdvisorFonts.taMeta)
                    .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
            }
        }
    }

    @ViewBuilder
    private func bubble(at index: Int) -> some View {
        let fill = min(max(value - Double(index), 0), 1)  // 0, 0.5, or 1
        ZStack {
            Circle().fill(LpspTripAdvisorTokens.taEmptyBubble)
            Circle()
                .fill(LpspTripAdvisorTokens.taGreen)
                .mask(
                    Rectangle()
                        .frame(width: size * fill)
                        .frame(width: size, alignment: .leading)
                )
        }
        .frame(width: size, height: size)
    }
}

fileprivate struct LpspTripAdvisorBubbleRatingPicker: View {
    @Binding var rating: Int   // 1 ... 5
    var size: CGFloat = 32

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { i in
                Circle()
                    .fill(i <= rating ? LpspTripAdvisorTokens.taGreen : LpspTripAdvisorTokens.taEmptyBubble)
                    .frame(width: size, height: size)
                    .scaleEffect(i == rating ? 1.0 : 1.0)
                    .onTapGesture { rating = i }
                    .sensoryFeedback(.impact(weight: .light), trigger: rating)
                    .animation(.spring(response: 0.2, dampingFraction: 0.6), value: rating)
            }
        }
    }
}

fileprivate struct LpspTripAdvisorTAPillButton: View {
    let title: String
    var style: LpspTripAdvisorStyle = .filled
    let action: () -> Void

    enum LpspTripAdvisorStyle { case filled, outline }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(style == .filled ? .taButton : .taButtonSec)
                .foregroundStyle(.black)
                .padding(.vertical, style == .filled ? 14 : 12)
                .padding(.horizontal, style == .filled ? 28 : 24)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule().fill(style == .filled ? LpspTripAdvisorTokens.taGreen : .clear)
                )
                .overlay(
                    Capsule().strokeBorder(style == .outline ? Color.black : .clear, lineWidth: 1)
                )
        }
        .buttonStyle(LpspTripAdvisorTAPressableStyle())
    }
}

fileprivate struct LpspTripAdvisorTAPressableStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

fileprivate struct LpspTripAdvisorPlaceCard: View {
    let name: String
    let photo: Image
    let rating: Double
    let reviews: Int
    let category: String
    let priceTier: String
    let distance: String
    let isAwarded: Bool
    @State private var saved = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                photo
                    .resizable()
                    .aspectRatio(3/2, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Button {
                    saved.toggle()
                } label: {
                    Image(systemName: saved ? "heart.fill" : "heart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(saved ? LpspTripAdvisorTokens.taGreen : .white)
                        .padding(8)
                        .background(Circle().fill(.black.opacity(0.30)))
                }
                .sensoryFeedback(.success, trigger: saved)
                .padding(12)
            }

            if isAwarded {
                Text("TRAVELERS' CHOICE")
                    .font(LpspTripAdvisorFonts.taBadge)
                    .foregroundStyle(.black)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(LpspTripAdvisorTokens.taGreen))
            }

            Text(name).font(LpspTripAdvisorFonts.taPlaceName).foregroundStyle(LpspTripAdvisorTokens.taTextPrimary)
            LpspTripAdvisorBubbleRating(value: rating, size: 16, reviewCount: reviews)
            Text("\(category) · \(priceTier) · \(distance)")
                .font(LpspTripAdvisorFonts.taMeta)
                .foregroundStyle(LpspTripAdvisorTokens.taTextSecondary)
        }
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspTripAdvisorPlaceHero: View {
    let name: String
    let photo: Image
    let rating: Double
    let reviews: Int

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            photo
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 280)
                .clipped()

            LinearGradient(
                colors: [.clear, .black.opacity(0.55)],
                startPoint: .center, endPoint: .bottom
            )

            VStack(alignment: .leading, spacing: 8) {
                Text(name).font(LpspTripAdvisorFonts.taPlaceHero).foregroundStyle(.white)
                HStack(spacing: 6) {
                    LpspTripAdvisorBubbleRating(value: rating, size: 18)
                    Text("\(reviews.formatted()) reviews")
                        .font(LpspTripAdvisorFonts.taMeta).foregroundStyle(.white)
                }
            }
            .padding(20)
        }
        .frame(height: 280)
        .clipped()
    }
}

fileprivate struct LpspTripAdvisorRootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.96)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        TabView {
            ExploreView().tabItem { Label("Explore", systemImage: "safari.fill") }
            SearchView().tabItem { Label("Search", systemImage: "magnifyingglass") }
            TripsView().tabItem { Label("Trips", systemImage: "suitcase.fill") }
            ReviewView().tabItem { Label("Review", systemImage: "square.and.pencil") }
            MoreView().tabItem { Label("More", systemImage: "ellipsis") }
        }
        .tint(LpspTripAdvisorTokens.taGreen) // active = Tripadvisor Green
    }
}

// MARK: - Écrans showroom

private struct LpspTripAdvisorShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspTripAdvisorGenericTabScreen(title: "Explore", tabIndex: 0)
                .tabItem { Label("Explore", systemImage: "safari.fill") }
                .tag(0)
            LpspTripAdvisorGenericTabScreen(title: "Search", tabIndex: 1)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
                .tag(1)
            LpspTripAdvisorGenericTabScreen(title: "Trips", tabIndex: 2)
                .tabItem { Label("Trips", systemImage: "suitcase.fill") }
                .tag(2)
            LpspTripAdvisorGenericTabScreen(title: "Review", tabIndex: 3)
                .tabItem { Label("Review", systemImage: "square.and.pencil") }
                .tag(3)
            LpspTripAdvisorGenericTabScreen(title: "More", tabIndex: 4)
                .tabItem { Label("More", systemImage: "ellipsis") }
                .tag(4)
        }
        .tint(LpspTripAdvisorTokens.taGreen)
        
    }
}


private struct LpspTripAdvisorGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspTripAdvisorTokens.taGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspTripAdvisorTokens.taGreen))
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


private struct LpspTripAdvisorMessagingTabScreen: View {
    let title: String
    var body: some View { LpspTripAdvisorGenericTabScreen(title: title, tabIndex: 0) }
}


