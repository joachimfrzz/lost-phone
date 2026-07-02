import SwiftUI

// MARK: - Brand tokens (références visuelles iOS 17)

enum LpspThirdPartyBrand {
    static let uberBlack = Color.black
    static let uberGray = Color(red: 0.96, green: 0.96, blue: 0.97)
    static let uberBlue = Color(red: 0.09, green: 0.44, blue: 0.95)

    static let banqueGreen = Color(red: 0.0, green: 0.45, blue: 0.25)
    static let banqueGreenLight = Color(red: 0.0, green: 0.55, blue: 0.32)

    static let plansMapTop = Color(red: 0.82, green: 0.88, blue: 0.78)
    static let plansMapBottom = Color(red: 0.71, green: 0.80, blue: 0.68)
    static let plansPin = Color(red: 0.98, green: 0.23, blue: 0.21)

    static let remindersYellow = Color(red: 0.98, green: 0.73, blue: 0.08)

    static let spotifyBlack = Color(red: 0.07, green: 0.07, blue: 0.07)
    static let spotifyCard = Color(red: 0.11, green: 0.11, blue: 0.11)
    static let spotifyGreen = Color(red: 0.11, green: 0.73, blue: 0.33)

    static let netflixBlack = Color(red: 0.08, green: 0.08, blue: 0.08)
    static let netflixRed = Color(red: 0.90, green: 0.04, blue: 0.08)

    static let instagramGradient = LinearGradient(
        colors: [
            Color(red: 0.98, green: 0.36, blue: 0.36),
            Color(red: 0.83, green: 0.25, blue: 0.55),
            Color(red: 0.55, green: 0.22, blue: 0.85)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// MARK: - Formatters

enum LpspThirdPartyFormat {
    static func frenchDate(_ date: Date?, style: DateFormatter.Style = .medium, time: DateFormatter.Style = .none) -> String {
        guard let date else { return "" }
        let f = DateFormatter()
        f.locale = Locale(identifier: "fr_FR")
        f.dateStyle = style
        f.timeStyle = time
        return f.string(from: date)
    }

    static func frenchDateRaw(_ raw: String) -> String {
        guard !raw.isEmpty else { return "" }
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let d = iso.date(from: raw) ?? ISO8601DateFormatter().date(from: raw) {
            return frenchDate(d, style: .medium, time: .short)
        }
        return raw
    }

    static func money(_ value: Double, currency: String = "EUR") -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = currency
        f.locale = Locale(identifier: "fr_FR")
        return f.string(from: NSNumber(value: value)) ?? String(format: "%.2f €", value)
    }

    static func sectionTitle(for date: Date?) -> String {
        guard let date else { return "Plus tôt" }
        if Calendar.current.isDateInToday(date) { return "Aujourd'hui" }
        if Calendar.current.isDateInYesterday(date) { return "Hier" }
        return frenchDate(date, style: .long)
    }
}

// MARK: - Fake map (Uber / Plans)

struct LpspFakeMapView: View {
    var accent: Color = LpspThirdPartyBrand.plansMapBottom
    var height: CGFloat = 200
    var showRoute: Bool = true

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [LpspThirdPartyBrand.plansMapTop, accent],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Canvas { context, size in
                let block = CGSize(width: 28, height: 18)
                for row in 0..<Int(size.height / 22) {
                    for col in 0..<Int(size.width / 34) {
                        let rect = CGRect(
                            x: CGFloat(col) * 34 + CGFloat(row % 2) * 8,
                            y: CGFloat(row) * 22,
                            width: block.width,
                            height: block.height
                        )
                        context.fill(
                            Path(roundedRect: rect, cornerRadius: 3),
                            with: .color(.white.opacity(0.22))
                        )
                    }
                }
                if showRoute {
                    var path = Path()
                    path.move(to: CGPoint(x: size.width * 0.22, y: size.height * 0.72))
                    path.addCurve(
                        to: CGPoint(x: size.width * 0.78, y: size.height * 0.28),
                        control1: CGPoint(x: size.width * 0.35, y: size.height * 0.55),
                        control2: CGPoint(x: size.width * 0.62, y: size.height * 0.42)
                    )
                    context.stroke(path, with: .color(.blue), lineWidth: 5)
                    context.stroke(path, with: .color(.white), lineWidth: 2)
                }
            }

            if showRoute {
                Circle()
                    .fill(.green)
                    .frame(width: 12, height: 12)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(24)

                Circle()
                    .fill(LpspThirdPartyBrand.plansPin)
                    .frame(width: 12, height: 12)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(32)
            }
        }
        .frame(height: height)
        .clipped()
    }
}

// MARK: - Route timeline (Uber / Plans)

struct LpspRouteTimeline: View {
    let origin: String
    let destination: String
    var pickupColor: Color = .green
    var dropoffColor: Color = .black

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                Circle()
                    .fill(pickupColor)
                    .frame(width: 10, height: 10)
                Rectangle()
                    .fill(Color(uiColor: .systemGray4))
                    .frame(width: 2, height: 36)
                RoundedRectangle(cornerRadius: 2)
                    .fill(dropoffColor)
                    .frame(width: 10, height: 10)
            }
            .padding(.top, 5)

            VStack(alignment: .leading, spacing: 22) {
                Text(origin)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                Text(destination)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
            }
        }
    }
}

// MARK: - Bottom tab bar (Uber / Instagram)

struct LpspThirdPartyTabBar: View {
    struct Tab: Identifiable {
        let id: String
        let icon: String
        let label: String
    }

    let tabs: [Tab]
    let selected: String
    var accent: Color = .primary

    var body: some View {
        HStack {
            ForEach(tabs) { tab in
                Spacer()
                VStack(spacing: 3) {
                    Image(systemName: tab.icon)
                        .font(.system(size: 22))
                        .symbolVariant(selected == tab.id ? .fill : .none)
                    Text(tab.label)
                        .font(.system(size: 10))
                }
                .foregroundStyle(selected == tab.id ? accent : Color(uiColor: .systemGray))
                Spacer()
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(.bar)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color(uiColor: .separator))
                .frame(height: 0.33)
        }
    }
}

// MARK: - Read-only search bar

struct LpspSearchBar: View {
    let placeholder: String
    var background: Color = Color(uiColor: .secondarySystemBackground)

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            Text(placeholder)
                .foregroundStyle(.secondary)
            Spacer()
            Image(systemName: "mic.fill")
                .foregroundStyle(.secondary)
        }
        .font(.body)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

// MARK: - Detail row

struct LpspDetailRow: View {
    let title: String
    let value: String
    var valueColor: Color = .primary

    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer(minLength: 12)
            Text(value)
                .multilineTextAlignment(.trailing)
                .foregroundStyle(valueColor)
        }
        .font(.subheadline)
    }
}

// MARK: - Grouping helpers

enum LpspThirdPartyGrouping {
    static func byDay<T>(_ items: [T], date: (T) -> Date?) -> [(String, [T])] {
        var groups: [(Date?, [T])] = []
        for item in items {
            let d = date(item)
            let day = d.map { Calendar.current.startOfDay(for: $0) }
            if let idx = groups.firstIndex(where: {
                guard let g = $0.0, let day else { return $0.0 == nil && day == nil }
                return Calendar.current.isDate(g, inSameDayAs: day)
            }) {
                groups[idx].1.append(item)
            } else {
                groups.append((day, [item]))
            }
        }
        groups.sort { ($0.0 ?? .distantPast) > ($1.0 ?? .distantPast) }
        return groups.map { (LpspThirdPartyFormat.sectionTitle(for: $0.0), $0.1) }
    }
}

// MARK: - Shell clone (même discipline que MessagesApp / NotesApp)

/// Enveloppe read-only calquée sur les clones Showroom : contenu + tab bar optionnelle.
struct TierCloneShell<TabBar: View, Content: View>: View {
    @ViewBuilder var tabBar: () -> TabBar
    @ViewBuilder var content: () -> Content
    var usesTabBar: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if usesTabBar {
                tabBar()
            }
        }
    }
}

/// Tab bar iOS — hauteur et safe area comme apps natives.
struct TierIOSTabBar: View {
    struct Item: Identifiable {
        let id: String
        let icon: String
        let label: String
    }

    let items: [Item]
    let selected: String
    var accent: Color = .primary
    var dark: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                VStack(spacing: 4) {
                    Image(systemName: item.icon)
                        .font(.system(size: 23))
                        .symbolVariant(selected == item.id ? .fill : .none)
                    Text(item.label)
                        .font(.system(size: 10, weight: .medium))
                }
                .foregroundStyle(selected == item.id ? accent : (dark ? .white.opacity(0.45) : Color(uiColor: .systemGray)))
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 2)
        .background(dark ? LpspThirdPartyBrand.spotifyBlack : Color(uiColor: .systemBackground))
        .overlay(alignment: .top) {
            Rectangle().fill(Color(uiColor: .separator).opacity(dark ? 0.25 : 1)).frame(height: 0.33)
        }
    }
}
