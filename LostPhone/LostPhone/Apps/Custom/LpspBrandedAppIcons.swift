import SwiftUI

/// Icônes d'accueil style iOS pour apps tierces (pas d'assets PNG — rendu SwiftUI).
struct LpspBrandedAppIconContent: View {
    let appName: String

    var body: some View {
        switch LpspAppAliases.canonical(appName) {
        case "WhatsApp": whatsAppIcon
        case "Signal": signalIcon
        case "Uber": uberIcon
        case "Banque": banqueIcon
        case "Plans": plansIcon
        case "Fichiers": fichiersIcon
        case "Rappels": rappelsIcon
        case "Instagram": instagramIcon
        case "Spotify": spotifyIcon
        case "Netflix": netflixIcon
        default: fallbackIcon
        }
    }

    private var fallbackIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(LpspAppCatalog.accentColor(for: appName).gradient)
            .overlay {
                Text(String(LpspAppCatalog.displayName(appName).prefix(1)))
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(.white)
            }
    }

    private var whatsAppIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color(red: 0.15, green: 0.78, blue: 0.45))
            .overlay {
                ZStack {
                    Circle()
                        .stroke(.white, lineWidth: 3)
                        .frame(width: 34, height: 34)
                    Image(systemName: "phone.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .offset(x: -1, y: 1)
                }
            }
    }

    private var signalIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [Color(red: 0.31, green: 0.55, blue: 0.98), Color(red: 0.18, green: 0.38, blue: 0.85)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(-12))
            }
    }

    private var uberIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(.black)
            .overlay {
                Text("Uber")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .tracking(-0.5)
            }
    }

    private var banqueIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [LpspThirdPartyBrand.banqueGreen, LpspThirdPartyBrand.banqueGreenLight],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Image(systemName: "building.columns.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.white)
            }
    }

    private var plansIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [Color(red: 0.45, green: 0.78, blue: 0.95), Color(red: 0.22, green: 0.62, blue: 0.38)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                Image(systemName: "map.fill")
                    .font(.system(size: 26))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color.green.opacity(0.9))
            }
    }

    private var fichiersIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color(red: 0.39, green: 0.72, blue: 0.98))
            .overlay {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.white.opacity(0.95))
                        .frame(width: 30, height: 22)
                        .overlay(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color(red: 0.39, green: 0.72, blue: 0.98))
                                .frame(width: 12, height: 6)
                                .offset(x: -1, y: -1)
                        }
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.white.opacity(0.75))
                        .frame(width: 30, height: 22)
                        .offset(y: -6)
                }
            }
    }

    private var rappelsIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(.white)
            .overlay {
                VStack(spacing: 5) {
                    ForEach(0..<3, id: \.self) { i in
                        HStack(spacing: 6) {
                            Circle()
                                .stroke(LpspThirdPartyBrand.remindersYellow, lineWidth: 2.5)
                                .frame(width: 14, height: 14)
                                .overlay {
                                    if i == 0 {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 7, weight: .bold))
                                            .foregroundStyle(LpspThirdPartyBrand.remindersYellow)
                                    }
                                }
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color(uiColor: .systemGray4))
                                .frame(width: 26, height: 4)
                        }
                    }
                }
            }
    }

    private var instagramIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [
                        Color(red: 0.99, green: 0.72, blue: 0.35),
                        Color(red: 0.89, green: 0.28, blue: 0.42),
                        Color(red: 0.55, green: 0.22, blue: 0.85)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay {
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .strokeBorder(.white, lineWidth: 2.5)
                    .frame(width: 32, height: 32)
                    .overlay {
                        Circle()
                            .strokeBorder(.white, lineWidth: 2.5)
                            .frame(width: 14, height: 14)
                    }
            }
    }

    private var spotifyIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(LpspThirdPartyBrand.spotifyGreen)
            .overlay {
                HStack(spacing: 3) {
                    ForEach([14, 22, 18, 26], id: \.self) { h in
                        RoundedRectangle(cornerRadius: 2)
                            .fill(.black)
                            .frame(width: 4, height: CGFloat(h) * 0.55)
                    }
                }
            }
    }

    private var netflixIcon: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(.black)
            .overlay {
                Text("N")
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .foregroundStyle(LpspThirdPartyBrand.netflixRed)
            }
    }

    static func isBranded(_ appName: String) -> Bool {
        switch LpspAppAliases.canonical(appName) {
        case "WhatsApp", "Signal", "Uber", "Banque", "Plans", "Fichiers", "Rappels",
             "Instagram", "Spotify", "Netflix":
            return true
        default:
            return false
        }
    }
}
