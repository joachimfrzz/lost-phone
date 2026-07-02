import SwiftUI

// Point d'entrée Lost Phone — clone NDCSwift/InstagramRecreation2 + profil LPSP.
// Source vendored : https://github.com/NDCSwift/InstagramRecreation2

struct InstagramRedditAppView: View {
    let profile: LpspInstagramProfile?
    @State private var selectedTab = 0
    @State private var selectedPost: LpspInstagramPost?

    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case 0:
                        feedTab
                    case 4:
                        profileTab
                    default:
                        InstagramRedditPlaceholderTab(index: selectedTab)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Divider()
                InstagramRedditBottomTabBar(selected: $selectedTab)
            }
        }
        .sheet(item: $selectedPost) { post in
            InstagramPostDetailSheet(post: post, username: profile?.username ?? "")
        }
    }

    @ViewBuilder
    private var feedTab: some View {
        VStack(spacing: 0) {
            InstagramRedditTopAppBar()
            Divider()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    InstagramRedditStoriesBar(ownStoryLabel: profile?.username ?? "Votre story")
                    Divider()
                    if let profile, !profile.posts.isEmpty {
                        InstagramRedditFeedList(posts: profile.posts, username: profile.username)
                    } else {
                        InstagramRedditFeedList.demo()
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var profileTab: some View {
        if let profile {
            InstagramProfileTabView(profile: profile, selected: $selectedPost)
        } else {
            ContentUnavailableView("Instagram", systemImage: "camera.fill")
        }
    }
}

private struct InstagramRedditPlaceholderTab: View {
    let index: Int

    private var title: String {
        switch index {
        case 1: return "Recherche"
        case 2: return "Créer"
        case 3: return "Reels"
        default: return "Instagram"
        }
    }

    var body: some View {
        ContentUnavailableView(title, systemImage: "camera.fill")
    }
}

/// Route LPSP — même nom qu'avant pour le router.
struct LpspInstagramView: View {
    let profile: LpspInstagramProfile?

    var body: some View {
        InstagramRedditAppView(profile: profile)
    }
}
