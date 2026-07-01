import SwiftUI

/// Carte notification partagée (verrou + centre de notifications).
struct SystemNotificationCard: View {
    let notification: RuntimeNotification
    var compact = false

    var body: some View {
        HStack(alignment: .top, spacing: compact ? 10 : 12) {
            appIcon

            VStack(alignment: .leading, spacing: compact ? 3 : 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(notification.titre)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    Spacer(minLength: 8)
                    Text(notification.heure)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Text(notification.texte)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(compact ? 2 : 4)
            }
        }
        .padding(compact ? 12 : 14)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: compact ? 16 : 18, style: .continuous))
        .overlay {
            if !notification.lu {
                RoundedRectangle(cornerRadius: compact ? 16 : 18, style: .continuous)
                    .strokeBorder(.white.opacity(0.18), lineWidth: 0.5)
            }
        }
    }

    private var appIcon: some View {
        RoundedRectangle(cornerRadius: compact ? 7 : 9, style: .continuous)
            .fill(LpspAppCatalog.accentColor(for: notification.app))
            .frame(width: compact ? 34 : 40, height: compact ? 34 : 40)
            .overlay {
                if let asset = LpspAppCatalog.iconAsset(for: notification.app) {
                    Image(asset)
                        .resizable()
                        .scaledToFit()
                        .frame(width: compact ? 22 : 26, height: compact ? 22 : 26)
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                } else {
                    Text(String(notification.app.prefix(1)))
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white)
                }
            }
    }
}
