import SwiftUI

struct StatusBarView: View {
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        HStack {
            Text(phone.lockTime)
                .font(.system(size: 16, weight: .semibold))
            Spacer()
            HStack(spacing: 6) {
                Image(systemName: "cellularbars")
                Image(systemName: "wifi")
                Image(systemName: batterySymbol)
            }
            .font(.system(size: 14, weight: .semibold))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 28)
        .padding(.vertical, 6)
    }

    private var batterySymbol: String {
        switch phone.package?.content.system?.batterie?.lowercased() {
        case "faible", "low": return "battery.25"
        case "charge", "charging": return "battery.100.bolt"
        default: return "battery.100"
        }
    }
}

struct WallpaperView: View {
    @EnvironmentObject private var phone: PhoneViewModel

    var body: some View {
        Group {
            if let source = phone.package?.content.envelope.fondEcran?.source,
               let imageName = bundledWallpaperName(from: source),
               UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            } else if UIImage(named: "wallpaper") != nil {
                Image("wallpaper")
                    .resizable()
                    .scaledToFill()
            } else {
                LinearGradient(
                    colors: [
                        Color(red: 0.55, green: 0.35, blue: 0.25),
                        Color(red: 0.12, green: 0.08, blue: 0.05),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }

    private func bundledWallpaperName(from source: String) -> String? {
        if source.hasSuffix("wallpaper-lock.png") { return "wallpaper-lock" }
        if source.hasSuffix("wallpaper.png") { return "wallpaper" }
        return nil
    }
}

extension View {
    /// Dock / chrome glass — ultraThinMaterial on iOS 17+ (CI SDK).
    func iosDockGlass(in shape: some InsettableShape) -> some View {
        background(.ultraThinMaterial, in: shape)
    }
}
