import SwiftUI
import Kingfisher

struct VendoredUberEatsBrowseView: View {
    @State private var searchQuery = ""
    var restaurants: [VendoredUberEatsRestaurantResponse] = vendoredUberEatsBrowseRestaurants

    private var filteredRestaurants: [VendoredUberEatsRestaurantResponse] {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return restaurants }
        return restaurants.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Uber Eats")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.vendoredUberEatsVendoredUberEatsPrimary)

                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Rechercher un restaurant", text: $searchQuery)
                            .autocorrectionDisabled()
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Text("À proximité")
                        .font(.title3)
                        .fontWeight(.semibold)

                    ForEach(filteredRestaurants) { restaurant in
                        NavigationLink(destination: VendoredUberEatsRestaurantMenuView(restaurant: restaurant)) {
                            HStack(spacing: 14) {
                                KFImage(URL(string: restaurant.coverUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 88, height: 88)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(restaurant.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    Text("\(restaurant.rating) ★ · \(restaurant.duration)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text("Frais \(restaurant.deliveryFee)")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: VendoredUberEatsCartView()) {
                        Image(systemName: "cart")
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}
