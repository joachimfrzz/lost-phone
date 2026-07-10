//
//  VendoredPhantomHomeView.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 17/3/25.
//

import SwiftUI
import Kingfisher // for image network cache

struct VendoredPhantomHomeView: View {
    var body: some View {
        NavigationStack {
            ZStack (alignment:.top){
                // header color overlay blur
                Color.vendoredPhantomVendoredPhantomPrimary
                    .frame(height:150)
                    .blur(radius: 180)
                // content info
                VendoredPhantomContentInfoView()
            }
            .ignoresSafeArea(.all)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredPhantomHomeView()
}

struct VendoredPhantomContentInfoView:View {
    var body: some View {
        VStack (spacing:16){
            // profile, icon
            HStack {
                HStack {
                    ZStack{
                        Circle()
                            .fill(Color.vendoredPhantomVendoredPhantomPrimary)
                            .frame(width: 42, height: 42)
                        Text("A")
                            .font(.headline)
                        
                    }
                    VStack (alignment: .leading, spacing: -2){
                        Text("@alexender.kuznetsov")
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.5))
                        HStack (spacing:6){
                            Text("Account 2")
                                .font(.headline)
                            Image(systemName: "chevron.down")
                                .font(.footnote)
                        }
                    }
                }
                Spacer()
                HStack (spacing:12){
                    // scan, search
                    Button {
                        
                    }label: {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    Button {
                        
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            // balance
            VStack (spacing:0){
                // main
                Text("$301.02")
                    .font(.system(size: 40, weight: .bold, design: .default))
                // sub
                HStack {
                    Text("+$60.90")
                        .font(.headline)
                        .foregroundStyle(Color.vendoredPhantomSuccessColor)
                    Text("+12.99%")
                        .font(.headline)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(Color.vendoredPhantomSuccessLightColor)
                        .foregroundStyle(Color.vendoredPhantomSuccessColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }
            // scrollable list content
            ScrollView (showsIndicators: false){
                VStack (spacing: 16){
                    VendoredPhantomTransactionsView()
                    // options
                    VendoredPhantomOptionsView()
                    // list currencies
                    VendoredPhantomCurrenciesView()
                }
            }
        }
        .padding(.top, 60)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct VendoredPhantomTransactionsView: View {
    private let transactions = [
        ("Received SOL", "+$42.10", "Today"),
        ("Swap USDC → SOL", "-$18.00", "Yesterday"),
        ("NFT purchase", "-$120.00", "Mon")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent activity")
                .font(.headline)
                .foregroundStyle(.white)
            ForEach(transactions, id: \.0) { tx in
                HStack {
                    VStack(alignment: .leading) {
                        Text(tx.0)
                            .foregroundStyle(.white)
                        Text(tx.2)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    Spacer()
                    Text(tx.1)
                        .foregroundStyle(tx.1.hasPrefix("+") ? Color.vendoredPhantomSuccessColor : .white)
                }
                .padding(.vertical, 8)
                Divider().overlay(.white.opacity(0.15))
            }
        }
        .padding()
        .background(Color.vendoredPhantomCardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct VendoredPhantomOptionsView:View {
    var optionsDatas:[VendoredPhantomOptionsResponse] = optionsData
    var body: some View {
        LazyHStack (spacing:10){
            ForEach(optionsDatas) { option in
                Button {
                    
                }label: {
                    VStack {
                        Image(systemName: option.icon)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(Color.vendoredPhantomVendoredPhantomPrimary)
                        Text(option.title)
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.top, 8)
                    .frame(width: 85, height: 85)
                    .background(Color.vendoredPhantomCardBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

struct VendoredPhantomCurrenciesView:View {
    var currencyDatas:[VendoredPhantomCurrencyResponse] = currencyData
    var body: some View {
        LazyVStack (spacing:10){
            ForEach(currencyDatas) { currency in
                NavigationLink (destination: VendoredPhantomDetailView(currency: currency)){
                    VendoredPhantomCurrenciesRowView(currency: currency)
                }
            }
        }
    }
}

struct VendoredPhantomCurrenciesRowView:View {
    var currency:VendoredPhantomCurrencyResponse
    var body: some View {
        HStack {
            // profile, name
            HStack (spacing:12){
                KFImage(URL(string: currency.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                VStack (alignment: .leading, spacing: 0){
                    Text(currency.name)
                        .font(.headline)
                    Text(currency.rate)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            // balance
            VStack (alignment: .trailing, spacing: -2){
                Text(currency.amount)
                    .font(.headline)
                Text(currency.subAmount)
                    .font(.subheadline)
                    .foregroundStyle(currency.type == 1 ? Color.vendoredPhantomSuccessColor : Color.vendoredPhantomDangerColor)
                    
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .background(Color.vendoredPhantomCardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
