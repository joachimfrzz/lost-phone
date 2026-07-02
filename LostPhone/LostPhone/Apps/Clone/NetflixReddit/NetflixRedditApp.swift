import SwiftUI

// Point d'entrée Lost Phone — clone debuging-life/netflix-clone + LPSP J-3.
// Source vendored : https://github.com/debuging-life/netflix-clone
// UI vendored sans Supabase / Kingfisher / TMDB (données LPSP + placeholders).

struct NetflixRedditAppView: View {
    let data: LpspNetflixData?
    @State private var selectedProfile: LpspNetflixProfile?

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ZStack {
                        LinearGradient(
                            colors: [NetflixRedditTheme.bgLightGray, .black],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()

                        VStack(spacing: 0) {
                            NetflixRedditTopBar(
                                text: "Pour \(selectedProfile?.name ?? data.profiles.first?.name ?? "Mathieu")"
                            )
                            .padding(.horizontal)
                            .padding(.top, 4)

                            ScrollView(showsIndicators: false) {
                                VStack(alignment: .leading, spacing: 16) {
                                    NetflixRedditProfilePicker(
                                        profiles: data.profiles,
                                        selected: $selectedProfile
                                    )

                                    NetflixRedditHeroCard()

                                    let continueItems = NetflixRedditLPSP.filtered(
                                        data.continueWatching,
                                        profile: selectedProfile
                                    )
                                    if !continueItems.isEmpty {
                                        NetflixRedditContinueRow(
                                            items: continueItems,
                                            profileName: selectedProfile?.name ?? "Mathieu"
                                        )
                                    }

                                    NetflixRedditSectionRow(
                                        title: "Populaire sur Netflix",
                                        count: 6
                                    )
                                    NetflixRedditSectionRow(
                                        title: "Séries d'action",
                                        count: 5
                                    )

                                    NetflixRedditAccountFooter(data: data)
                                        .padding(.bottom, 24)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .onAppear {
                        if selectedProfile == nil {
                            selectedProfile = data.profiles.first
                        }
                    }
                } else {
                    ContentUnavailableView("Netflix", systemImage: "play.tv.fill")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    NetflixRedditLogoView()
                }
            }
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

/// Route LPSP — même nom qu'avant pour le router.
struct LpspNetflixView: View {
    let data: LpspNetflixData?

    var body: some View {
        NetflixRedditAppView(data: data)
    }
}
