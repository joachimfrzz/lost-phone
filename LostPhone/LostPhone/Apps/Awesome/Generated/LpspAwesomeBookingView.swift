import SwiftUI

// Source: Meliwat/awesome-ios-design-md — booking/DESIGN-swiftui.md
struct LpspAwesomeBookingView: View {
    var body: some View {
        TabView {
            AwesomeBookingTabScreen(title: "Bookings", icon: "suitcase", appName: "Booking")
                .tabItem { Label("Bookings", systemImage: "suitcase") }
            AwesomeBookingTabScreen(title: "Search", icon: "square.grid.2x2.fill", appName: "Booking")
                .tabItem { Label("Search", systemImage: "square.grid.2x2.fill") }
            AwesomeBookingTabScreen(title: "Saved", icon: "square.grid.2x2.fill", appName: "Booking")
                .tabItem { Label("Saved", systemImage: "square.grid.2x2.fill") }
            AwesomeBookingTabScreen(title: "Profile", icon: "square.grid.2x2.fill", appName: "Booking")
                .tabItem { Label("Profile", systemImage: "square.grid.2x2.fill") }
            AwesomeBookingTabScreen(title: "Help", icon: "square.grid.2x2.fill", appName: "Booking")
                .tabItem { Label("Help", systemImage: "square.grid.2x2.fill") }
        }
        .tint(BookingTokens.bkCanvas)
    }
}

private enum BookingTokens {
        static let bkCanvas = Color.white                                  // #FFFFFF
        static let bkSurface = Color(red: 0.949, green: 0.949, blue: 0.949) // #F2F2F2
        static let bkSurfaceDeep = Color(red: 0.902, green: 0.902, blue: 0.902) // #E6E6E6
        static let bkDivider = Color(red: 0.878, green: 0.878, blue: 0.878) // #E0E0E0
        static let bkTextPrimary = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let bkTextSecondary = Color(red: 0.420, green: 0.420, blue: 0.420) // #6B6B6B
        static let bkTextTertiary = Color(red: 0.580, green: 0.580, blue: 0.580) // #949494
        static let bkBlue = Color(red: 0.0,   green: 0.208, blue: 0.502) // #003580
        static let bkCTA = Color(red: 0.0,   green: 0.443, blue: 0.761) // #0071C2
        static let bkCTAPressed = Color(red: 0.0,   green: 0.353, blue: 0.612) // #005A9C
        static let bkBlueTint = Color(red: 0.906, green: 0.941, blue: 0.969) // #E7F0F7
        static let bkYellow = Color(red: 0.996, green: 0.733, blue: 0.008) // #FEBB02
        static let bkSuccess = Color(red: 0.0,   green: 0.502, blue: 0.035) // #008009
        static let bkDeal = Color(red: 0.8,   green: 0.0,   blue: 0.0)   // #CC0000
        static let bkWarning = Color(red: 0.961, green: 0.651, blue: 0.137) // #F5A623
}

private struct AwesomeBookingTabScreen: View {
    let title: String
    let icon: String
    let appName: String

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    header
                    sampleContent
                }
                .padding()
            }
            .background(BookingTokens.bkCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(BookingTokens.bkCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(BookingTokens.bkCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(BookingTokens.bkCanvas.opacity(0.12))
                .frame(height: 72)
                .overlay(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(title) item \(i + 1)")
                            .font(.headline)
                        Text("Awesome iOS DESIGN spec")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
        }
    }
}
