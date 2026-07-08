import SwiftUI

/// Point d'entrée Lost Phone — clone vendored (préfixe `VendoredUber`).
struct LpspVendoredUberRootView: View {
    @StateObject private var routeManager = VendoredUberRouteManger()
    @StateObject private var locationSearchViewModel = VendoredUberLocationSearchViewModel()

    var body: some View {
        NavigationStack(path: $routeManager.path) {
            VendoredUberHomeView()
                .navigationDestination(for: VendoredUberRoute.self) { route in
                    VendoredUberGetView(route: route)
                }
        }
        .environmentObject(routeManager)
        .environmentObject(locationSearchViewModel)
    }
}
