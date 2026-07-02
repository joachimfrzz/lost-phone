import SwiftUI

// Entrée Lost Phone — UI identique au repo 264Gaurav/UBER-ios (vendored tel quel).
// Source : https://github.com/264Gaurav/UBER-ios

struct UberRedditAppView: View {
    @StateObject private var locationViewModel = LocationSearchViewModel()

    var body: some View {
        UberRedditHomeView()
            .environmentObject(locationViewModel)
    }
}

struct LpspUberView: View {
    let rides: [LpspRide]

    var body: some View {
        UberRedditAppView()
    }
}
