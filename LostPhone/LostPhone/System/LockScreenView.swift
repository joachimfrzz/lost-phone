import SwiftUI

struct LockScreenView: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack {
            WallpaperView()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                StatusBarView()
                    .padding(.top, 4)

                VStack(spacing: 8) {
                    Text(phone.lockDate)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.92))
                    Text(phone.lockTime)
                        .font(.system(size: 86, weight: .thin, design: .default))
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.7)
                }
                .padding(.top, 18)

                if !phone.notifications.isEmpty {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(phone.notifications.prefix(4)) { notification in
                                LockNotificationCard(notification: notification)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                    }
                }

                Spacer()

                HStack {
                    LockShortcutButton(systemName: "flashlight.fill")
                    Spacer()
                    LockShortcutButton(systemName: "camera.fill")
                }
                .padding(.horizontal, 42)
                .padding(.bottom, 12)

                Capsule()
                    .fill(.white.opacity(0.92))
                    .frame(width: 140, height: 5)
                    .padding(.bottom, 8)
            }
            .offset(y: -dragOffset * 0.85)
            .opacity(1 - Double(dragOffset) / 400)
        }
        .gesture(unlockGesture)
    }

    private var unlockGesture: some Gesture {
        DragGesture(minimumDistance: 12)
            .onChanged { value in
                dragOffset = max(0, -value.translation.height)
            }
            .onEnded { value in
                if -value.translation.height > 80 || -value.predictedEndTranslation.height > 120 {
                    withAnimation(.spring(duration: 0.38)) {
                        dragOffset = 320
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
                        phone.swipeToUnlock()
                        dragOffset = 0
                    }
                } else {
                    withAnimation(.spring(duration: 0.32)) {
                        dragOffset = 0
                    }
                }
            }
    }
}

struct LockShortcutButton: View {
    let systemName: String

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(.white)
            .frame(width: 56, height: 56)
            .background(Circle().fill(.white.opacity(0.14)))
            .overlay(Circle().strokeBorder(.white.opacity(0.28), lineWidth: 1))
    }
}

struct LockNotificationCard: View {
    let notification: RuntimeNotification

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(appTint(notification.app))
                .frame(width: 38, height: 38)
                .overlay {
                    Text(String(notification.app.prefix(1)))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.titre)
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Text(notification.heure)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Text(notification.texte)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private func appTint(_ app: String) -> Color {
        switch app {
        case "Messages": return .green
        case "WhatsApp": return Color(red: 0.15, green: 0.78, blue: 0.45)
        case "Signal": return .blue
        default: return .gray
        }
    }
}
