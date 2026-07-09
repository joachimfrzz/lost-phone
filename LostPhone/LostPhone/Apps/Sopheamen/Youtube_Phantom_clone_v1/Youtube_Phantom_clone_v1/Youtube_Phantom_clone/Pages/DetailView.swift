//
//  DetailView.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 17/3/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    var currency:CurrencyResponse
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing:24){
                    // total balance
                    TotalBalanceView(currency: currency)
                    // chart view
                    ChartView(currency: currency)
                    // option
                    DetailOptionView()
                    // about
                    AboutView(currency: currency)
                    // info
                    InfoView(currency: currency)
                }
                .padding(.vertical, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                // leading
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                }
                // center
                ToolbarItem (placement: .principal){
                    Text(currency.name)
                        .font(.title3)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    DetailView(currency: currencyData[0])
}

struct TotalBalanceView:View {
    var currency:CurrencyResponse
    var body: some View {
        VStack (spacing:0){
            // main
            Text(currency.totalBalance)
                .font(.system(size: 40, weight: .semibold))
            // sub
            HStack {
                Text(currency.totalChange)
                    .font(.headline)
                    .foregroundStyle(currency.totalChangeType == 1 ? Color.successColor : Color.dangerColor)
                Text(currency.percentageChange)
                    .font(.headline)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 1)
                    .background(currency.totalChangeType == 1 ? Color.successLightColor : Color.dangerColor.opacity(0.2))
                    .foregroundStyle(currency.totalChangeType == 1 ? Color.successColor : Color.dangerColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    
            }
        }
    }
}

struct ChartView:View {
    var currency:CurrencyResponse
    var body: some View {
        if currency.totalChangeType == 1 {
            LinePlusChartView()
                .frame(height: 150)
        } else {
            LineMinusChartView()
                .frame(height: 150)
        }
    }
}

struct DetailOptionView:View {
    var options:[OptionsResponse] = optionsDetailData
    var body: some View {
        LazyHStack (spacing:10){
            ForEach(options) { option in
                Button {
                    
                }label: {
                    VStack {
                        Image(systemName: option.icon)
                            .resizable()
                            .scaledToFill()
                            .frame(width: option.size, height:  option.size)
                            .foregroundStyle(Color.primaryColor)
                        Text(option.title)
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .padding(.top, 8)
                    .frame(width: 85, height: 85)
                    .background(Color.cardBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

struct AboutView:View {
    var currency:CurrencyResponse!
    var body: some View {
        VStack (spacing:4){
            Text("About")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
            Text(currency.about)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Show More")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWeight(.semibold)
                .foregroundStyle(Color.primaryColor)
        }
        .font(.headline)
        .fontWeight(.regular)
        .foregroundStyle(.white.opacity(0.7))
        .padding(.horizontal)
    }
}

struct InfoView:View {
    var currency:CurrencyResponse
    var body: some View {
        VStack (spacing:8){
            Text("Info")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white.opacity(0.7))
            // list
            VStack {
                // title, value
                HStack {
                    Text("Symbol")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.7))
                    Spacer()
                    Text(currency.symbol)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(.black)
                    .frame(height: 0.6)
                // title, value
                HStack {
                    Text("Network")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.7))
                    Spacer()
                    Text(currency.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(.black)
                    .frame(height: 0.6)
                // title, value
                HStack {
                    Text("Market Cap")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.7))
                    Spacer()
                    Text(currency.marketCap)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(.black)
                    .frame(height: 0.6)
                // title, value
                HStack {
                    Text("Total Supply")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.7))
                    Spacer()
                    Text(currency.totalSupply)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(.black)
                    .frame(height: 0.6)
                // title, value
                HStack {
                    Text("Circulating Supply")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.7))
                    Spacer()
                    Text(currency.circulatingSupply)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(.black)
                    .frame(height: 0.6)
                // title, value
                HStack {
                    Text("Max Supply")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.7))
                    Spacer()
                    Text(currency.maxSupply)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
               
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color.cardBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal)
    }
}
