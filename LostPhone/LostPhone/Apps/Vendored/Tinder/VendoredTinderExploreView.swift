import SwiftUI

struct VendoredTinderExploreView: View {
    @State private var index = 0
    @State private var dragOffset: CGSize = .zero
    @State private var showLike = false
    @State private var showNope = false
    @State private var selectedProfile: VendoredTinderProfile?

    private var profiles: [VendoredTinderProfile] { VendoredTinderData.explore }
    private var current: VendoredTinderProfile? {
        guard index < profiles.count else { return nil }
        return profiles[index]
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ZStack {
                    if let profile = current {
                        card(for: profile)
                            .offset(dragOffset)
                            .rotationEffect(.degrees(Double(dragOffset.width / 20)))
                            .gesture(dragGesture)
                            .onTapGesture { selectedProfile = profile }
                    } else {
                        Text("Plus de profils")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 20)
                .frame(maxHeight: .infinity)

                actionBar
            }
            .background(Color.white)
            .navigationDestination(item: $selectedProfile) { profile in
                VendoredTinderExploreDetailView(profile: profile)
            }
        }
    }

    private func card(for profile: VendoredTinderProfile) -> some View {
        ZStack(alignment: .bottomLeading) {
            VendoredTinderBundledPhoto(imageName: profile.imageName)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

            LinearGradient(
                colors: [.black.opacity(0.25), .clear],
                startPoint: .bottom,
                endPoint: .top
            )

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(profile.name)
                        .font(.system(size: 24, weight: .bold))
                    Text(profile.age)
                        .font(.system(size: 22))
                }
                HStack(spacing: 8) {
                    Circle().fill(Color.green).frame(width: 10, height: 10)
                    Text("Recently Active")
                        .font(.system(size: 16))
                }
                HStack {
                    ForEach(Array(profile.likes.enumerated()), id: \.offset) { i, tag in
                        Text(tag)
                            .font(.system(size: 14))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 3)
                            .background(
                                i == 0 ? Color.white.opacity(0.4) : Color.white.opacity(0.2),
                                in: Capsule()
                            )
                            .overlay {
                                if i == 0 { Capsule().stroke(.white, lineWidth: 2) }
                            }
                    }
                }
            }
            .foregroundStyle(.white)
            .padding(15)

            if showLike {
                stamp("LIKE", color: VendoredTinderTheme.likeGreen, rotation: -15)
            }
            if showNope {
                stamp("NOPE", color: VendoredTinderTheme.primary, rotation: 15)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .gray.opacity(0.3), radius: 5, y: 2)
    }

    private func stamp(_ text: String, color: Color, rotation: Double) -> some View {
        Text(text)
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(color)
            .padding(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color, lineWidth: 5)
            }
            .rotationEffect(.degrees(rotation))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(15)
    }

    private var actionBar: some View {
        HStack {
            actionButton("arrow.counterclockwise", size: 45) { rewind() }
            actionButton("xmark", size: 58, tint: VendoredTinderTheme.primary) { swipe(.left) }
            actionButton("star.fill", size: 45, tint: .blue) { advance() }
            actionButton("heart.fill", size: 57, tint: VendoredTinderTheme.likeGreen) { swipe(.right) }
            actionButton("bolt.fill", size: 45, tint: .purple) { advance() }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        .frame(height: 100)
    }

    private func actionButton(_ symbol: String, size: CGFloat, tint: Color = .gray, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: symbol)
                .font(.system(size: size * 0.4, weight: .bold))
                .foregroundStyle(tint)
                .frame(width: size, height: size)
                .background(Circle().fill(.white).shadow(color: .gray.opacity(0.1), radius: 10))
        }
        .buttonStyle(.plain)
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                dragOffset = value.translation
                showLike = value.translation.width > 40
                showNope = value.translation.width < -40
            }
            .onEnded { value in
                if value.translation.width > 120 {
                    swipe(.right)
                } else if value.translation.width < -120 {
                    swipe(.left)
                } else {
                    withAnimation(.spring()) {
                        dragOffset = .zero
                        showLike = false
                        showNope = false
                    }
                }
            }
    }

    private enum SwipeDir { case left, right }

    private func swipe(_ dir: SwipeDir) {
        withAnimation(.easeOut(duration: 0.25)) {
            dragOffset = CGSize(width: dir == .right ? 500 : -500, height: 0)
            showLike = dir == .right
            showNope = dir == .left
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            advance()
        }
    }

    private func advance() {
        index += 1
        dragOffset = .zero
        showLike = false
        showNope = false
    }

    private func rewind() {
        guard index > 0 else { return }
        index -= 1
        dragOffset = .zero
        showLike = false
        showNope = false
    }
}
