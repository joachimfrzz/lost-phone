import SwiftUI

struct NotificationCenterOverlay: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var dragOffset: CGFloat = 0
    @State private var expandedStacks = Set<String>()

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
            Color.black.opacity(0.01)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(spacing: 0) {
                StatusBarView()
                    .padding(.top, 4)

                // iOS : grande date seule (pas d'heure ici)
                HStack {
                    Text(phone.lockDate.isEmpty ? formattedToday : phone.lockDate)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 14)

                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 10) {
                        if phone.notifications.isEmpty {
                            ContentUnavailableView(
                                Fr.noNotifications,
                                systemImage: "bell.slash",
                                description: Text(Fr.notificationHint)
                            )
                            .foregroundStyle(.white)
                            .padding(.top, 60)
                        } else {
                            ForEach(groupedNotifications, id: \.app) { group in
                                IOSNotificationStack(
                                    appName: group.app,
                                    notifications: group.items,
                                    isExpanded: expandedStacks.contains(group.app),
                                    onToggleExpand: {
                                        if expandedStacks.contains(group.app) {
                                            expandedStacks.remove(group.app)
                                        } else {
                                            expandedStacks.insert(group.app)
                                        }
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background { iosBlurBackground(darkness: 0.38) }
            .offset(y: dragOffset)
            .gesture(dismissGesture)
        }
    }

    private var formattedToday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: Date()).capitalized
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

private struct IOSNotificationStack: View {
    let appName: String
    let notifications: [RuntimeNotification]
    let isExpanded: Bool
    let onToggleExpand: () -> Void
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        VStack(spacing: 0) {
            if isExpanded {
                ForEach(Array(notifications.enumerated()), id: \.element.id) { index, notification in
                    IOSNotificationRow(notification: notification)
                        .padding(.top, index == 0 ? 0 : 8)
                        .onTapGesture { phone.markNotificationRead(notification.id) }
                }
            } else {
                ZStack(alignment: .top) {
                    if notifications.count > 2 {
                        stackShadow(offset: 8)
                        stackShadow(offset: 4)
                    } else if notifications.count > 1 {
                        stackShadow(offset: 4)
                    }

                    if let top = notifications.first {
                        IOSNotificationRow(notification: top, stackCount: notifications.count)
                            .onTapGesture {
                                if notifications.count > 1 {
                                    withAnimation(.spring(duration: 0.32)) { onToggleExpand() }
                                } else {
                                    phone.markNotificationRead(top.id)
                                }
                            }
                    }
                }
            }

            if isExpanded && notifications.count > 1 {
                Button(Fr.showLess) {
                    withAnimation(.spring(duration: 0.32)) { onToggleExpand() }
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.55))
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            }
        }
    }

    @ViewBuilder
    private func stackShadow(offset: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: IOSSystemStyle.notificationCornerRadius, style: .continuous)
            .fill(Color.white.opacity(0.08))
            .frame(height: 72)
            .padding(.horizontal, 6)
            .offset(y: offset)
            .scaleEffect(0.98)
    }
}

struct IOSNotificationRow: View {
    let notification: RuntimeNotification
    var stackCount: Int = 1

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                appIcon
                if stackCount > 1 {
                    Text("\(stackCount)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(.red))
                        .offset(x: 6, y: -6)
                }
            }

            VStack(alignment: .leading, spacing: 3) {
                HStack(alignment: .firstTextBaseline) {
                    Text(notification.titre)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    Spacer(minLength: 6)
                    Text(notification.heure)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Text(notification.texte)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: IOSSystemStyle.notificationCornerRadius, style: .continuous)
                .fill(.regularMaterial)
                .environment(\.colorScheme, .dark)
        )
    }

    private var appIcon: some View {
        Group {
            if let asset = LpspAppCatalog.iconAsset(for: notification.app) {
                Image(asset)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 38, height: 38)
                    .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
            } else {
                RoundedRectangle(cornerRadius: 9, style: .continuous)
                    .fill(LpspAppCatalog.accentColor(for: notification.app))
                    .frame(width: 38, height: 38)
                    .overlay {
                        Text(String(notification.app.prefix(1)))
                            .font(.caption.weight(.bold))
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}
