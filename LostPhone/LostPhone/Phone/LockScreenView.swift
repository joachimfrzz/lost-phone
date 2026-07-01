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
                                SystemNotificationCard(notification: notification, compact: true)
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
