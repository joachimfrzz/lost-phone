import SwiftUI

/// Port SwiftUI du clone Flutter Sopheamen `tinder_clone_ui_kit` (`root_app.dart`).
struct VendoredTinderRootView: View {
    @State private var tab = 0

    var body: some View {
        VStack(spacing: 0) {
            topTabBar
            Group {
                switch tab {
                case 0: VendoredTinderExploreView()
                case 1: VendoredTinderLikesView()
                case 2: VendoredTinderChatView()
                default: VendoredTinderAccountView()
                }
            }
        }
        .background(Color.white)
    }

    private var topTabBar: some View {
        HStack {
            tabButton(index: 0, active: "flame.fill", inactive: "flame")
            tabButton(index: 1, active: "heart.fill", inactive: "heart")
            tabButton(index: 2, active: "bubble.left.and.bubble.right.fill", inactive: "bubble.left.and.bubble.right")
            tabButton(index: 3, active: "person.fill", inactive: "person")
        }
        .padding(.horizontal, 10)
        .padding(.top, 8)
        .foregroundStyle(VendoredTinderTheme.primary)
    }

    private func tabButton(index: Int, active: String, inactive: String) -> some View {
        Button {
            tab = index
        } label: {
            Image(systemName: tab == index ? active : inactive)
                .font(.system(size: 22))
                .foregroundStyle(tab == index ? VendoredTinderTheme.primary : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}

struct LpspVendoredTinderRootView: View {
    var body: some View {
        VendoredTinderRootView()
    }
}
