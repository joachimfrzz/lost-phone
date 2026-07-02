import SwiftUI

// Vendored from NDCSwift/InstagramRecreation2

struct InstagramRedditTopAppBar: View {
    var body: some View {
        HStack {
            Text("Instagram")
                .font(.system(size: 28, weight: .bold))
                .kerning(0.5)
            Spacer()
            HStack(spacing: 16) {
                Image(systemName: "plus.app")
                Image(systemName: "heart")
                ZStack {
                    Image(systemName: "paperplane")
                    Text("3")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 1)
                        .background(Capsule().fill(Color.red))
                        .offset(x: 8, y: -8)
                }
            }
            .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(uiColor: .systemBackground))
    }
}
