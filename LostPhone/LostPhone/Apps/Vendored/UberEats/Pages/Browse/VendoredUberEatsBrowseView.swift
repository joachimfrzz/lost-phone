import SwiftUI
import Kingfisher

struct VendoredUberEatsBrowseView: View {
    var restaurants: [VendoredUberEatsCartResponse] = cartData

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
                        Text("Rechercher un restaurant")
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    Text("À proximité")
                        .font(.title3)
                        .fontWeight(.semibold)

                    ForEach(restaurants) { cart in
                        NavigationLink(destination: VendoredUberEatsCartDetailView(cart: cart)) {
                            HStack(spacing: 14) {
                                KFImage(URL(string: cart.restaurant.coverUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 88, height: 88)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(cart.restaurant.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    Text("\(cart.restaurant.rating) ★ · \(cart.restaurant.duration)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text("Frais \(cart.restaurant.deliveryFee)")
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
