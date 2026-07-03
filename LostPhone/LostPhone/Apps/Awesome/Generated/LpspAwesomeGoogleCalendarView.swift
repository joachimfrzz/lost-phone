import SwiftUI

// Source: Meliwat/awesome-ios-design-md — google-calendar/DESIGN-swiftui.md
struct LpspAwesomeGoogleCalendarView: View {
    var body: some View {
        TabView {
            AwesomeGoogleCalendarTabScreen(title: "Schedule", icon: "list.bullet", appName: "Google Calendar")
                .tabItem { Label("Schedule", systemImage: "list.bullet") }
            AwesomeGoogleCalendarTabScreen(title: "Day", icon: "square.grid.2x2.fill", appName: "Google Calendar")
                .tabItem { Label("Day", systemImage: "square.grid.2x2.fill") }
            AwesomeGoogleCalendarTabScreen(title: "Week", icon: "square.grid.2x2.fill", appName: "Google Calendar")
                .tabItem { Label("Week", systemImage: "square.grid.2x2.fill") }
            AwesomeGoogleCalendarTabScreen(title: "Month", icon: "square.grid.2x2.fill", appName: "Google Calendar")
                .tabItem { Label("Month", systemImage: "square.grid.2x2.fill") }
        }
        .tint(GoogleCalendarTokens.gcalCanvas)
    }
}

private enum GoogleCalendarTokens {
        static let gcalCanvas = Color(red: 1.00, green: 1.00, blue: 1.00)    // #FFFFFF
        static let gcalSurfaceGray = Color(red: 0.945, green: 0.953, blue: 0.957) // #F1F3F4
        static let gcalSurfaceGray2 = Color(red: 0.973, green: 0.976, blue: 0.980) // #F8F9FA
        static let gcalDivider = Color(red: 0.855, green: 0.863, blue: 0.878) // #DADCE0
        static let gcalInk = Color(red: 0.125, green: 0.129, blue: 0.141) // #202124
        static let gcalSecondary = Color(red: 0.373, green: 0.388, blue: 0.408) // #5F6368
        static let gcalTertiary = Color(red: 0.502, green: 0.525, blue: 0.545) // #80868B
        static let gcalBlue = Color(red: 0.102, green: 0.451, blue: 0.910) // #1A73E8 primary
        static let gcalBluePressed = Color(red: 0.082, green: 0.341, blue: 0.690) // #1557B0
        static let gcalBlueTint = Color(red: 0.910, green: 0.941, blue: 0.996) // #E8F0FE selected
        static let gcalBlueDark = Color(red: 0.541, green: 0.706, blue: 0.973) // #8AB4F8 dark mode
        static let gcalEventBlue = Color(red: 0.102, green: 0.451, blue: 0.910) // #1A73E8
        static let gcalEventRed = Color(red: 0.851, green: 0.188, blue: 0.145) // #D93025
        static let gcalEventYellow = Color(red: 0.976, green: 0.671, blue: 0.00)  // #F9AB00
        static let gcalEventGreen = Color(red: 0.094, green: 0.502, blue: 0.220) // #188038
        static let gcalTomato = Color(red: 0.835, green: 0.00,  blue: 0.00)  // #D50000
        static let gcalFlamingo = Color(red: 0.902, green: 0.486, blue: 0.451) // #E67C73
        static let gcalTangerine = Color(red: 0.957, green: 0.318, blue: 0.118) // #F4511E
        static let gcalBanana = Color(red: 0.965, green: 0.749, blue: 0.149) // #F6BF26
        static let gcalSage = Color(red: 0.200, green: 0.714, blue: 0.475) // #33B679
        static let gcalBasil = Color(red: 0.043, green: 0.502, blue: 0.263) // #0B8043
        static let gcalPeacock = Color(red: 0.012, green: 0.608, blue: 0.898) // #039BE5
        static let gcalBlueberry = Color(red: 0.247, green: 0.318, blue: 0.710) // #3F51B5
        static let gcalLavender = Color(red: 0.475, green: 0.525, blue: 0.796) // #7986CB
}

private struct AwesomeGoogleCalendarTabScreen: View {
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
            .background(GoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(GoogleCalendarTokens.gcalCanvas, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(GoogleCalendarTokens.gcalCanvas)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(GoogleCalendarTokens.gcalCanvas.opacity(0.12))
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
