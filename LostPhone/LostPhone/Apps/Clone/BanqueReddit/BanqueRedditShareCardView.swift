import SwiftUI

// Vendored depuis YT-BankingApp/View/ShareCardView.swift — read-only Lost Phone.

struct BanqueRedditShareCardView: View {
    let initials: [String]

    var body: some View {
        ZStack {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Envoyer de l'argent à")
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .bold))

                    LazyHStack(spacing: -5) {
                        ForEach(Array(initials.prefix(5).enumerated()), id: \.offset) { _, value in
                            BanqueRedditAvatarView(initials: value, size: 40)
                                .overlay {
                                    Circle()
                                        .stroke(.black, lineWidth: 1)
                                }
                        }
                    }
                    .frame(height: 60)
                }

                Spacer()

                ZStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                        .padding(.vertical, 30)
                        .padding(.horizontal)
                }
                .background(BanqueRedditTheme.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.horizontal)
            .padding(.top, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(BanqueRedditTheme.dark)
        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        .padding(.horizontal)
        .padding(.top, 30)
    }
}

struct BanqueRedditAvatarView: View {
    let initials: String
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(BanqueRedditTheme.purple.opacity(0.85))
            .frame(width: size, height: size)
            .overlay {
                Text(initials)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white)
            }
    }
}
