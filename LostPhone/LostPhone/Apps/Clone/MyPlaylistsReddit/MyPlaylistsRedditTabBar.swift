import SwiftUI

struct MyPlaylistsRedditTabBar: View {
    @Binding var selected: String

    private let items: [(id: String, icon: String, label: String)] = [
        ("listen", "play.circle.fill", "Listen Now"),
        ("browse", "square.grid.2x2.fill", "Browse"),
        ("radio", "dot.radiowaves.left.and.right", "Radio"),
        ("library", "square.stack.fill", "Library"),
        ("search", "magnifyingglass", "Search"),
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.id) { item in
                Button {
                    selected = item.id
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: item.icon)
                            .font(.system(size: 22))
                            .symbolVariant(selected == item.id ? .fill : .none)
                        Text(item.label)
                            .font(.system(size: 10, weight: .medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .foregroundStyle(selected == item.id ? MyPlaylistsRedditTheme.accent : Color(uiColor: .systemGray))
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 2)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Rectangle().fill(Color(uiColor: .separator)).frame(height: 0.33)
        }
    }
}
