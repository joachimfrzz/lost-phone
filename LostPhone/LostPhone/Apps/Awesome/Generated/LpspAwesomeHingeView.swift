import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/hinge
// Meliwat/awesome-ios-design-md/dating/hinge/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeHingeView: View {
    var body: some View {
        LpspHingeShowroomRoot(store: LpspHingeStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspHingeFonts {
    static let hingeDisplay      = Font.system(size: 36, weight: .regular)
    static let hingeName         = Font.system(size: 28, weight: .regular)
    static let hingePromptQ      = Font.system(size: 22, weight: .regular)
    static let hingePromptA      = Font.system(size: 24, weight: .regular)
    static let hingeSection      = Font.system(size: 18, weight: .regular)
    static let hingeButton       = Font.system(size: 16, weight: .regular)
    static let hingeBody         = Font.system(size: 16, weight: .regular)
    static let hingeBodyBold     = Font.system(size: 16, weight: .regular)
    static let hingeChip         = Font.system(size: 14, weight: .regular)
    static let hingeMeta         = Font.system(size: 13, weight: .regular)
    static let hingeCaption      = Font.system(size: 12, weight: .regular)
    static let hingeTab          = Font.system(size: 10, weight: .regular)
    static let hingeCommentInput = Font.system(size: 16, weight: .regular)
    static let hingeMatchBanner  = Font.system(size: 14, weight: .regular)
    static func hinge(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private enum LpspHingeTokens {
    // MARK: - Canvas & Surfaces (the cream paper)
    static let hingeCream        = Color(red: 0.992, green: 0.973, blue: 0.949) // #FDF8F2 canvas
    static let hingePaper        = Color(red: 0.980, green: 0.965, blue: 0.941) // #FAF6F0 cards
    static let hingeSand         = Color(red: 0.949, green: 0.922, blue: 0.878) // #F2EBE0 chips/inputs
    static let hingeSand2        = Color(red: 0.910, green: 0.875, blue: 0.816) // #E8DFD0 pressed
    static let hingeDividerBone  = Color(red: 0.878, green: 0.839, blue: 0.773) // #E0D6C5

    // MARK: - Text (warm-tinted greys, never neutral)
    static let hingeBlack        = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A primary
    static let hingeBlackPressed = Color(red: 0.039, green: 0.039, blue: 0.039) // #0A0A0A
    static let hingeGraphite     = Color(red: 0.290, green: 0.259, blue: 0.224) // #4A4239 secondary
    static let hingeStone        = Color(red: 0.478, green: 0.447, blue: 0.408) // #7A7268 tertiary
    static let hingeBone         = Color(red: 0.690, green: 0.659, blue: 0.612) // #B0A89C disabled

    // MARK: - Rose Gold (the single accent — Standouts, Roses, premium)
    static let hingeRose         = Color(red: 0.910, green: 0.627, blue: 0.302) // #E8A04D
    static let hingeRoseDeep     = Color(red: 0.773, green: 0.494, blue: 0.180) // #C57E2E pressed
    static let hingeRoseLight    = Color(red: 0.961, green: 0.851, blue: 0.659) // #F5D9A8 halo

    // MARK: - Semantic
    static let hingeMatchGreen   = Color(red: 0.176, green: 0.478, blue: 0.294) // #2D7A4B
    static let hingeWarning      = Color(red: 0.847, green: 0.545, blue: 0.180) // #D88B2E
    static let hingeError        = Color(red: 0.702, green: 0.227, blue: 0.184) // #B33A2F
    static let hingeInfo         = Color(red: 0.353, green: 0.384, blue: 0.451) // #5A6273

    // MARK: - Dark mode (warm dark — preserves paper feel)
    static let hingeDarkCanvas   = Color(red: 0.086, green: 0.075, blue: 0.055) // #16130E
    static let hingeDarkSurface  = Color(red: 0.118, green: 0.102, blue: 0.078) // #1E1A14
    static let hingeDarkSurface2 = Color(red: 0.165, green: 0.145, blue: 0.125) // #2A2520
    static let hingeDarkDivider  = Color(red: 0.184, green: 0.165, blue: 0.133) // #2F2A22
    static let hingeDarkText     = Color(red: 0.937, green: 0.910, blue: 0.855) // #EFE8DA
    static let hingeDarkTextSec  = Color(red: 0.659, green: 0.620, blue: 0.557) // #A89E8E
    static let hingeRoseDark     = Color(red: 0.941, green: 0.690, blue: 0.361) // #F0B05C OLED-brightened
}



// If Sailec/Inter aren't bundled, this fallback keeps the warm system substitute:


fileprivate struct LpspHingeHeartTap: View {
    @Binding var isFilled: Bool
    var onTap: () -> Void

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.6)) {
                isFilled.toggle()
            }
            onTap()
        } label: {
            ZStack {
                Circle()
                    .fill(isFilled ? LpspHingeTokens.hingeBlack : LpspHingeTokens.hingePaper)
                    .overlay(
                        Circle().strokeBorder(LpspHingeTokens.hingeBlack, lineWidth: 1)
                    )
                    .frame(width: 44, height: 44)
                Image(systemName: "heart.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(isFilled ? LpspHingeTokens.hingePaper : LpspHingeTokens.hingeBlack)
                    .scaleEffect(isFilled ? 1.0 : 0.92)
            }
        }
        .sensoryFeedback(.impact(weight: .light), trigger: isFilled)
    }
}

fileprivate struct LpspHingePromptCard: View {
    let question: String
    let answer: String
    @State private var isLiked = false
    var onCommentTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(question)
                .font(LpspHingeFonts.hingePromptQ)
                .foregroundStyle(LpspHingeTokens.hingeGraphite)
                .italic() // Hinge italicizes certain templates
                .padding(.bottom, 12)

            Text(answer)
                .font(LpspHingeFonts.hingePromptA)
                .foregroundStyle(LpspHingeTokens.hingeBlack)
                .lineSpacing(4)
                .padding(.bottom, 16)

            HStack {
                Spacer()
                LpspHingeHeartTap(isFilled: $isLiked, onTap: onCommentTap)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspHingeTokens.hingePaper)
                .overlay(
                    RoundedRectangle(cornerRadius: 16).strokeBorder(LpspHingeTokens.hingeDividerBone, lineWidth: 0.5)
                )
        )
        .shadow(color: Color(red: 0.110, green: 0.078, blue: 0.039).opacity(0.06), radius: 8, y: 2)
        .onTapGesture { onCommentTap() }
    }
}

fileprivate struct LpspHingePhotoCard: View {
    let image: Image
    @State private var isLiked = false
    var onCommentTap: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            image
                .resizable()
                .aspectRatio(4/5, contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            LpspHingeHeartTap(isFilled: $isLiked, onTap: onCommentTap)
                .padding(16)
        }
        .shadow(color: Color(red: 0.110, green: 0.078, blue: 0.039).opacity(0.06), radius: 8, y: 2)
    }
}

fileprivate struct LpspHingeAttributeChip: View {
    let glyph: String          // SF Symbol
    let label: String
    var isVerified: Bool = false

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: glyph)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(LpspHingeTokens.hingeBlack)
            Text(label)
                .font(LpspHingeFonts.hingeChip)
                .foregroundStyle(LpspHingeTokens.hingeBlack)
            if isVerified {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 12))
                    .foregroundStyle(LpspHingeTokens.hingeMatchGreen)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 14)
        .background(Capsule().fill(LpspHingeTokens.hingeSand))
    }
}

fileprivate struct LpspHingeStandoutsCard: View {
    let photo: Image
    let answer: String
    var onSendRose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(LpspHingeTokens.hingeRose)
                Text("Standout")
                    .font(.custom("Sailec-Bold", size: 12))
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                Spacer()
            }
            .frame(height: 32)
            .padding(.horizontal, 16)
            .background(LpspHingeTokens.hingeRoseLight)

            photo
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .clipped()

            VStack(alignment: .leading, spacing: 16) {
                Text(answer)
                    .font(LpspHingeFonts.hingePromptA)
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                LpspHingeRoseCTA(label: "Send a Rose", action: onSendRose)
            }
            .padding(16)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LpspHingeTokens.hingePaper)
                .overlay(
                    RoundedRectangle(cornerRadius: 20).strokeBorder(
                        LinearGradient(
                            colors: [LpspHingeTokens.hingeRose, LpspHingeTokens.hingeRoseLight, LpspHingeTokens.hingeRose],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color(red: 0.110, green: 0.078, blue: 0.039).opacity(0.10), radius: 12, y: 4)
    }
}

fileprivate struct LpspHingeRoseCTA: View {
    var label: String = "Send a Rose"
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: "leaf.fill") // Rose glyph stand-in via SF Symbols
                    .font(.system(size: 16))
                    .foregroundStyle(LpspHingeTokens.hingeRose)
                Text(label)
                    .font(LpspHingeFonts.hingeButton)
                    .foregroundStyle(LpspHingeTokens.hingePaper)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                Capsule()
                    .fill(LpspHingeTokens.hingeBlack)
                    .overlay(Capsule().stroke(LpspHingeTokens.hingeRose, lineWidth: 1))
            )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .heavy), trigger: UUID())
    }
}

fileprivate struct LpspHingeHingePrimaryButton: View {
    let label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspHingeFonts.hingeButton)
                .foregroundStyle(LpspHingeTokens.hingePaper)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Capsule().fill(LpspHingeTokens.hingeBlack))
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
    }
}

fileprivate struct LpspHingeCommentSheet: View {
    let source: AnyView                // The pinned prompt card or photo
    @State private var comment: String = ""
    var onSend: (String) -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Pinned source — the tapped prompt or photo
            source
                .frame(maxHeight: .infinity, alignment: .top)

            HStack(spacing: 10) {
                TextField("Add a comment about her response", text: $comment, axis: .vertical)
                    .font(LpspHingeFonts.hingeCommentInput)
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .background(Capsule().fill(LpspHingeTokens.hingeSand))
                    .lineLimit(1...4)

                Button {
                    onSend(comment)
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(LpspHingeTokens.hingePaper)
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(comment.isEmpty ? LpspHingeTokens.hingeBone : LpspHingeTokens.hingeBlack))
                }
                .disabled(comment.isEmpty)
                .sensoryFeedback(.impact(weight: .medium), trigger: comment.isEmpty == false)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .padding(.top, 24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LpspHingeTokens.hingePaper)
                .ignoresSafeArea(edges: .bottom)
        )
    }
}

fileprivate struct LpspHingeMatchCelebration: View {
    let myAvatar: Image
    let theirName: String
    let theirAvatar: Image
    var onMessage: () -> Void
    var onKeepBrowsing: () -> Void

    @State private var confettiTrigger = false

    var body: some View {
        ZStack {
            LpspHingeTokens.hingeCream.ignoresSafeArea()

            // Confetti layer (Rose Gold particles)
            ForEach(0..<24, id: \.self) { i in
                Circle()
                    .fill(LpspHingeTokens.hingeRose)
                    .frame(width: CGFloat.random(in: 4...10), height: CGFloat.random(in: 4...10))
                    .offset(x: CGFloat.random(in: -160...160), y: confettiTrigger ? 600 : -300)
                    .opacity(confettiTrigger ? 0 : 1)
                    .animation(.easeIn(duration: 1.8).delay(Double(i) * 0.04), value: confettiTrigger)
            }

            VStack(spacing: 32) {
                HStack(spacing: 24) {
                    myAvatar
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120).clipShape(Circle())
                    theirAvatar
                        .resizable().aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120).clipShape(Circle())
                }

                VStack(spacing: 8) {
                    Text("It's a match!")
                        .font(LpspHingeFonts.hingeDisplay)
                        .foregroundStyle(LpspHingeTokens.hingeBlack)
                        .tracking(-0.6)
                    Text("You and \(theirName) liked each other")
                        .font(LpspHingeFonts.hingeBody)
                        .foregroundStyle(LpspHingeTokens.hingeGraphite)
                }

                VStack(spacing: 12) {
                    LpspHingeHingePrimaryButton(label: "Send a message", action: onMessage)
                    Button("Keep browsing", action: onKeepBrowsing)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundStyle(LpspHingeTokens.hingeGraphite)
                }
                .padding(.horizontal, 24)
            }
        }
        .onAppear {
            confettiTrigger = true
        }
        .sensoryFeedback(.success, trigger: confettiTrigger)
    }
}



// MARK: - Données & état (showroom Spectr)

private enum LpspHingeShowroomTab: String, CaseIterable, Identifiable {
    case discover
    case likesYou
    case standouts
    case matches
    case profile

    var id: String { rawValue }

    var title: String {
        switch self {
        case .discover: return "Discover"
        case .likesYou: return "Likes You"
        case .standouts: return "Standouts"
        case .matches: return "Matches"
        case .profile: return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .discover: return "line.3.horizontal.decrease"
        case .likesYou: return "heart.fill"
        case .standouts: return "star.fill"
        case .matches: return "bubble.left.fill"
        case .profile: return "person.fill"
        }
    }
}

fileprivate struct LpspHingePromptItem: Identifiable, Equatable {
    let id: String
    let question: String
    let answer: String
    var isLiked: Bool
}

fileprivate struct LpspHingeDiscoverProfile: Equatable {
    let id: String
    let name: String
    let age: Int
    let distance: String
    let height: String
    let job: String
    let location: String
    let jobVerified: Bool
    var prompts: [LpspHingePromptItem]
    var photoLiked: Bool
    let photoGradient: [Color]
}

private enum LpspHingeShowroomData {
    static let sigrun = LpspHingeDiscoverProfile(
        id: "sigrun",
        name: "Sigrún",
        age: 28,
        distance: "2 mi away",
        height: "5'9\"",
        job: "Engineer",
        location: "SF",
        jobVerified: true,
        prompts: [
            .init(
                id: "geek-out",
                question: "I geek out on _",
                answer: "Specialty coffee, vintage Vespas, and the chess opening called the Sicilian Najdorf.",
                isLiked: false
            ),
            .init(
                id: "simple-pleasures",
                question: "My simple pleasures",
                answer: "Sunday mornings with a record on.",
                isLiked: false
            ),
        ],
        photoLiked: false,
        photoGradient: [
            Color(red: 0.85, green: 0.78, blue: 0.68),
            Color(red: 0.62, green: 0.52, blue: 0.44),
        ]
    )

    static let standoutAnswer = "Sunday mornings with a record on."

    static let likesYouCount = 3

    static let matches: [(name: String, preview: String, time: String)] = [
        ("Mara", "That Sicilian Najdorf line is wild", "2h"),
        ("Kellen", "Sent a Rose", "1d"),
    ]
}

@MainActor
fileprivate final class LpspHingeStore: ObservableObject {
    @Published var selectedTab: LpspHingeShowroomTab = .discover
    @Published var profile: LpspHingeDiscoverProfile
    @Published var showCommentSheet = false
    @Published var activePromptID: String?
    @Published var commentText = ""
    @Published var showMatch = false
    @Published var rosesSent = 0

    init() {
        profile = LpspHingeShowroomData.sigrun
    }

    func openComment(for promptID: String) {
        activePromptID = promptID
        showCommentSheet = true
    }

    func togglePromptLike(_ promptID: String) {
        guard let index = profile.prompts.firstIndex(where: { $0.id == promptID }) else { return }
        var updated = profile
        updated.prompts[index].isLiked.toggle()
        profile = updated
    }

    func setPromptLiked(_ promptID: String, liked: Bool) {
        guard let index = profile.prompts.firstIndex(where: { $0.id == promptID }) else { return }
        var updated = profile
        updated.prompts[index].isLiked = liked
        profile = updated
    }

    func setPhotoLiked(_ liked: Bool) {
        var updated = profile
        updated.photoLiked = liked
        profile = updated
    }

    func togglePhotoLike() {
        setPhotoLiked(!profile.photoLiked)
    }

    func sendComment() {
        let trimmed = commentText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if let activePromptID {
            togglePromptLike(activePromptID)
        }
        commentText = ""
        showCommentSheet = false
    }

    func passProfile() {
        var updated = profile
        updated.photoLiked = false
        for index in updated.prompts.indices {
            updated.prompts[index].isLiked = false
        }
        profile = updated
    }

    func likeProfile() {
        showMatch = true
    }

    func sendRose() {
        rosesSent += 1
    }
}

// MARK: - Écrans showroom

private struct LpspHingeShowroomRoot: View {
    @ObservedObject var store: LpspHingeStore

    var body: some View {
        TabView(selection: $store.selectedTab) {
            ForEach(LpspHingeShowroomTab.allCases) { tab in
                LpspHingeShowroomTabScreen(store: store, tab: tab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .tag(tab)
            }
        }
        .tint(LpspHingeTokens.hingeBlack)
        .sheet(isPresented: $store.showCommentSheet) {
            LpspHingeShowroomCommentSheet(store: store)
        }
        .fullScreenCover(isPresented: $store.showMatch) {
            LpspHingeShowroomMatchScreen(store: store)
        }
    }
}

private struct LpspHingeShowroomTabScreen: View {
    @ObservedObject var store: LpspHingeStore
    let tab: LpspHingeShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .discover:
                LpspHingeDiscoverTabScreen(store: store)
            case .likesYou:
                LpspHingeLikesYouTabScreen()
            case .standouts:
                LpspHingeStandoutsTabScreen(store: store)
            case .matches:
                LpspHingeMatchesTabScreen()
            case .profile:
                LpspHingeProfileTabScreen()
            }
        }
        .background(LpspHingeTokens.hingeCream.ignoresSafeArea())
    }
}

private struct LpspHingeDiscoverTabScreen: View {
    @ObservedObject var store: LpspHingeStore

    private var profile: LpspHingeDiscoverProfile { store.profile }

    var body: some View {
        VStack(spacing: 0) {
            LpspHingeDiscoverHeader()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(profile.name), \(profile.age)")
                            .font(LpspHingeFonts.hingeName.weight(.bold))
                            .foregroundStyle(LpspHingeTokens.hingeBlack)
                        Text(profile.distance)
                            .font(LpspHingeFonts.hingeMeta)
                            .foregroundStyle(LpspHingeTokens.hingeGraphite)
                    }

                    HStack(spacing: 8) {
                        LpspHingeAttributeChip(glyph: "ruler", label: profile.height)
                        LpspHingeAttributeChip(glyph: "briefcase.fill", label: profile.job, isVerified: profile.jobVerified)
                        LpspHingeAttributeChip(glyph: "mappin.and.ellipse", label: profile.location)
                    }

                    ForEach(Array(profile.prompts.enumerated()), id: \.element.id) { index, prompt in
                        if index == 1 {
                            LpspHingeGradientPhotoCard(
                                isLiked: Binding(
                                    get: { store.profile.photoLiked },
                                    set: { store.setPhotoLiked($0) }
                                ),
                                gradient: profile.photoGradient,
                                onCommentTap: { store.togglePhotoLike() }
                            )
                        }

                        LpspHingeShowroomPromptCard(
                            prompt: prompt,
                            isLiked: Binding(
                                get: { store.profile.prompts.first(where: { $0.id == prompt.id })?.isLiked ?? false },
                                set: { store.setPromptLiked(prompt.id, liked: $0) }
                            ),
                            onCommentTap: { store.openComment(for: prompt.id) }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }

            LpspHingeDiscoverActionBar(
                onPass: { store.passProfile() },
                onLike: { store.likeProfile() }
            )
        }
    }
}

private struct LpspHingeDiscoverHeader: View {
    var body: some View {
        HStack {
            Text("H")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(LpspHingeTokens.hingePaper)
                .frame(width: 28, height: 28)
                .background(Circle().fill(LpspHingeTokens.hingeBlack))

            Text("Discover")
                .font(LpspHingeFonts.hingeSection.weight(.bold))
                .foregroundStyle(LpspHingeTokens.hingeBlack)

            Spacer()

            Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(LpspHingeTokens.hingeBlack)
        }
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(LpspHingeTokens.hingeCream)
    }
}

private struct LpspHingeShowroomPromptCard: View {
    let prompt: LpspHingePromptItem
    @Binding var isLiked: Bool
    let onCommentTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(prompt.question)
                .font(LpspHingeFonts.hingePromptQ)
                .foregroundStyle(LpspHingeTokens.hingeGraphite)
                .italic()
                .padding(.bottom, 12)

            Text(prompt.answer)
                .font(LpspHingeFonts.hingePromptA.weight(.semibold))
                .foregroundStyle(LpspHingeTokens.hingeBlack)
                .lineSpacing(4)
                .padding(.bottom, 16)

            HStack {
                Spacer()
                LpspHingeHeartTap(isFilled: $isLiked, onTap: onCommentTap)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LpspHingeTokens.hingePaper)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(LpspHingeTokens.hingeDividerBone, lineWidth: 0.5)
                )
        )
        .shadow(color: Color(red: 0.110, green: 0.078, blue: 0.039).opacity(0.06), radius: 8, y: 2)
        .onTapGesture { onCommentTap() }
    }
}

private struct LpspHingeGradientPhotoCard: View {
    @Binding var isLiked: Bool
    let gradient: [Color]
    let onCommentTap: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .aspectRatio(4/5, contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            LpspHingeHeartTap(isFilled: $isLiked, onTap: onCommentTap)
                .padding(16)
        }
        .shadow(color: Color(red: 0.110, green: 0.078, blue: 0.039).opacity(0.06), radius: 8, y: 2)
    }
}

private struct LpspHingeDiscoverActionBar: View {
    let onPass: () -> Void
    let onLike: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: onPass) {
                Image(systemName: "xmark")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(LpspHingeTokens.hingeDividerBone, lineWidth: 1)
                            .background(RoundedRectangle(cornerRadius: 12).fill(LpspHingeTokens.hingePaper))
                    )
            }
            .buttonStyle(.plain)

            Button(action: onLike) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(LpspHingeTokens.hingePaper)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LpspHingeTokens.hingeBlack)
                    )
            }
            .buttonStyle(.plain)
            .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(LpspHingeTokens.hingeCream)
    }
}

private struct LpspHingeShowroomCommentSheet: View {
    @ObservedObject var store: LpspHingeStore
    @Environment(\.dismiss) private var dismiss

    private var activePrompt: LpspHingePromptItem? {
        guard let id = store.activePromptID else { return nil }
        return store.profile.prompts.first { $0.id == id }
    }

    var body: some View {
        VStack(spacing: 16) {
            if let prompt = activePrompt {
                LpspHingeShowroomPromptCard(
                    prompt: prompt,
                    isLiked: Binding(
                        get: { prompt.isLiked },
                        set: { store.setPromptLiked(prompt.id, liked: $0) }
                    ),
                    onCommentTap: {}
                )
                .padding(.horizontal, 16)
            }

            HStack(spacing: 10) {
                TextField("Add a comment about her response", text: $store.commentText, axis: .vertical)
                    .font(LpspHingeFonts.hingeCommentInput)
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .background(Capsule().fill(LpspHingeTokens.hingeSand))
                    .lineLimit(1...4)

                Button {
                    store.sendComment()
                    dismiss()
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(LpspHingeTokens.hingePaper)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle().fill(
                                store.commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                                    ? LpspHingeTokens.hingeBone
                                    : LpspHingeTokens.hingeBlack
                            )
                        )
                }
                .disabled(store.commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .padding(.top, 24)
        .presentationDetents([.medium, .large])
        .presentationBackground(LpspHingeTokens.hingePaper)
    }
}

private struct LpspHingeShowroomMatchScreen: View {
    @ObservedObject var store: LpspHingeStore

    var body: some View {
        LpspHingeMatchCelebration(
            myAvatar: Image(systemName: "person.circle.fill"),
            theirName: store.profile.name,
            theirAvatar: Image(systemName: "person.circle.fill"),
            onMessage: { store.showMatch = false; store.selectedTab = .matches },
            onKeepBrowsing: { store.showMatch = false }
        )
    }
}

private struct LpspHingeLikesYouTabScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("\(LpspHingeShowroomData.likesYouCount)")
                .font(LpspHingeFonts.hingeDisplay.weight(.bold))
                .foregroundStyle(LpspHingeTokens.hingeBlack)

            Text("people like you")
                .font(LpspHingeFonts.hingeBody)
                .foregroundStyle(LpspHingeTokens.hingeGraphite)

            HStack(spacing: 12) {
                ForEach(0..<3, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LpspHingeTokens.hingeSand)
                        .frame(width: 96, height: 120)
                        .overlay {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(LpspHingeTokens.hingeRose.opacity(0.55))
                        }
                        .blur(radius: index == 0 ? 0 : 6)
                }
            }

            LpspHingeHingePrimaryButton(label: "See who likes you") {}
                .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct LpspHingeStandoutsTabScreen: View {
    @ObservedObject var store: LpspHingeStore

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                LpspHingeStandoutsGradientCard(
                    answer: LpspHingeShowroomData.standoutAnswer,
                    onSendRose: { store.sendRose() }
                )

                if store.rosesSent > 0 {
                    Text("Rose sent · \(store.rosesSent)")
                        .font(LpspHingeFonts.hingeMeta.weight(.semibold))
                        .foregroundStyle(LpspHingeTokens.hingeRose)
                }
            }
            .padding(16)
        }
    }
}

private struct LpspHingeStandoutsGradientCard: View {
    let answer: String
    let onSendRose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(LpspHingeTokens.hingeRose)
                Text("Standout")
                    .font(LpspHingeFonts.hingeCaption.weight(.bold))
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                Spacer()
            }
            .frame(height: 32)
            .padding(.horizontal, 16)
            .background(LpspHingeTokens.hingeRoseLight)

            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.88, green: 0.72, blue: 0.55),
                            Color(red: 0.62, green: 0.48, blue: 0.38),
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .aspectRatio(1, contentMode: .fill)

            VStack(alignment: .leading, spacing: 16) {
                Text(answer)
                    .font(LpspHingeFonts.hingePromptA.weight(.semibold))
                    .foregroundStyle(LpspHingeTokens.hingeBlack)
                LpspHingeRoseCTA(label: "Send a Rose", action: onSendRose)
            }
            .padding(16)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LpspHingeTokens.hingePaper)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(
                            LinearGradient(
                                colors: [LpspHingeTokens.hingeRose, LpspHingeTokens.hingeRoseLight, LpspHingeTokens.hingeRose],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color(red: 0.110, green: 0.078, blue: 0.039).opacity(0.10), radius: 12, y: 4)
    }
}

private struct LpspHingeMatchesTabScreen: View {
    var body: some View {
        List {
            ForEach(LpspHingeShowroomData.matches, id: \.name) { match in
                HStack(spacing: 12) {
                    Circle()
                        .fill(LpspHingeTokens.hingeSand)
                        .frame(width: 48, height: 48)
                        .overlay {
                            Text(String(match.name.prefix(1)))
                                .font(LpspHingeFonts.hingeButton.weight(.bold))
                                .foregroundStyle(LpspHingeTokens.hingeBlack)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(match.name)
                            .font(LpspHingeFonts.hingeBodyBold.weight(.semibold))
                            .foregroundStyle(LpspHingeTokens.hingeBlack)
                        Text(match.preview)
                            .font(LpspHingeFonts.hingeMeta)
                            .foregroundStyle(LpspHingeTokens.hingeGraphite)
                            .lineLimit(1)
                    }

                    Spacer()

                    Text(match.time)
                        .font(LpspHingeFonts.hingeCaption)
                        .foregroundStyle(LpspHingeTokens.hingeStone)
                }
                .listRowBackground(LpspHingeTokens.hingeCream)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

private struct LpspHingeProfileTabScreen: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [LpspHingeTokens.hingeRoseLight, LpspHingeTokens.hingeSand],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 88, height: 88)
                    .overlay {
                        Text("Y")
                            .font(.title.weight(.bold))
                            .foregroundStyle(LpspHingeTokens.hingeBlack)
                    }

                Text("You, 29")
                    .font(LpspHingeFonts.hingeName.weight(.bold))
                    .foregroundStyle(LpspHingeTokens.hingeBlack)

                Text("SF · Design · Coffee")
                    .font(LpspHingeFonts.hingeMeta)
                    .foregroundStyle(LpspHingeTokens.hingeGraphite)

                LpspHingeHingePrimaryButton(label: "Edit profile") {}
                    .padding(.horizontal, 24)
            }
            .padding(.vertical, 24)
        }
    }
}


