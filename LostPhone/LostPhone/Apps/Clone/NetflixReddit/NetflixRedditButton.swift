import SwiftUI

// Vendored from debuging-life/netflix-clone — ButtonNetflix

struct NetflixRedditButtonConfig {
    var backgroundColor: Color
    var cornerRadius: CGFloat
    var height: CGFloat
    var textConfiguration: TextConfiguration

    init(
        backgroundColor: Color = NetflixRedditTheme.red,
        cornerRadius: CGFloat = 4,
        height: CGFloat = 50,
        textConfiguration: TextConfiguration = .default
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.height = height
        self.textConfiguration = textConfiguration
    }

    struct TextConfiguration {
        let font: Font
        let fontWeight: Font.Weight
        let foregroundColor: Color

        init(
            font: Font = .body,
            fontWeight: Font.Weight = .bold,
            foregroundColor: Color = .white
        ) {
            self.font = font
            self.fontWeight = fontWeight
            self.foregroundColor = foregroundColor
        }

        static let `default` = TextConfiguration()
    }

    static let `default` = NetflixRedditButtonConfig()
}

struct NetflixRedditButton<Icon: View>: View {
    let configuration: NetflixRedditButtonConfig
    let text: String
    let icon: Icon?
    let action: () -> Void
    let disabled: Bool

    init(
        text: String,
        disabled: Bool = false,
        configuration: NetflixRedditButtonConfig = .default,
        @ViewBuilder icon: () -> Icon,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.disabled = disabled
        self.configuration = configuration
        self.icon = icon()
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if let icon {
                    icon
                }
                Text(text)
                    .font(configuration.textConfiguration.font)
                    .fontWeight(configuration.textConfiguration.fontWeight)
                    .foregroundStyle(configuration.textConfiguration.foregroundColor)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(disabled ? configuration.backgroundColor.opacity(0.7) : configuration.backgroundColor)
            .frame(height: configuration.height)
            .clipShape(RoundedRectangle(cornerRadius: configuration.cornerRadius))
        }
        .buttonStyle(.plain)
        .disabled(disabled)
    }
}

extension NetflixRedditButton where Icon == EmptyView {
    init(
        text: String,
        configuration: NetflixRedditButtonConfig = .default,
        disabled: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.text = text
        self.configuration = configuration
        self.disabled = disabled
        self.action = action
        self.icon = nil
    }
}
