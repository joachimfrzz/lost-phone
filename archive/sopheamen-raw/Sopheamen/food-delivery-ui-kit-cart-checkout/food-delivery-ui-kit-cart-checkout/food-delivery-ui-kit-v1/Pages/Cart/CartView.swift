//
//  CartView.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 30/4/25.
//

import SwiftUI
import Kingfisher

struct CartView: View {
    var cartDatas:[CartResponse] = cartData
    var body: some View {
        NavigationStack {
            ScrollView (.vertical, showsIndicators: false){
                LazyVStack (spacing:14){
                    ForEach(cartDatas) { cart in
                        ListCardRowView(cart: cart)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 24)
            }
            .toolbar {
                // leading
                ToolbarItem (placement: .topBarLeading){
                    Text("Cart")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                // trailing
                ToolbarItem (placement: .topBarTrailing){
                    HStack {
                        Image(systemName: "receipt")
                        Text("Orders")
                            .font(.headline)
                    }
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    CartView()
}

struct ListCardRowView:View {
    var cart:CartResponse
    var body: some View {
        VStack (spacing:12){
            // content info
            HStack (spacing:16){
                KFImage(URL(string: cart.restaurant.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                VStack (alignment: .leading, spacing:-2){
                    Text(cart.restaurant.name)
                        .font(.headline)
                    HStack {
                        Text("\(cart.itemCount) items - \(cart.totalPrice)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundStyle(.black.opacity(0.8))
                    }
                    Text(cart.deliveryTo)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black.opacity(0.8))
                }
                Spacer()
                // button option
                Button {
                    
                }label: {
                    ZStack {
                        Circle()
                            .fill(Color.cardColor)
                            .frame(width: 40, height: 40)
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                    }
                }
            }
            // buttons
            NavigationLink (destination: CartDetailView(cart: cart)){
                Text("View cart")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.darkButtonColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            //
            Text("View shop")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(.black.opacity(0.2))
        )
    }
}
