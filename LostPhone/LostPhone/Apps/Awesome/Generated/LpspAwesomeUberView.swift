import SwiftUI

// Source: Meliwat/awesome-ios-design-md — uber/DESIGN-swiftui.md
struct LpspAwesomeUberView: View {
    var body: some View {
        TabView {
            AwesomeUberTabScreen(title: "Home", icon: "house.fill", appName: "Uber")
                .tabItem { Label("Home", systemImage: "house.fill") }
            AwesomeUberTabScreen(title: "Services", icon: "square.grid.2x2.fill", appName: "Uber")
                .tabItem { Label("Services", systemImage: "square.grid.2x2.fill") }
            AwesomeUberTabScreen(title: "Activity", icon: "clock.fill", appName: "Uber")
                .tabItem { Label("Activity", systemImage: "clock.fill") }
            AwesomeUberTabScreen(title: "Account", icon: "person.fill", appName: "Uber")
                .tabItem { Label("Account", systemImage: "person.fill") }
        }
        .tint(UberTokens.uberBlack)
    }
}

private enum UberTokens {
        static let uberBlack = Color.black                                 // #000000
        static let uberWhite = Color.white                                 // #FFFFFF
        static let uberCanvasDark = Color(red: 0.047, green: 0.047, blue: 0.047) // #0C0C0C
        static let uberGray50 = Color(red: 0.965, green: 0.965, blue: 0.965) // #F6F6F6
        static let uberGray100 = Color(red: 0.933, green: 0.933, blue: 0.933) // #EEEEEE
        static let uberGray200 = Color(red: 0.898, green: 0.898, blue: 0.898) // #E5E5E5
        static let uberGray400 = Color(red: 0.686, green: 0.686, blue: 0.686) // #AFAFAF
        static let uberGray600 = Color(red: 0.459, green: 0.459, blue: 0.459) // #757575
        static let uberGray700 = Color(red: 0.329, green: 0.329, blue: 0.329) // #545454
        static let uberGray900 = Color(red: 0.184, green: 0.184, blue: 0.184) // #2F2F2F
        static let uberGray950 = Color(red: 0.102, green: 0.102, blue: 0.102) // #1A1A1A
        static let uberGreen = Color(red: 0.020, green: 0.639, blue: 0.341) // #05A357
        static let uberRed = Color(red: 0.843, green: 0.129, blue: 0.075) // #D72113
        static let uberBlue = Color(red: 0.039, green: 0.278, blue: 1.000) // #0A47FF
        static let uberAmber = Color(red: 1.000, green: 0.796, blue: 0.000) // #FFCB00
        static let uberSurface = Color("UberSurface")      // #FFFFFF / #1A1A1A
        static let uberSurfaceAlt = Color("UberSurfaceAlt")   // #F6F6F6 / #2F2F2F
        static let uberTextPrimary = Color("UberTextPrimary")  // #000000 / #FFFFFF
        static let uberTextSecondary = Color("UberTextSecondary") // #757575 / #AFAFAF
        static let uberDivider = Color("UberDivider")      // #E5E5E5 / #3A3A3A
}

private struct AwesomeUberTabScreen: View {
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
            .background(UberTokens.uberCanvasDark.ignoresSafeArea())
            .navigationTitle(title)
            .toolbarBackground(UberTokens.uberCanvasDark, for: .navigationBar)
        }
    }

    private var header: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(UberTokens.uberBlack)
            Text(appName)
                .font(.title2.bold())
            Spacer()
        }
    }

    @ViewBuilder
    private var sampleContent: some View {
        ForEach(0..<6, id: \.self) { i in
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(UberTokens.uberBlack.opacity(0.12))
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
