import SwiftUI

// MARK: - Centre de notifications (iOS 17 pixel-accurate)

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
        GeometryReader { geo in
            let scale = geo.size.width / IOSMetrics.screenWidth
            let pad = IOSMetrics.ncHorizontalPadding * scale

            ZStack(alignment: .top) {
                Color.black.opacity(0.01)
                    .ignoresSafeArea()
                    .onTapGesture { dismiss() }

                VStack(spacing: 0) {
                    IOSOverlayStatusBar(scale: scale)
                        .padding(.top, IOSMetrics.statusBarTopPadding * scale)

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 0) {
                            dateHeader(scale: scale)
                                .padding(.horizontal, pad)
                                .padding(.top, 8 * scale)
                                .padding(.bottom, 20 * scale)

                            if phone.notifications.isEmpty {
                                emptyState(scale: scale)
                                    .padding(.horizontal, pad)
                            } else {
                                LazyVStack(spacing: IOSMetrics.ncStackSpacing * scale) {
                                    ForEach(groupedNotifications, id: \.app) { group in
                                        IOSNotificationStack(
                                            appName: group.app,
                                            notifications: group.items,
                                            isExpanded: expandedStacks.contains(group.app),
                                            scale: scale,
                                            onToggleExpand: {
                                                withAnimation(.spring(duration: 0.32)) {
                                                    if expandedStacks.contains(group.app) {
                                                        expandedStacks.remove(group.app)
                                                    } else {
                                                        expandedStacks.insert(group.app)
                                                    }
                                                }
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal, pad)
                            }
                        }
                        .padding(.bottom, 48 * scale)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background { iosBlurBackground(darkness: 0.38) }
                .offset(y: dragOffset)
                .gesture(dismissGesture)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Centre de notifications")
    }

    private func dateHeader(scale: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 2 * scale) {
            Text(formattedWeekday)
                .font(.system(size: IOSMetrics.ncWeekdayFont * scale, weight: .regular))
                .foregroundStyle(.white.opacity(0.55))
                .textCase(.uppercase)
            Text(formattedDayMonth)
                .font(.system(size: IOSMetrics.ncDateFont * scale, weight: .bold))
                .foregroundStyle(.white)
        }
    }

    private var formattedWeekday: String {
        if !phone.lockDate.isEmpty {
            let parts = phone.lockDate.split(separator: " ", maxSplits: 1)
            if let first = parts.first {
                return String(first)
            }
        }
        let f = DateFormatter()
        f.locale = Locale(identifier: "fr_FR")
        f.dateFormat = "EEEE"
        return f.string(from: Date())
    }

    private var formattedDayMonth: String {
        if !phone.lockDate.isEmpty {
            let parts = phone.lockDate.split(separator: " ", maxSplits: 1)
            if parts.count > 1 {
                return String(parts[1])
            }
            return phone.lockDate
        }
        let f = DateFormatter()
        f.locale = Locale(identifier: "fr_FR")
        f.dateFormat = "d MMMM"
        return f.string(from: Date())
    }

    private func emptyState(scale: CGFloat) -> some View {
        VStack(spacing: 12 * scale) {
            Image(systemName: "bell.slash")
                .font(.system(size: 40 * scale, weight: .light))
                .foregroundStyle(.white.opacity(0.35))
            Text(Fr.noNotifications)
                .font(.system(size: 17 * scale, weight: .medium))
                .foregroundStyle(.white.opacity(0.55))
            Text(Fr.notificationHint)
                .font(.system(size: 15 * scale))
                .foregroundStyle(.white.opacity(0.4))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80 * scale)
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

// MARK: - Pile de notifications (effet iOS, sans badge rouge)

private struct IOSNotificationStack: View {
    let appName: String
    let notifications: [RuntimeNotification]
    let isExpanded: Bool
    let scale: CGFloat
    let onToggleExpand: () -> Void
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        VStack(spacing: 0) {
            if isExpanded {
                ForEach(Array(notifications.enumerated()), id: \.element.id) { index, notification in
                    IOSNotificationRow(notification: notification, scale: scale)
                        .padding(.top, index == 0 ? 0 : IOSMetrics.ncStackSpacing * scale)
                        .onTapGesture { phone.markNotificationRead(notification.id) }
                }
            } else {
                ZStack(alignment: .top) {
                    let peekCount = min(notifications.count - 1, 2)
                    ForEach((0..<peekCount).reversed(), id: \.self) { depth in
                        stackPeek(depth: depth + 1)
                    }

                    if let top = notifications.first {
                        IOSNotificationRow(
                            notification: top,
                            scale: scale,
                            showAppHeader: notifications.count > 1
                        )
                        .onTapGesture {
                            if notifications.count > 1 {
                                onToggleExpand()
                            } else {
                                phone.markNotificationRead(top.id)
                            }
                        }
                    }
                }
            }

            if isExpanded && notifications.count > 1 {
                Button(Fr.showLess) {
                    onToggleExpand()
                }
                .font(.system(size: 13 * scale, weight: .semibold))
                .foregroundStyle(.white.opacity(0.55))
                .frame(maxWidth: .infinity)
                .padding(.top, 8 * scale)
            }
        }
    }

    private func stackPeek(depth: Int) -> some View {
        RoundedRectangle(cornerRadius: IOSMetrics.ncCardRadius * scale, style: .continuous)
            .fill(Color.white.opacity(0.06))
            .frame(height: IOSMetrics.ncCardMinHeight * scale)
            .padding(.horizontal, CGFloat(depth) * 4 * scale)
            .offset(y: CGFloat(depth) * IOSMetrics.ncStackPeekOffset * scale)
            .scaleEffect(1 - CGFloat(depth) * (1 - IOSMetrics.ncStackPeekScale), anchor: .top)
    }
}

// MARK: - Carte notification

struct IOSNotificationRow: View {
    let notification: RuntimeNotification
    var scale: CGFloat = 1
    var showAppHeader: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if showAppHeader {
                HStack(spacing: 8 * scale) {
                    appIcon
                    Text(LpspAppCatalog.displayName(notification.app))
                        .font(.system(size: IOSMetrics.ncAppNameFont * scale, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.55))
                    Spacer(minLength: 0)
                    Text(notification.heure)
                        .font(.system(size: IOSMetrics.ncTimeFont * scale))
                        .foregroundStyle(.white.opacity(0.45))
                }
                .padding(.horizontal, IOSMetrics.ncCardPadding * scale)
                .padding(.top, IOSMetrics.ncCardPadding * scale)
                .padding(.bottom, 6 * scale)
            }

            HStack(alignment: .top, spacing: 10 * scale) {
                if !showAppHeader {
                    appIcon
                }

                VStack(alignment: .leading, spacing: 3 * scale) {
                    HStack(alignment: .firstTextBaseline, spacing: 6 * scale) {
                        Text(notification.titre)
                            .font(.system(size: IOSMetrics.ncTitleFont * scale, weight: .semibold))
                            .foregroundStyle(.white)
                            .lineLimit(2)
                        Spacer(minLength: 0)
                        if !showAppHeader {
                            Text(notification.heure)
                                .font(.system(size: IOSMetrics.ncTimeFont * scale))
                                .foregroundStyle(.white.opacity(0.45))
                        }
                    }
                    Text(notification.texte)
                        .font(.system(size: IOSMetrics.ncBodyFont * scale))
                        .foregroundStyle(.white.opacity(0.75))
                        .lineLimit(3)
                }
            }
            .padding(.horizontal, IOSMetrics.ncCardPadding * scale)
            .padding(.vertical, IOSMetrics.ncCardPadding * scale)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: IOSMetrics.ncCardRadius * scale, style: .continuous)
                .fill(IOSColors.ncCardFill)
                .overlay {
                    RoundedRectangle(cornerRadius: IOSMetrics.ncCardRadius * scale, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.06), lineWidth: 0.5)
                }
        )
    }

    private var appIcon: some View {
        Group {
            if let asset = LpspAppCatalog.iconAsset(for: notification.app) {
                Image(asset)
                    .resizable()
                    .scaledToFit()
                    .frame(width: IOSMetrics.ncAppIconSize * scale, height: IOSMetrics.ncAppIconSize * scale)
                    .clipShape(RoundedRectangle(cornerRadius: IOSMetrics.ncAppIconRadius * scale, style: .continuous))
            } else {
                RoundedRectangle(cornerRadius: IOSMetrics.ncAppIconRadius * scale, style: .continuous)
                    .fill(LpspAppCatalog.accentColor(for: notification.app))
                    .frame(width: IOSMetrics.ncAppIconSize * scale, height: IOSMetrics.ncAppIconSize * scale)
                    .overlay {
                        Text(String(notification.app.prefix(1)))
                            .font(.system(size: 14 * scale, weight: .bold))
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}
