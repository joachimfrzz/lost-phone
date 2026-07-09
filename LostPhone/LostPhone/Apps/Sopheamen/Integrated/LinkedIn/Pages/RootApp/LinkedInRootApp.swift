import SwiftUI

struct LinkedInRootApp: View {
    @State private var selectedTab = 0
    @State private var searchField = ""
    @State private var isUploadPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    LinkedInHome().tag(0)
                    MyNetworkView().tag(1)
                    UploadPostView().tag(2)
                    NotificationView().tag(3)
                    JobView().tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                HStack(spacing: 0) {
                    LinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 0, label: "Home", systemIconName: "house.fill")
                    LinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 1, label: "My Network", systemIconName: "person.2.fill")
                    LinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 2, label: "Post", systemIconName: "plus.app.fill")
                    LinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 3, label: "Notifications", systemIconName: "bell.fill")
                    LinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 4, label: "Jobs", systemIconName: "briefcase.fill")
                }
                .frame(height: 44)
                .background(Color(uiColor: .systemBackground))
            }
            .preferredColorScheme(.light)
            .onChange(of: selectedTab) { _, newValue in
                if newValue == 2 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        isUploadPresented = true
                        selectedTab = 0
                    }
                }
            }
            .sheet(isPresented: $isUploadPresented) {
                UploadPostView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ProfileImageView(profileImage: userDataCurrent.profileImage, size: 35)
                }
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.primary)
                        TextField("Search", text: $searchField)
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 35)
                    .background(Color.textFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: AppSetting.smallRadius))
                    .padding(.horizontal, AppSetting.smallPadding)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: MessageView()) {
                        Image(systemName: "ellipsis.message.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

struct LinkedInTabBarButton: View {
    @Binding var selectedTab: Int
    let assignedTab: Int
    let label: String
    let systemIconName: String

    var body: some View {
        Button {
            withAnimation { selectedTab = assignedTab }
        } label: {
            VStack {
                Image(systemName: systemIconName)
                    .font(.system(size: 18))
                Text(label)
                    .font(.footnote)
            }
            .foregroundStyle(selectedTab == assignedTab ? .primary : .secondary)
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(selectedTab == assignedTab ? Color.primary : .clear),
                alignment: .top
            )
        }
        .frame(maxWidth: .infinity)
    }
}
