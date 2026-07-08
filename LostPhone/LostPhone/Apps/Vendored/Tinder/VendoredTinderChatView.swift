import SwiftUI

struct VendoredTinderChatView: View {
    @State private var tab = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    HStack(spacing: 0) {
                        tabLabel("Messages", index: 0)
                        Rectangle().fill(.black.opacity(0.15)).frame(width: 1, height: 25)
                        tabLabel("Matches", index: 1)
                    }
                    .padding(.top, 20)

                    Divider()

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.black.opacity(0.5))
                        Text("Search 0 Matches")
                            .foregroundStyle(.black.opacity(0.5))
                        Spacer()
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 5))
                    .padding(.horizontal, 8)

                    Divider()

                    Text("New Matches")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(VendoredTinderTheme.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 15)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(VendoredTinderData.explore.prefix(8)) { profile in
                                NavigationLink(value: profile) {
                                    VStack(spacing: 10) {
                                        VendoredTinderBundledPhoto(imageName: profile.imageName)
                                            .frame(width: 65, height: 65)
                                            .clipShape(Circle())
                                            .overlay {
                                                Circle().stroke(VendoredTinderTheme.primary, lineWidth: 3)
                                            }
                                        Text(profile.name)
                                            .font(.system(size: 13))
                                            .foregroundStyle(.primary)
                                            .lineLimit(1)
                                            .frame(width: 70)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 15)
                    }

                    VStack(spacing: 20) {
                        ForEach(VendoredTinderData.explore.prefix(6)) { profile in
                            NavigationLink(value: profile) {
                                HStack(spacing: 20) {
                                    VendoredTinderBundledPhoto(imageName: profile.imageName)
                                        .frame(width: 65, height: 65)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(profile.name)
                                            .font(.system(size: 17, weight: .medium))
                                            .foregroundStyle(.primary)
                                        Text(
                                            profile.previewMessage.isEmpty
                                                ? "You matched! Say hello 👋"
                                                : "\(profile.previewMessage) - \(profile.previewTime)"
                                        )
                                        .font(.system(size: 15))
                                        .foregroundStyle(.black.opacity(0.8))
                                        .lineLimit(1)
                                    }
                                    Spacer()
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
                }
            }
            .background(Color.white)
            .navigationDestination(for: VendoredTinderProfile.self) { profile in
                VendoredTinderChatDetailView(profile: profile)
            }
        }
    }

    private func tabLabel(_ title: String, index: Int) -> some View {
        Button {
            tab = index
        } label: {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(tab == index ? VendoredTinderTheme.primary : .black.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}
