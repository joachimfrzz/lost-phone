import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/dating/bumble/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/bumble
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeBumbleView: View {
    var body: some View {
        LpspBumbleShowroomRoot()
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspBumbleTokens {
    // MARK: - Brand
    static let bumbleYellow      = Color(red: 1.000, green: 0.776, blue: 0.161) // #FFC629
    static let bumbleHoneyDeep   = Color(red: 0.961, green: 0.714, blue: 0.086) // #F5B616 pressed
    static let bumbleYellowLight = Color(red: 1.000, green: 0.914, blue: 0.631) // #FFE9A1 soft chip

    // MARK: - Mode colors (Date/BFF/Bizz)
    static let bumbleBFFTeal     = Color(red: 0.067, green: 0.667, blue: 0.659) // #11AAA8
    static let bumbleBizzOrange  = Color(red: 1.000, green: 0.502, blue: 0.000) // #FF8000

    // MARK: - Canvas & Surfaces
    static let bumbleCanvas      = Color(red: 1.000, green: 1.000, blue: 1.000) // #FFFFFF
    static let bumbleBFFCream    = Color(red: 1.000, green: 0.988, blue: 0.949) // #FFFCF2
    static let bumbleSurface1    = Color(red: 0.961, green: 0.961, blue: 0.961) // #F5F5F5
    static let bumbleSurface2    = Color(red: 0.929, green: 0.929, blue: 0.929) // #EDEDED
    static let bumbleDivider     = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5

    // MARK: - Text
    static let bumbleBlack       = Color(red: 0.122, green: 0.122, blue: 0.122) // #1F1F1F primary
    static let bumbleSlate       = Color(red: 0.353, green: 0.353, blue: 0.353) // #5A5A5A secondary
    static let bumbleMist        = Color(red: 0.612, green: 0.612, blue: 0.612) // #9C9C9C tertiary

    // MARK: - Semantic
    static let bumbleMatchPink   = Color(red: 0.914, green: 0.294, blue: 0.482) // #E94B7B
    static let bumbleVerified    = Color(red: 0.000, green: 0.400, blue: 1.000) // #0066FF
    static let bumbleError       = Color(red: 0.843, green: 0.149, blue: 0.220) // #D72638
    static let bumbleSuccess     = Color(red: 0.000, green: 0.659, blue: 0.420) // #00A86B
    static let bumbleWarning     = Color(red: 1.000, green: 0.584, blue: 0.000) // #FF9500

    // MARK: - Dark mode
    static let bumbleDarkCanvas  = Color(red: 0.059, green: 0.059, blue: 0.059) // #0F0F0F
    static let bumbleDarkSurface = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
    static let bumbleDarkSurface2 = Color(red: 0.165, green: 0.165, blue: 0.165) // #2A2A2A
    static let bumbleDarkDivider = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
    static let bumbleDarkText    = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
}



// Fallback when Brando isn't bundled — SF Pro is the warmest system substitute


fileprivate struct LpspBumbleBumblePrimaryButton: View {
    let label: String
    var hasGlow: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(LpspBumbleFonts.bumbleButton)
                .foregroundStyle(Color.black) // Pure black on yellow — WCAG AA requires it
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Capsule().fill(LpspBumbleTokens.bumbleYellow))
                .shadow(
                    color: hasGlow ? LpspBumbleTokens.bumbleYellow.opacity(0.4) : .clear,
                    radius: 24, y: 8
                )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .medium), trigger: UUID())
    }
}

fileprivate struct LpspBumbleSwipeActionRow: View {
    var onRewind: () -> Void
    var onPass:   () -> Void
    var onLike:   () -> Void
    var onSuper:  () -> Void
    var onCompliment: () -> Void

    var body: some View {
        HStack(spacing: 24) {
            // Rewind — small
            LpspBumbleActionCircle(diameter: 48, fill: LpspBumbleTokens.bumbleSurface1, stroke: nil) {
                Image(systemName: "arrow.uturn.backward").font(.system(size: 20)).foregroundStyle(LpspBumbleTokens.bumbleMist)
            } action: { onRewind() }

            // X Pass — medium
            LpspBumbleActionCircle(diameter: 56, fill: LpspBumbleTokens.bumbleCanvas, stroke: LpspBumbleTokens.bumbleBlack) {
                Image(systemName: "xmark").font(.system(size: 22, weight: .heavy)).foregroundStyle(LpspBumbleTokens.bumbleBlack)
            } action: {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                onPass()
            }

            // Heart Yes — large with yellow glow
            ZStack {
                Circle()
                    .fill(LpspBumbleTokens.bumbleYellow)
                    .frame(width: 64, height: 64)
                    .shadow(color: LpspBumbleTokens.bumbleYellow.opacity(0.5), radius: 16, y: 6)
                Image(systemName: "heart.fill")
                    .font(.system(size: 28, weight: .heavy))
                    .foregroundStyle(Color.black)
            }
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                onLike()
            }

            // Star SuperSwipe — medium yellow
            LpspBumbleActionCircle(diameter: 56, fill: LpspBumbleTokens.bumbleYellow, stroke: nil) {
                Image(systemName: "star.fill").font(.system(size: 22, weight: .heavy)).foregroundStyle(Color.black)
            } action: {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                onSuper()
            }

            // Bee Compliment — small
            LpspBumbleActionCircle(diameter: 56, fill: LpspBumbleTokens.bumbleCanvas, stroke: LpspBumbleTokens.bumbleYellow) {
                Image(systemName: "ant.fill") // bee placeholder
                    .font(.system(size: 22))
                    .foregroundStyle(LpspBumbleTokens.bumbleYellow)
            } action: { onCompliment() }
        }
    }
}

private enum LpspBumbleFonts {
    static let bumbleMatchHero    = Font.system(size: 44, weight: .regular)
    static let bumbleDisplay      = Font.system(size: 32, weight: .regular)
    static let bumbleScreenTitle  = Font.system(size: 24, weight: .regular)
    static let bumbleCardName     = Font.system(size: 28, weight: .regular)
    static let bumbleSection      = Font.system(size: 18, weight: .regular)
    static let bumbleBody         = Font.system(size: 16, weight: .regular)
    static let bumbleBodyBold     = Font.system(size: 16, weight: .regular)
    static let bumbleBodySmall    = Font.system(size: 14, weight: .regular)
    static let bumbleButton       = Font.system(size: 16, weight: .regular)
    static let bumbleButtonLarge  = Font.system(size: 18, weight: .regular)
    static let bumbleTab          = Font.system(size: 10, weight: .regular)
    static let bumbleChip         = Font.system(size: 13, weight: .regular)
    static let bumbleMeta         = Font.system(size: 13, weight: .regular)
    static let bumbleCounter      = Font.system(size: 11, weight: .regular)
    static let bumbleCompliment   = Font.system(size: 22, weight: .regular)
    static func bumble(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

private struct LpspBumbleActionCircle<Content: View>: View {
    let diameter: CGFloat
    let fill: Color
    let stroke: Color?
    @ViewBuilder var content: Content
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(fill)
                    .overlay(stroke.map { Circle().strokeBorder($0, lineWidth: 1.5) })
                content
            }
            .frame(width: diameter, height: diameter)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspBumbleSwipeCard: View {
    let photos: [Image]
    let name: String
    let age: Int
    let bio: String
    let isVerified: Bool
    @State private var currentPhoto = 0

    var body: some View {
        ZStack {
            // Photo
            photos[currentPhoto]
                .resizable()
                .aspectRatio(3/4, contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            // Photo progress bar (4 segments)
            VStack {
                HStack(spacing: 4) {
                    ForEach(0..<photos.count, id: \.self) { idx in
                        Capsule()
                            .fill(idx == currentPhoto ? Color.white : Color.white.opacity(0.4))
                            .frame(height: 3)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                Spacer()
            }

            // Bottom gradient overlay
            VStack {
                Spacer()
                LinearGradient(
                    colors: [.clear, .black.opacity(0.7)],
                    startPoint: .top, endPoint: .bottom
                )
                .frame(height: 200)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Name+age + bio
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("\(name), \(age)")
                        .font(LpspBumbleFonts.bumbleCardName)
                        .foregroundStyle(.white)
                    if isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(LpspBumbleTokens.bumbleVerified)
                    }
                }
                Text(bio).font(LpspBumbleFonts.bumbleBody).foregroundStyle(.white).lineLimit(1)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(3/4, contentMode: .fit)
        .shadow(color: .black.opacity(0.12), radius: 16, y: 4)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in /* track drag */ }
                .onEnded { value in
                    if abs(value.translation.width) > 100 {
                        // commit swipe
                    }
                }
        )
    }
}

fileprivate struct LpspBumbleCountdownChip: View {
    let remaining: TimeInterval        // seconds
    @State private var pulse = false

    var formatted: String {
        let h = Int(remaining) / 3600
        let m = (Int(remaining) % 3600) / 60
        if remaining <= 0 { return "Time's up — extend?" }
        return "Your turn: \(h)h \(m)m"
    }

    var isExpired: Bool { remaining <= 0 }

    var body: some View {
        Text(formatted)
            .font(LpspBumbleFonts.bumbleMeta)
            .fontWeight(.bold)
            .foregroundStyle(Color.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .frame(height: 32)
            .background(
                Capsule()
                    .fill(isExpired ? LpspBumbleTokens.bumbleError : LpspBumbleTokens.bumbleYellow)
                    .overlay(Capsule().stroke(LpspBumbleTokens.bumbleHoneyDeep, lineWidth: 1))
            )
            .opacity(pulse ? 1.0 : 0.95)
            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: pulse)
            .onAppear { pulse = true }
    }
}

fileprivate struct LpspBumbleMatchCelebration: View {
    let myAvatar: Image
    let theirAvatar: Image
    let theirName: String
    var onSendMessage: () -> Void
    var onKeepSwiping: () -> Void

    @State private var heartScale: CGFloat = 0.2

    var body: some View {
        ZStack {
            LpspBumbleTokens.bumbleYellow.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                ZStack {
                    HStack(spacing: 32) {
                        LpspBumbleHexAvatar(image: myAvatar)
                        LpspBumbleHexAvatar(image: theirAvatar)
                    }
                    Image(systemName: "heart.fill")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundStyle(LpspBumbleTokens.bumbleMatchPink)
                        .scaleEffect(heartScale)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                }

                VStack(spacing: 12) {
                    Text("It's a Match!")
                        .font(LpspBumbleFonts.bumbleMatchHero)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                        .tracking(-0.8)
                    Text("You and \(theirName) want to chat")
                        .font(LpspBumbleFonts.bumbleBody)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }

                Text("She has 24 hours to make the first move")
                    .font(LpspBumbleFonts.bumbleMeta)
                    .foregroundStyle(LpspBumbleTokens.bumbleBlack.opacity(0.8))

                Spacer()

                VStack(spacing: 16) {
                    Button(action: onSendMessage) {
                        Text("Send a Message")
                            .font(LpspBumbleFonts.bumbleButtonLarge)
                            .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Capsule().fill(Color.white))
                    }
                    .buttonStyle(.plain)

                    Button("Keep Swiping", action: onKeepSwiping)
                        .font(LpspBumbleFonts.bumbleButton)
                        .foregroundStyle(LpspBumbleTokens.bumbleBlack)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.55)) {
                heartScale = 1.0
            }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
}

fileprivate struct LpspBumbleHexAvatar: View {
    let image: Image
    var size: CGFloat = 120
    var stroke: Color = .white

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(LpspBumbleHexagon())
            .overlay(LpspBumbleHexagon().stroke(stroke, lineWidth: 4))
    }
}

fileprivate struct LpspBumbleHexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        for i in 0..<6 {
            let angle = CGFloat.pi / 3 * CGFloat(i) - CGFloat.pi / 2
            let point = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            if i == 0 { path.move(to: point) } else { path.addLine(to: point) }
        }
        path.closeSubpath()
        return path
    }
}

fileprivate struct LpspBumbleBumbleChatInput: View {
    @Binding var text: String
    var onSend: () -> Void

    var canSend: Bool { !text.isEmpty }

    var body: some View {
        HStack(spacing: 10) {
            TextField("Type your message…", text: $text, axis: .vertical)
                .font(LpspBumbleFonts.bumbleBody)
                .padding(.vertical, 14)
                .padding(.horizontal, 20)
                .background(Capsule().fill(LpspBumbleTokens.bumbleSurface1))
                .lineLimit(1...4)

            Button {
                onSend()
            } label: {
                Image(systemName: "arrow.up")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(canSend ? Color.black : LpspBumbleTokens.bumbleMist)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(canSend ? LpspBumbleTokens.bumbleYellow : LpspBumbleTokens.bumbleSurface1))
            }
            .disabled(!canSend)
            .sensoryFeedback(.impact(weight: .medium), trigger: canSend == false)
        }
        .padding(.horizontal, 16)
    }
}



// MARK: - Écrans showroom

private struct LpspBumbleShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspBumbleDatingTabScreen(title: "People", tabIndex: 0)
                .tabItem { Label("People", systemImage: "person.2") }
                .tag(0)
            LpspBumbleDatingTabScreen(title: "Hives", tabIndex: 1)
                .tabItem { Label("Hives", systemImage: "hexagon.fill") }
                .tag(1)
            LpspBumbleDatingTabScreen(title: "Matches", tabIndex: 2)
                .tabItem { Label("Matches", systemImage: "heart.fill") }
                .tag(2)
            LpspBumbleDatingMessagesTabScreen()
                .tabItem { Label("Chats", systemImage: "bubble.left.fill") }
                .tag(3)
            LpspBumbleDatingProfileTabScreen()
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
                .tag(4)
        }
        .tint(LpspBumbleTokens.bumbleYellow)
        
    }
}


private struct LpspBumbleGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspBumbleTokens.bumbleYellow.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspBumbleTokens.bumbleYellow))
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


private struct LpspBumbleDemoChatBubble: View {
    let text: String
    var outgoing: Bool
    var body: some View {
        HStack {
            if outgoing { Spacer(minLength: 40) }
            Text(text).padding(12).background(RoundedRectangle(cornerRadius: 16).fill(outgoing ? LpspBumbleTokens.bumbleYellow.opacity(0.2) : Color(.systemGray5)))
            if !outgoing { Spacer(minLength: 40) }
        }.padding(.horizontal)
    }
}

private struct LpspBumbleDatingDiscoverTabScreen: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            LpspBumbleSwipeCard(
                photos: [Image(systemName: "person.fill")],
                name: "Alex",
                age: 28,
                bio: "Paris · Photo · Voyage",
                isVerified: true
            )
        }
    }
}

private struct LpspBumbleDatingMessagesTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView { LazyVStack(spacing: 8) { 
                    LpspBumbleDemoChatBubble(text: "Salut ! On se voit ce week-end ?", outgoing: false)
                    LpspBumbleDemoChatBubble(text: "Avec plaisir 😊", outgoing: true)
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

private struct LpspBumbleDatingTopPicksTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView { LpspBumbleDemoSwipeCard(accent: LpspBumbleTokens.bumbleYellow).padding() }
            .navigationTitle("Top Picks")
        }
    }
}

private struct LpspBumbleDatingProfileTabScreen: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Circle().fill(LpspBumbleTokens.bumbleYellow.gradient).frame(width: 88, height: 88)
                Text("Alex, 28").font(.title2.bold())
                Text("Paris · Design · Voyage").foregroundStyle(.secondary)
            }
            .navigationTitle("Profil")
        }
    }
}

private struct LpspBumbleDatingTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        let low = title.lowercased()
        if low.contains("découv") || low.contains("discover") || low.contains("flame") || low.contains("swipe") { LpspBumbleDatingDiscoverTabScreen() }
        else if low.contains("message") || low.contains("chat") { LpspBumbleDatingMessagesTabScreen() }
        else if low.contains("star") || low.contains("top") { LpspBumbleDatingTopPicksTabScreen() }
        else { LpspBumbleDatingProfileTabScreen() }
    }
}

private struct LpspBumbleDemoSwipeCard: View {
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


