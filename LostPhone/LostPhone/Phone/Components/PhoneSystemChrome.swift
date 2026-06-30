import SwiftUI

/// Gestes système (centre notifs / centre contrôle) + overlays partagés sur verrou et home.
struct PhoneSystemChrome: ViewModifier {
    @EnvironmentObject private var phone: PhoneViewModel

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                systemGestureStrip
            }
            .overlay {
                if phone.overlay == .notifications {
                    NotificationCenterOverlay()
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
                if phone.overlay == .controlCenter {
                    ControlCenterOverlay()
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .animation(.spring(duration: 0.35), value: phone.overlay)
    }

    private var systemGestureStrip: some View {
        HStack(spacing: 0) {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { phone.openNotificationCenter() }
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            if value.translation.height > 40 {
                                phone.openNotificationCenter()
                            }
                        }
                )
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture { phone.openControlCenter() }
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            if value.translation.height > 40 {
                                phone.openControlCenter()
                            }
                        }
                )
        }
        .frame(height: 44)
        .padding(.horizontal, 8)
    }
}

extension View {
    func phoneSystemChrome() -> some View {
        modifier(PhoneSystemChrome())
    }
}
