import SwiftUI

struct NotificationCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0

    private var groupedNotifications: [(app: String, items: [RuntimeNotification])] {
        var seen = Set<String>()
        var order: [String] = []
        for notification in phone.notifications {
            if seen.insert(notification.app).inserted {
                order.append(notification.app)
            }
        }
        return order.map { app in
            (app, phone.notifications.filter { $0.app == app })
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.opacity(0.25)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 20)
                    .padding(.top, 52)
                    .padding(.bottom, 16)

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 14) {
                        if phone.notifications.isEmpty {
                            ContentUnavailableView(
                                "Aucune notification",
                                systemImage: "bell.slash",
                                description: Text("Les alertes du scénario apparaîtront ici.")
                            )
                            .foregroundStyle(.white)
                            .padding(.top, 48)
                        } else {
                            ForEach(groupedNotifications, id: \.app) { group in
                                NotificationStackSection(appName: group.app, notifications: group.items)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background { notificationBackground }
            .offset(y: dragOffset)
            .gesture(dismissGesture)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(phone.lockDate.isEmpty ? formattedToday : phone.lockDate)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                    Text(phone.lockTime)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.75))
                }
                Spacer()
                if phone.unreadCount > 0 {
                    Button("Effacer") {
                        for index in phone.notifications.indices {
                            phone.notifications[index].lu = true
                        }
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.top, 8)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var formattedToday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: Date()).capitalized
    }

    @ViewBuilder
    private var notificationBackground: some View {
        ZStack {
            WallpaperView()
                .blur(radius: 48)
                .brightness(-0.12)
                .ignoresSafeArea()
            Rectangle()
                .fill(.ultraThinMaterial)
                .background(Color.black.opacity(0.35))
                .ignoresSafeArea()
        }
    }

    private var dismissGesture: some Gesture {
        DragGesture(minimumDistance: 8)
            .onChanged { value in
                dragOffset = min(0, value.translation.height)
            }
            .onEnded { value in
                if value.translation.height < -72 {
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

private struct NotificationStackSection: View {
    let appName: String
    let notifications: [RuntimeNotification]
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(LpspAppCatalog.accentColor(for: appName))
                    .frame(width: 22, height: 22)
                    .overlay {
                        if let asset = LpspAppCatalog.iconAsset(for: appName) {
                            Image(asset)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 14, height: 14)
                        } else {
                            Text(String(appName.prefix(1)))
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                Text(appName.uppercased())
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.55))
                Spacer()
                if notifications.count > 1 {
                    Text("\(notifications.count)")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.7))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(.white.opacity(0.12)))
                }
            }
            .padding(.horizontal, 4)

            VStack(spacing: 8) {
                ForEach(notifications) { notification in
                    SystemNotificationCard(notification: notification)
                        .onTapGesture {
                            phone.markNotificationRead(notification.id)
                        }
                }
            }
        }
    }
}
