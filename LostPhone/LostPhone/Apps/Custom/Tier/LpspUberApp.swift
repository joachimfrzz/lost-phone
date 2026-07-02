import SwiftUI

// Clone Uber iOS — onglet Activité, détail course (read-only, LPSP).

struct LpspUberView: View {
    let rides: [LpspRide]
    @State private var selected: LpspRide?

    private let tabs: [TierIOSTabBar.Item] = [
        .init(id: "home", icon: "house", label: "Accueil"),
        .init(id: "services", icon: "square.grid.2x2", label: "Services"),
        .init(id: "activity", icon: "clock", label: "Activité"),
        .init(id: "account", icon: "person", label: "Compte"),
    ]

    var body: some View {
        TierCloneShell {
            TierIOSTabBar(items: tabs, selected: "activity", accent: LpspThirdPartyBrand.uberBlack)
        } content: {
            NavigationStack {
                Group {
                    if rides.isEmpty {
                        ContentUnavailableView("Uber", systemImage: "car.fill", description: Text("Aucune course"))
                    } else {
                        List {
                            ForEach(LpspThirdPartyGrouping.byDay(rides) { $0.date }, id: \.0) { section, items in
                                Section {
                                    ForEach(items) { ride in
                                        Button { selected = ride } label: {
                                            UberActivityRow(ride: ride)
                                        }
                                        .buttonStyle(.plain)
                                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                    }
                                } header: {
                                    Text(section.uppercased())
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .background(Color(uiColor: .systemBackground))
                .navigationTitle("Activité")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {} label: {
                            Image(systemName: "questionmark.circle")
                                .foregroundStyle(.secondary)
                        }
                        .disabled(true)
                    }
                }
                .navigationDestination(item: $selected) { ride in
                    UberTripDetailView(ride: ride)
                }
            }
        }
    }
}

private struct UberActivityRow: View {
    let ride: LpspRide

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(LpspThirdPartyBrand.uberGray)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "car.side.fill")
                        .font(.title2)
                        .foregroundStyle(LpspThirdPartyBrand.uberBlack)
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(ride.dropoff)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer(minLength: 4)
            VStack(alignment: .trailing, spacing: 2) {
                Text(ride.price)
                    .font(.subheadline.weight(.semibold))
                Image(systemName: "chevron.right")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(.vertical, 12)
    }

    private var subtitle: String {
        let d = ride.date.map { LpspThirdPartyFormat.frenchDate($0, style: .medium, time: .short) } ?? ride.dateRaw
        if ride.driver.isEmpty { return d }
        return "\(d) · \(ride.driver)"
    }
}

private struct UberTripDetailView: View {
    let ride: LpspRide

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LpspFakeMapView(accent: Color(red: 0.78, green: 0.85, blue: 0.72), height: 240)

                VStack(alignment: .leading, spacing: 24) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ride.price)
                                .font(.title.weight(.bold))
                            Text("Course \(ride.status)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if !ride.vehicle.isEmpty {
                            Text(ride.vehicle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }

                    LpspRouteTimeline(origin: ride.pickup, destination: ride.dropoff, dropoffColor: .black)

                    if !ride.driver.isEmpty {
                        HStack(spacing: 14) {
                            Circle()
                                .fill(LpspThirdPartyBrand.uberGray)
                                .frame(width: 48, height: 48)
                                .overlay {
                                    Text(String(ride.driver.prefix(1)))
                                        .font(.headline)
                                }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(ride.driver)
                                    .font(.subheadline.weight(.semibold))
                                HStack(spacing: 2) {
                                    ForEach(0..<5, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 9))
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }

                    VStack(spacing: 0) {
                        receiptLine("Sous-total", ride.price)
                        receiptLine("Frais", "Inclus")
                        Divider().padding(.vertical, 8)
                        HStack {
                            Text("Total")
                                .font(.headline)
                            Spacer()
                            Text(ride.price)
                                .font(.headline)
                        }
                    }
                    .padding(16)
                    .background(LpspThirdPartyBrand.uberGray)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(20)
            }
        }
        .navigationTitle(LpspThirdPartyFormat.frenchDate(ride.date, style: .medium, time: .short))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Aide") {}
                    .font(.subheadline)
                    .disabled(true)
            }
        }
    }

    private func receiptLine(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
        .font(.subheadline)
        .padding(.vertical, 4)
    }
}
