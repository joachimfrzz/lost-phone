import SwiftUI

// Vendored from debuging-life/netflix-clone — TopBar

struct NetflixRedditTopBar: View {
    var text: String
    var textColor: Color = .white

    var body: some View {
        HStack {
            Text(text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(textColor)
            Spacer()
            HStack {
                Image(systemName: "arrow.down.circle.dotted")
                    .font(.title)
                    .foregroundStyle(textColor)
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundStyle(textColor)
            }
        }
    }
}
