import SwiftUI

struct MessengerAvatar: View {
    let title: String
    var initials: String?
    var isGroup: Bool = false
    var size: CGFloat = 52
    var showOnline: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#A8B3CF"), Color(hex: "#8B9DC3")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                if isGroup {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: size * 0.28))
                        .foregroundStyle(.white)
                } else {
                    Text((initials ?? String(title.prefix(1))).uppercased())
                        .font(.system(size: size * 0.34, weight: .semibold))
                        .foregroundStyle(.white)
                }
            }
            .frame(width: size, height: size)

            if showOnline {
                Circle()
                    .fill(MessengerTheme.online)
                    .frame(width: size * 0.22, height: size * 0.22)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .offset(x: 2, y: 2)
            }
        }
    }
}

struct MessengerSettingsRow: View {
    let title: String
    var icon: String?
    var subtitle: String?

    var body: some View {
        HStack(spacing: 12) {
            if let icon {
                Image(systemName: icon)
                    .frame(width: 28)
                    .foregroundStyle(MessengerTheme.accent)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .foregroundStyle(MessengerTheme.primaryText)
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(MessengerTheme.secondaryText)
                }
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(MessengerTheme.secondaryText)
        }
        .padding(.vertical, 4)
    }
}
