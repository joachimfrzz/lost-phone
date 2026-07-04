import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/hinge
// Meliwat/awesome-ios-design-md/dating/hinge/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeHingeView: View {
    var body: some View {
        LpspHingeShowroomRoot()
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



// MARK: - Écrans showroom

private struct LpspHingeShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspHingeSpectrHomeTabScreen()
                .tabItem { Label("Discover", systemImage: "safari") }
                .tag(0)
            LpspHingeDatingTabScreen(title: "Likes You", tabIndex: 1)
                .tabItem { Label("Likes You", systemImage: "heart") }
                .tag(1)
            LpspHingeDatingTopPicksTabScreen()
                .tabItem { Label("Standouts", systemImage: "star") }
                .tag(2)
            LpspHingeDatingTabScreen(title: "Matches", tabIndex: 3)
                .tabItem { Label("Matches", systemImage: "bubble.left") }
                .tag(3)
            LpspHingeDatingProfileTabScreen()
                .tabItem { Label("Profile", systemImage: "person") }
                .tag(4)
        }
        .tint(LpspHingeTokens.hingeMatchGreen)
        
    }
}


private struct LpspHingeGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspHingeTokens.hingeMatchGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspHingeTokens.hingeMatchGreen))
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


private struct LpspHingeDemoChatBubble: View {
    let text: String
    var outgoing: Bool
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 40) }
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspHingeTokens.hingeMatchGreen.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 40) }
        }.padding(.horizontal)
    }
}

private struct LpspHingeDatingDiscoverTabScreen: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            LpspHingeDemoSwipeCard(accent: LpspHingeTokens.hingeMatchGreen)
        }
    }
}

private struct LpspHingeDatingMessagesTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView { LazyVStack(spacing: 8) { 
                    LpspHingeDemoChatBubble(text: "Salut ! On se voit ce week-end ?", outgoing: false)
                    LpspHingeDemoChatBubble(text: "Avec plaisir 😊", outgoing: true)
 } .padding(.vertical) }
                HStack {
                    TextField("Message", text: .constant(""))
                        .padding(10).background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemGray6)))
                }.padding(8)
            }
            .navigationTitle("Messages")
        }
    }
}

private struct LpspHingeDatingTopPicksTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView { LpspHingeStandoutsCard(name: "Léa", age: 27, prompt: "Mon spot préféré à Paris").padding() }
            .navigationTitle("Top Picks")
        }
    }
}

private struct LpspHingeDatingProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Circle().fill(LpspHingeTokens.hingeMatchGreen.gradient).frame(width: 88, height: 88)
                Text("Alex, 28").font(.title2.bold())
                Text("Paris · Design · Voyage").foregroundStyle(.secondary)
            }
            .navigationTitle("Profil")
        }
    }
}

private struct LpspHingeDatingTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if low.contains("découv") || low.contains("discover") || low.contains("flame") || low.contains("swipe") { LpspHingeDatingDiscoverTabScreen() }
        else if low.contains("message") || low.contains("chat") { LpspHingeDatingMessagesTabScreen() }
        else if low.contains("star") || low.contains("top") { LpspHingeDatingTopPicksTabScreen() }
        else { LpspHingeDatingProfileTabScreen() }
    }
}

private struct LpspHingeDemoSwipeCard: View {
    let accent: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(LinearGradient(colors: [accent.opacity(0.3), .black.opacity(0.8)], startPoint: .top, endPoint: .bottom))
            .frame(width: 320, height: 480)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text("Alex, 28").font(.title.bold()).foregroundStyle(.white)
                    Text("Paris · Photo · Voyage").foregroundStyle(.white.opacity(0.9))
                }
                .padding(20)
            }
    }
}


private struct LpspHingeSpectrHomeTabScreen: View {
    var body: some View {
        VStack(spacing: 0) {
        HStack {
            Text("H").font(.system(size: 16.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
            Text("Discover").font(.system(size: 20.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        } .padding(.horizontal, 16).frame(height: 48)
        ScrollView {
                Text("Sigrún, 28").font(.system(size: 26.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("2 mi away").font(.system(size: 13.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("5'9\"").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Engineer").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("SF").font(.system(size: 12.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("I geek out on _").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Specialty coffee, vintage Vespas, and the chess opening called the Sicilian Najdorf.").font(.system(size: 17.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("My simple pleasures").font(.system(size: 14.0, weight: .regular)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
                Text("Sunday mornings with a record on.").font(.system(size: 17.0, weight: .bold)).foregroundStyle(Color(red: 1.000, green: 1.000, blue: 1.000))
        }
        HStack(spacing: 16) {

        } .font(.system(size: 22)).padding(.horizontal, 14).frame(height: 44)
        }
        .background(Color(red: 1.000, green: 1.000, blue: 1.000).ignoresSafeArea())
    }
}


