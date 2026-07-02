import SwiftUI

// Clone Netflix iOS — profils + Reprendre + rangées horizontales.

struct LpspNetflixView: View {
    let data: LpspNetflixData?
    @State private var selectedProfile: LpspNetflixProfile?

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 28) {
                            profilePicker(data.profiles)
                            if !data.continueWatching.isEmpty {
                                continueRow(data.continueWatching)
                            }
                            browseRow("Populaire sur Netflix", count: 6)
                            browseRow("Séries d'action", count: 5)
                            accountFooter(data)
                        }
                        .padding(.vertical, 12)
                    }
                    .background(LpspThirdPartyBrand.netflixBlack)
                    .onAppear {
                        if selectedProfile == nil { selectedProfile = data.profiles.first }
                    }
                } else {
                    ContentUnavailableView("Netflix", systemImage: "play.tv.fill")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("N")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundStyle(LpspThirdPartyBrand.netflixRed)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 18) {
                        Button {} label: { Image(systemName: "arrow.down.to.line") }
                        Button {} label: { Image(systemName: "magnifyingglass") }
                    }
                    .foregroundStyle(.white)
                    .disabled(true)
                }
            }
            .toolbarBackground(LpspThirdPartyBrand.netflixBlack, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private func profilePicker(_ profiles: [LpspNetflixProfile]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(profiles) { profile in
                    VStack(spacing: 8) {
                        Circle()
                            .fill(profile.isKids ? Color.blue.opacity(0.35) : Color.gray.opacity(0.35))
                            .frame(width: 68, height: 68)
                            .overlay {
                                Text(String(profile.avatar.prefix(1)))
                                    .font(.title2.weight(.bold))
                                    .foregroundStyle(.white)
                            }
                            .overlay {
                                Circle()
                                    .strokeBorder(selectedProfile?.id == profile.id ? .white : .clear, lineWidth: 2)
                            }
                        Text(profile.name)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .onTapGesture { selectedProfile = profile }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private func continueRow(_ items: [LpspNetflixItem]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Reprendre pour \(selectedProfile?.name ?? "Mathieu")")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filtered(items)) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [LpspThirdPartyBrand.netflixRed.opacity(0.85), .black], startPoint: .top, endPoint: .bottom))
                                    .frame(width: 148, height: 84)
                                    .overlay {
                                        Image(systemName: "play.fill")
                                            .font(.title2)
                                            .foregroundStyle(.white)
                                    }
                                GeometryReader { geo in
                                    Rectangle()
                                        .fill(LpspThirdPartyBrand.netflixRed)
                                        .frame(width: geo.size.width * progress(item.progress))
                                }
                                .frame(height: 3)
                            }
                            .frame(width: 148, height: 84)

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
                .padding(.horizontal, 16)
            }
        }
    }

    private func browseRow(_ title: String, count: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<count, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(white: 0.15 + Double(i) * 0.04))
                            .frame(width: 110, height: 62)
                            .overlay {
                                Image(systemName: "film")
                                    .foregroundStyle(.white.opacity(0.35))
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func accountFooter(_ data: LpspNetflixData) -> some View {
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
        .padding(.horizontal, 16)
    }

    private func filtered(_ items: [LpspNetflixItem]) -> [LpspNetflixItem] {
        guard let profile = selectedProfile else { return items }
        let key = profile.name.split(separator: " ").first.map { String($0).lowercased() } ?? profile.name.lowercased()
        return items.filter {
            $0.profileName.lowercased().hasPrefix(key) || key.hasPrefix($0.profileName.lowercased())
        }
    }

    private func progress(_ text: String) -> CGFloat {
        let parts = text.split(separator: "/").map { $0.trimmingCharacters(in: .whitespaces) }
        guard parts.count == 2 else { return 0.35 }
        let current = parseMinutes(parts[0])
        let total = parseMinutes(parts[1])
        guard total > 0 else { return 0.35 }
        return min(1, max(0, current / total))
    }

    private func parseMinutes(_ text: String) -> CGFloat {
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
