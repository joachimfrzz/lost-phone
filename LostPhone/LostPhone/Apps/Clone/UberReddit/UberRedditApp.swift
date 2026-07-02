import SwiftUI

// Point d'entrée Lost Phone — clone Reddit 264Gaurav/UBER-ios + onglet Activité LPSP.
// Source vendored : https://github.com/264Gaurav/UBER-ios (MIT)

struct UberRedditAppView: View {
    let rides: [LpspRide]
    @StateObject private var locationViewModel = LocationSearchViewModel()
    @State private var selectedTab = "home"

    private let tabs: [TierIOSTabBar.Item] = [
        .init(id: "home", icon: "house", label: "Accueil"),
        .init(id: "services", icon: "square.grid.2x2", label: "Services"),
        .init(id: "activity", icon: "clock", label: "Activité"),
        .init(id: "account", icon: "person", label: "Compte"),
    ]

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case "home":
                    HomeView()
                        .environmentObject(locationViewModel)
                case "activity":
                    UberActivityTabView(rides: rides)
                default:
                    UberRedditPlaceholderTab(title: placeholderTitle)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            UberRedditTabBar(items: tabs, selected: $selectedTab)
        }
        .onAppear {
            locationViewModel.userLocation = UberCloneLocationManager.shared.userLocation
        }
    }

    private var placeholderTitle: String {
        switch selectedTab {
        case "services": return "Services"
        default: return "Compte"
        }
    }
}

/// Tab bar Uber interactive (le TierIOSTabBar partagé est read-only).
private struct UberRedditTabBar: View {
    let items: [TierIOSTabBar.Item]
    @Binding var selected: String

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                Button {
                    selected = item.id
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: item.icon)
                            .font(.system(size: 23))
                            .symbolVariant(selected == item.id ? .fill : .none)
                        Text(item.label)
                            .font(.system(size: 10, weight: .medium))
                    }
                    .foregroundStyle(selected == item.id ? Color.black : Color(uiColor: .systemGray))
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 2)
        .background(Color(uiColor: .systemBackground))
        .overlay(alignment: .top) {
            Rectangle().fill(Color(uiColor: .separator)).frame(height: 0.33)
        }
    }
}

private struct UberRedditPlaceholderTab: View {
    let title: String

    var body: some View {
        NavigationStack {
            ContentUnavailableView(title, systemImage: "app.fill")
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

/// Route LPSP — même nom qu'avant pour le router.
struct LpspUberView: View {
    let rides: [LpspRide]

    var body: some View {
        UberRedditAppView(rides: rides)
    }
}
