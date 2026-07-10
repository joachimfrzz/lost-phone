//
//  VendoredUberEatsRestaurantMenuView.swift
//

import SwiftUI
import Kingfisher

struct VendoredUberEatsRestaurantMenuView: View {
    var restaurant: VendoredUberEatsRestaurantResponse
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                KFImage(URL(string: restaurant.coverUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(restaurant.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("\(restaurant.rating) ★ · \(restaurant.duration) · \(restaurant.deliveryFee) delivery")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }

                Text("Menu")
                    .font(.title3)
                    .fontWeight(.semibold)

                VendoredUberEatsListMenuView(restaurant: restaurant)
            }
            .padding()
        }
        .navigationTitle(restaurant.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.primary)
                }
            }
        }
    }
}
