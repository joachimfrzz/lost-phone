//
//  VendoredUberEatsCartDetailView.swift
//  food-delivery-ui-kit-v1
//
//  Created by Sopheamen VAN on 2/5/25.
//

import SwiftUI
import Kingfisher

struct VendoredUberEatsCartDetailView: View {
    var cart:VendoredUberEatsCartResponse
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:14){
                   
                    // list
                    VStack (spacing:14){
                        VendoredUberEatsListMenuView(restaurant: cart.restaurant)
                        // add item button
 
                        Button {
                            
                        }label: {
                            HStack {
                                Image(systemName: "plus")
                                Text("Add items")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.black)
                            .frame(width: 120, height: 30)
                            .background(Color.vendoredUberEatsCardColor)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        
                    }
                    VendoredUberEatsSendGiftView()
                    // send a gift
                    Divider()
                    // sub total
                    VendoredUberEatsSubTotalView(cart: cart)
                    // checkout button
                    NavigationLink (destination: VendoredUberEatsCheckoutView(cart: cart)){
                        Text("Go to checkout")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.vendoredUberEatsDarkButtonColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                  
                }
                .padding(.horizontal)
                .padding(.vertical)
               
            }
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                }
               
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(cart.restaurant.name)
        }
    }
}

#Preview {
    VendoredUberEatsCartDetailView(cart: cartData[0])
}

struct VendoredUberEatsListMenuView:View {
    var restaurant:VendoredUberEatsRestaurantResponse
    var body: some View {
        LazyVStack (spacing:14){
            ForEach(restaurant.menu) { menu in
                VendoredUberEatsMenuRowView(menu: menu)
            }
        }
    }
}

struct VendoredUberEatsMenuRowView:View {
    var menu:VendoredUberEatsMenuResponse
    var body: some View {
        VStack {
            // content
            HStack (spacing:16){
                KFImage(URL(string: menu.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())

                VStack (alignment: .leading, spacing: 2){
                    Text(menu.name)
                        .font(.headline)
                    Text(menu.price)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black.opacity(0.7))
                }
                Spacer()
                // button - and +
                HStack (spacing:20){
                    Button {
                        
                    }label: {
                        Image(systemName: "minus")
                            .foregroundStyle(.black)
                    }
                    Text("1")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Button {
                        
                    }label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                    }
                }
                .frame(width: 110, height: 30)
                .background(Color.vendoredUberEatsCardColor)
                .clipShape(Capsule())
            }
            // divider
            Divider()
        }
    }
}


struct VendoredUberEatsSendGiftView:View {
    var body: some View {
        HStack (spacing:14){
            Image(systemName: "gift")
                .font(.title3)
            VStack (alignment: .leading, spacing: 0){
                Text("Send as a gift")
                    .font(.headline)
                Text("Add customize a digital card")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.black.opacity(0.7))
        }
    }
}

struct VendoredUberEatsSubTotalView:View {
    var cart:VendoredUberEatsCartResponse
    var body: some View {
        HStack {
            Text("Total")
                .font(.title3)
            Spacer()
            Text(cart.totalPrice)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}
