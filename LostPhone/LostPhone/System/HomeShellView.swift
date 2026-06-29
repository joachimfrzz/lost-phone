import SwiftUI

struct HomeShellView: View {
    @EnvironmentObject private var phone: PhoneViewModel
    @State private var currentPage = 0

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    private var gridApps: [String] {
        var names = phone.appNames.filter { !phone.dockApps.contains($0) }
        if !names.contains("Réglages") {
            names.append("Réglages")
        }
        return names
    }

    private var pages: [[String]] {
        stride(from: 0, to: max(gridApps.count, 1), by: 16).map { start in
            Array(gridApps.dropFirst(start).prefix(16))
        }
    }

    var body: some View {
        ZStack {
            WallpaperView()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                StatusBarView()
                    .padding(.top, 4)

                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, pageApps in
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(pageApps, id: \.self) { app in
                                LpspAppIconView(appName: app) {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        phone.openApp(app)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 24)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: pages.count > 1 ? .automatic : .never))

                Spacer(minLength: 0)

                HStack(spacing: 20) {
                    ForEach(phone.dockApps, id: \.self) { app in
                        LpspAppIconView(appName: app, showLabel: false) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                phone.openApp(app)
                            }
                        }
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 18)
                .iosDockGlass(in: RoundedRectangle(cornerRadius: 35, style: .continuous))
                .padding(.horizontal, 10)
                .padding(.bottom, 8)
            }
            .padding(.vertical, 24)

            HiddenVolumeView()
                .frame(width: 0, height: 0)
        }
        .fullScreenCover(item: Binding(
            get: { phone.activeApp.map { ActiveAppItem(name: $0) } },
            set: { phone.activeApp = $0?.name }
        )) { item in
            LpspAppContainerView(appName: item.name)
                .environmentObject(phone)
        }
    }
}

private struct ActiveAppItem: Identifiable {
    let name: String
    var id: String { name }
}
