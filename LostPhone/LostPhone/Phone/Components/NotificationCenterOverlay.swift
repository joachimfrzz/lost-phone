import SwiftUI

struct NotificationCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 0) {
                HStack {
                    Text(phone.lockDate.isEmpty ? "Aujourd'hui" : phone.lockDate)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Button("Effacer") {
                        phone.notifications.indices.forEach { phone.notifications[$0].lu = true }
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.85))
                    .opacity(phone.unreadCount > 0 ? 1 : 0.4)
                    .disabled(phone.unreadCount == 0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 12)

                ScrollView {
                    LazyVStack(spacing: 10) {
                        if phone.notifications.isEmpty {
                            ContentUnavailableView(
                                "Aucune notification",
                                systemImage: "bell.slash",
                                description: Text("Les alertes du scénario apparaîtront ici.")
                            )
                            .foregroundStyle(.white)
                            .padding(.top, 40)
                        } else {
                            ForEach(phone.notifications) { notification in
                                NotificationCenterRow(notification: notification)
                                    .onTapGesture {
                                        phone.markNotificationRead(notification.id)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
            .frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 0.15, green: 0.18, blue: 0.28).opacity(0.95),
                                Color(red: 0.08, green: 0.1, blue: 0.16).opacity(0.92),
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .ignoresSafeArea()
            }
            .offset(y: dragOffset)
            .gesture(dismissGesture)
        }
    }

    private var dismissGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                dragOffset = min(0, value.translation.height)
            }
            .onEnded { value in
                if value.translation.height < -60 {
                    dismiss()
                } else {
                    withAnimation(.spring(duration: 0.32)) { dragOffset = 0 }
                }
            }
    }

    private func dismiss() {
        withAnimation(.spring(duration: 0.35)) {
            phone.closeOverlay()
        }
    }
}

private struct NotificationCenterRow: View {
    let notification: RuntimeNotification

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 9, style: .continuous)
                .fill(appTint(notification.app))
                .frame(width: 40, height: 40)
                .overlay {
                    Text(String(notification.app.prefix(1)))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.app.uppercased())
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(notification.heure)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Text(notification.titre)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                Text(notification.texte)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    if !notification.lu {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .strokeBorder(.white.opacity(0.2), lineWidth: 0.5)
                    }
                }
        )
    }

    private func appTint(_ app: String) -> Color {
        LpspAppCatalog.accentColor(for: app)
    }
}
