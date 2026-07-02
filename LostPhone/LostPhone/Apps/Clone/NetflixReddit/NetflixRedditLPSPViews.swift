import SwiftUI

// Données LPSP — profils + Reprendre (complète le clone Reddit)

struct NetflixRedditProfilePicker: View {
    let profiles: [LpspNetflixProfile]
    @Binding var selected: LpspNetflixProfile?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(profiles) { profile in
                    VStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(profile.isKids ? Color.blue.opacity(0.35) : NetflixRedditTheme.customDarkGray)
                            .frame(width: 72, height: 72)
                            .overlay {
                                Text(String(profile.avatar.prefix(1)))
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(.white)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 4)
                                    .strokeBorder(selected?.id == profile.id ? .white : .clear, lineWidth: 2)
                            }
                        Text(profile.name)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.85))
                            .lineLimit(1)
                    }
                    .onTapGesture { selected = profile }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

struct NetflixRedditContinueRow: View {
    let items: [LpspNetflixItem]
    let profileName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reprendre pour \(profileName)")
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(items) { item in
                        VStack(alignment: .leading, spacing: 6) {
                            NetflixRedditPosterCard(
                                progress: NetflixRedditLPSP.progress(item.progress),
                                width: 148,
                                height: 84
                            )
                            Text(item.title)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white)
                                .lineLimit(2)
                                .frame(width: 148, alignment: .leading)
                            Text(item.progress)
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                }
            }
        }
    }
}

struct NetflixRedditAccountFooter: View {
    let data: LpspNetflixData

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Compte")
                .font(.headline)
                .foregroundStyle(.white)
            Text(data.holder)
            Text(data.plan)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.55))
        }
        .font(.subheadline)
        .foregroundStyle(.white.opacity(0.85))
        .padding(.top, 8)
    }
}

enum NetflixRedditLPSP {
    static func filtered(_ items: [LpspNetflixItem], profile: LpspNetflixProfile?) -> [LpspNetflixItem] {
        guard let profile else { return items }
        let key = profile.name.split(separator: " ").first.map { String($0).lowercased() } ?? profile.name.lowercased()
        return items.filter {
            $0.profileName.lowercased().hasPrefix(key) || key.hasPrefix($0.profileName.lowercased())
        }
    }

    static func progress(_ text: String) -> CGFloat {
        let parts = text.split(separator: "/").map { $0.trimmingCharacters(in: .whitespaces) }
        guard parts.count == 2 else { return 0.35 }
        let current = parseMinutes(parts[0])
        let total = parseMinutes(parts[1])
        guard total > 0 else { return 0.35 }
        return min(1, max(0, current / total))
    }

    private static func parseMinutes(_ text: String) -> CGFloat {
        if text.contains("h") {
            let bits = text.replacingOccurrences(of: "min", with: "").split(separator: "h")
            if bits.count == 2, let h = Double(bits[0]), let m = Double(bits[1]) {
                return CGFloat(h * 60 + m)
            }
        }
        if let m = Double(text.replacingOccurrences(of: "min", with: "").trimmingCharacters(in: .whitespaces)) {
            return CGFloat(m)
        }
        return 0
    }
}
