import SwiftUI

// Clone Apple Plans (Maps FR) — carte + bottom sheet.

struct LpspPlansView: View {
    let data: LpspMapsData?
    @State private var selectedTrip: LpspMapTrip?
    @State private var segment = 0

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ZStack(alignment: .top) {
                        LpspFakeMapView(height: UIScreen.main.bounds.height * 0.42, showRoute: false)
                            .ignoresSafeArea(edges: .top)

                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: UIScreen.main.bounds.height * 0.30)

                            VStack(spacing: 0) {
                                Capsule()
                                    .fill(Color(uiColor: .systemGray3))
                                    .frame(width: 36, height: 5)
                                    .padding(.top, 8)
                                    .padding(.bottom, 12)

                                LpspSearchBar(placeholder: "Rechercher dans Plans")
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 12)

                                Picker("", selection: $segment) {
                                    Text("Récents").tag(0)
                                    Text("Enregistrés").tag(1)
                                    Text("Itinéraires").tag(2)
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 8)

                                List {
                                    switch segment {
                                    case 0:
                                        ForEach(data.trips) { trip in
                                            Button { selectedTrip = trip } label: {
                                                PlansTripRow(trip: trip)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    case 1:
                                        ForEach(data.places) { place in
                                            PlansPlaceRow(place: place)
                                        }
                                    default:
                                        ForEach(data.routes) { route in
                                            PlansRouteRow(route: route)
                                        }
                                    }
                                }
                                .listStyle(.plain)
                                .scrollContentBackground(.hidden)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.12), radius: 16, y: -4)
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "Plans",
                        systemImage: "map.fill",
                        description: Text("Ajoutez content.apps.Plans dans lpsp.json")
                    )
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Plans"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {} label: { Image(systemName: "person.crop.circle") }
                        .disabled(true)
                }
            }
            .navigationDestination(item: $selectedTrip) { trip in
                PlansTripDetail(trip: trip)
            }
        }
    }
}

private struct PlansTripRow: View {
    let trip: LpspMapTrip

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: modeIcon)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 4) {
                Text(trip.destination)
                    .font(.subheadline.weight(.medium))
                    .lineLimit(1)
                Text("\(trip.origin) · \(trip.duration)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Text(trip.date.map { LpspThirdPartyFormat.frenchDate($0, style: .short) } ?? "")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }

    private var modeIcon: String {
        switch trip.mode.lowercased() {
        case let m where m.contains("pied"): return "figure.walk"
        case let m where m.contains("voiture"): return "car.fill"
        case let m where m.contains("transit"): return "tram.fill"
        default: return "location.fill"
        }
    }
}

private struct PlansPlaceRow: View {
    let place: LpspMapPlace

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "mappin.circle.fill")
                .font(.title2)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, LpspThirdPartyBrand.plansPin)
            VStack(alignment: .leading, spacing: 3) {
                Text(place.label)
                    .font(.subheadline.weight(.semibold))
                Text(place.address)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct PlansRouteRow: View {
    let route: LpspSavedRoute

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(route.name.isEmpty ? "Itinéraire enregistré" : route.name)
                .font(.subheadline.weight(.semibold))
            Text("\(route.origin) → \(route.destination)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            Text(route.duration)
                .font(.caption2)
                .foregroundStyle(.blue)
        }
        .padding(.vertical, 4)
    }
}

private struct PlansTripDetail: View {
    let trip: LpspMapTrip

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LpspFakeMapView(height: 240)
                VStack(alignment: .leading, spacing: 20) {
                    LpspRouteTimeline(origin: trip.origin, destination: trip.destination, dropoffColor: LpspThirdPartyBrand.plansPin)
                    HStack {
                        Label(trip.mode.capitalized, systemImage: modeIcon)
                        Spacer()
                        Text(trip.duration)
                            .foregroundStyle(.secondary)
                    }
                    .font(.subheadline)
                }
                .padding(20)
            }
        }
        .navigationTitle(LpspThirdPartyFormat.frenchDate(trip.date, style: .medium))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var modeIcon: String {
        trip.mode.lowercased().contains("pied") ? "figure.walk" : "car.fill"
    }
}
