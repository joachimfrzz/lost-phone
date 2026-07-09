import SwiftUI

/// Point d'entrée Lost Phone — clone vendored (préfixe `VendoredDisney`).
struct LpspVendoredDisneyPlusRootView: View {
    @StateObject private var homeVM = VendoredDisneyHomeViewModel()

    var body: some View {
        VendoredDisneyContentView()
            .environmentObject(homeVM)
    }
}
