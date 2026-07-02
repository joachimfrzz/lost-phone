import SwiftUI

// Clone Instagram — profil + grille + bottom tabs.

struct LpspInstagramView: View {
    let profile: LpspInstagramProfile?
    @State private var selected: LpspInstagramPost?

    private let tabs: [TierIOSTabBar.Item] = [
        .init(id: "home", icon: "house", label: ""),
        .init(id: "search", icon: "magnifyingglass", label: ""),
        .init(id: "reels", icon: "play.rectangle", label: ""),
        .init(id: "shop", icon: "bag", label: ""),
        .init(id: "profile", icon: "person.crop.circle", label: ""),
    ]

    var body: some View {
        TierCloneShell {
            TierIOSTabBar(items: tabs, selected: "profile", accent: .primary)
        } content: {
            NavigationStack {
                Group {
                    if let profile {
                        ScrollView {
                            VStack(spacing: 0) {
                                profileHeader(profile)
                                postGrid(profile.posts)
                            }
                        }
                    } else {
                        ContentUnavailableView("Instagram", systemImage: "camera.fill")
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .navigationTitle(LpspAppCatalog.displayName("Instagram"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 18) {
                            Button {} label: { Image(systemName: "plus.app") }
                            Button {} label: { Image(systemName: "line.3.horizontal") }
                        }
                        .disabled(true)
                    }
                }
                .sheet(item: $selected) { post in
                    InstagramPostSheet(post: post, username: profile?.username ?? "")
                }
            }
        }
    }

    @ViewBuilder
    private func profileHeader(_ profile: LpspInstagramProfile) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 22) {
                Circle()
                    .strokeBorder(LpspThirdPartyBrand.instagramGradient, lineWidth: 3)
                    .frame(width: 86, height: 86)
                    .overlay {
                        Circle()
                            .fill(Color(uiColor: .secondarySystemBackground))
                            .padding(3)
                            .overlay {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundStyle(.secondary)
                            }
                    }
                HStack(spacing: 0) {
                    stat("\(profile.posts.count)", "publications")
                    stat("412", "abonnés")
                    stat("318", "abonnements")
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(profile.username)
                    .font(.subheadline.weight(.semibold))
                Text(profile.bio)
                    .font(.subheadline)
            }

            HStack(spacing: 8) {
                profileButton("Modifier le profil", filled: true)
                profileButton("Partager le profil", filled: false)
                Image(systemName: "person.badge.plus")
                    .frame(width: 34, height: 32)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            HStack(spacing: 0) {
                Image(systemName: "square.grid.3x3.fill")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .overlay(alignment: .bottom) { Rectangle().fill(.primary).frame(height: 1) }
                Image(systemName: "person.crop.rectangle")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func stat(_ n: String, _ label: String) -> some View {
        VStack(spacing: 2) {
            Text(n).font(.subheadline.weight(.bold))
            Text(label).font(.caption2)
        }
        .frame(maxWidth: .infinity)
    }

    private func profileButton(_ title: String, filled: Bool) -> some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(filled ? Color(uiColor: .secondarySystemBackground) : .clear)
            .overlay {
                if !filled {
                    RoundedRectangle(cornerRadius: 8).strokeBorder(Color(uiColor: .systemGray4))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func postGrid(_ posts: [LpspInstagramPost]) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 3), spacing: 1) {
            ForEach(posts) { post in
                Button { selected = post } label: {
                    Rectangle()
                        .fill(Color(uiColor: .secondarySystemBackground))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay { Image(systemName: "photo").foregroundStyle(.secondary) }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct InstagramPostSheet: View {
    let post: LpspInstagramPost
    let username: String

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .fill(Color(uiColor: .secondarySystemBackground))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay { Image(systemName: "photo.artframe").font(.largeTitle).foregroundStyle(.secondary) }

                    HStack(spacing: 18) {
                        Image(systemName: "heart")
                        Image(systemName: "bubble.right")
                        Image(systemName: "paperplane")
                        Spacer()
                        Image(systemName: "bookmark")
                    }
                    .font(.title3)
                    .padding(16)

                    Text("\(post.likes) J'aime")
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 16)

                    Text("\(Text(username).bold()) \(post.caption)")
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.top, 4)

                    Text(post.date)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .padding(16)
                }
            }
            .navigationTitle("Publication")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}
