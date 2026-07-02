import SwiftUI

struct InstagramRedditBottomTabBar: View {
    @Binding var selected: Int

    var body: some View {
        HStack {
            InstagramRedditTabItem(icon: "house.fill", index: 0, selected: $selected)
            Spacer()
            InstagramRedditTabItem(icon: "magnifyingglass", index: 1, selected: $selected)
            Spacer()
            InstagramRedditTabItem(icon: "plus.app.fill", index: 2, selected: $selected)
            Spacer()
            InstagramRedditTabItem(icon: "play.rectangle", index: 3, selected: $selected)
            Spacer()
            InstagramRedditTabItem(icon: "person.circle", index: 4, selected: $selected)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(Color(uiColor: .systemBackground))
    }
}

struct InstagramRedditTabItem: View {
    let icon: String
    let index: Int
    @Binding var selected: Int

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(selected == index ? .primary : .secondary)
        }
        .frame(height: 40)
        .contentShape(Rectangle())
        .onTapGesture { selected = index }
    }
}
