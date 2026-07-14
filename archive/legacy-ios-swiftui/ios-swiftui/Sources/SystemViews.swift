import SwiftUI

struct LockScreenView: View {
    @ObservedObject var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0

    private var envelope: LpspEnvelope? { phone.package?.content.envelope }

    var body: some View {
        ZStack {
            WallpaperView(description: envelope?.fondEcran?.description)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(height: 8)

                VStack(spacing: 6) {
                    Text(envelope?.heureVerrou ?? "14:30")
                        .font(.system(size: 96, weight: .thin, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.25), radius: 8, y: 2)

                    Text(envelope?.dateVerrou ?? "")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding(.top, 12)

                Spacer()

                Text("Glisser vers le haut pour ouvrir")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white.opacity(0.55))
                    .opacity(max(0, 0.6 - Double(dragOffset) / 120))

                Capsule()
                    .fill(.white.opacity(0.92))
                    .frame(width: 134, height: 5)
                    .padding(.bottom, 8)
            }
            .offset(y: -dragOffset * 0.85)
            .opacity(1 - Double(dragOffset) / 400)
        }
        .gesture(
            DragGesture(minimumDistance: 10)
                .onChanged { value in
                    dragOffset = max(0, -value.translation.height)
                }
                .onEnded { value in
                    if -value.translation.height > 80 || -value.predictedEndTranslation.height > 120 {
                        withAnimation(.spring(duration: 0.38)) {
                            dragOffset = 400
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            phone.swipeToUnlock()
                            dragOffset = 0
                        }
                    } else {
                        withAnimation(.spring(duration: 0.32)) {
                            dragOffset = 0
                        }
                    }
                }
        )
        .statusBarHidden(false)
    }
}

struct PinCodeView: View {
    @ObservedObject var phone: PhoneViewModel
    @State private var digits = ""

    var body: some View {
        ZStack {
            WallpaperView(description: phone.package?.content.envelope.fondEcran?.description)
                .blur(radius: 12)
                .brightness(-0.2)
                .ignoresSafeArea()

            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer().frame(height: 72)
                Text("Entrez le code")
                    .font(.system(size: 17))
                    .foregroundStyle(.white)

                HStack(spacing: 22) {
                    ForEach(0..<4, id: \.self) { i in
                        Circle()
                            .strokeBorder(.white.opacity(0.45), lineWidth: 1.5)
                            .background(Circle().fill(i < digits.count ? .white : .clear))
                            .frame(width: 12, height: 12)
                    }
                }
                .modifier(ShakeEffect(shakes: phone.pinError ? 2 : 0))

                PinKeypadView { key in
                    if key == "delete" {
                        digits = String(digits.dropLast())
                    } else if digits.count < 4 {
                        digits += key
                        if digits.count == 4 {
                            phone.submitPin(digits)
                            digits = ""
                        }
                    }
                }

                Spacer()
            }
        }
    }
}

struct HomeScreenView: View {
    @ObservedObject var phone: PhoneViewModel

    private var apps: [String] {
        phone.package?.manifest.appsPresentes ?? []
    }

    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)

    var body: some View {
        ZStack {
            WallpaperView(description: phone.package?.content.envelope.fondEcran?.description)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                LazyVGrid(columns: columns, spacing: 28) {
                    ForEach(apps, id: \.self) { app in
                        Button {
                            phone.openApp(app)
                        } label: {
                            VStack(spacing: 5) {
                                RoundedRectangle(cornerRadius: 13.65, style: .continuous)
                                    .fill(appColor(app))
                                    .frame(width: 60, height: 60)
                                Text(app)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 26)
                .padding(.top, 24)

                Spacer()

                HStack(spacing: 6) {
                    Image(systemName: "magnifyingglass")
                    Text("Rechercher")
                }
                .font(.system(size: 17))
                .foregroundStyle(.white.opacity(0.92))
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial, in: Capsule())
                .padding(.bottom, 10)

                HStack(spacing: 0) {
                    ForEach((phone.package?.content.system?.dock ?? apps.prefix(4)).map { $0 as String? } ?? [], id: \.self) { name in
                        if let name {
                            Button { phone.openApp(name) } label: {
                                RoundedRectangle(cornerRadius: 13.65, style: .continuous)
                                    .fill(appColor(name))
                                    .frame(width: 60, height: 60)
                            }
                            .buttonStyle(.plain)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
                .padding(.horizontal, 14)
                .padding(.bottom, 28)
            }
        }
    }

    private func appColor(_ app: String) -> Color {
        switch app {
        case "Messages": return Color(red: 0.2, green: 0.78, blue: 0.35)
        case "Photos": return .white.opacity(0.9)
        case "Réglages", "Settings": return Color(white: 0.45)
        default: return Color(red: 0.35, green: 0.55, blue: 0.95)
        }
    }
}

struct AppHostView: View {
    let appName: String
    @ObservedObject var phone: PhoneViewModel

    var body: some View {
        NavigationStack {
            ContentUnavailableView(appName, systemImage: "app.fill", description: Text("App à porter depuis le LPSP"))
                .navigationTitle(appName)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Accueil") { phone.closeApp() }
                    }
                }
        }
    }
}

struct WallpaperView: View {
    let description: String?

    var body: some View {
        LinearGradient(
            colors: [Color(red: 0.55, green: 0.35, blue: 0.25), Color(red: 0.12, green: 0.08, blue: 0.05)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

struct PinKeypadView: View {
    let onKey: (String) -> Void

    private let rows: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["", "0", "delete"]
    ]

    var body: some View {
        VStack(spacing: 6) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \.self) { key in
                        if key.isEmpty {
                            Color.clear.frame(width: 78, height: 78)
                        } else {
                            Button {
                                onKey(key)
                            } label: {
                                Group {
                                    if key == "delete" {
                                        Image(systemName: "delete.left")
                                            .font(.system(size: 22))
                                    } else {
                                        Text(key)
                                            .font(.system(size: 32, weight: .light))
                                    }
                                }
                                .frame(width: 78, height: 78)
                                .foregroundStyle(.white)
                                .background(Circle().fill(.white.opacity(key == "delete" ? 0 : 0.12)))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

struct ShakeEffect: GeometryEffect {
    var shakes: CGFloat

    var animatableData: CGFloat {
        get { shakes }
        set { shakes = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: 10 * sin(shakes * .pi * 2), y: 0))
    }
}
