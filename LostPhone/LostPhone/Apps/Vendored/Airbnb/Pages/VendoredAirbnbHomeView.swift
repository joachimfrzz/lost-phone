//
//  VendoredAirbnbHomeView.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 29/1/25.
//

import SwiftUI
import Kingfisher // load image network cache

struct VendoredAirbnbHomeView: View {
    @State private var searchQuery = ""

    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                ScrollView {
                    VStack (spacing:24){
                        // search
                        VendoredAirbnbSearchView(searchQuery: $searchQuery)
                        // tabs
                        VendoredAirbnbTabsContentView()
                        // list item
                        VendoredAirbnbListBookingView(searchQuery: searchQuery)
                    }
                    .padding(.vertical)
                }
                // floating button
                Button {
                    
                }label: {
                    HStack {
                        Text("Map")
                            .font(.headline)
                        Image(systemName: "map.fill")
                    }
                    .foregroundStyle(.white)
                    .frame(width: 120, height: 55)
                    .background(.black.opacity(0.9))
                    .clipShape(Capsule())
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .principal){
                    HStack (spacing:12){
                        Image(systemName: "play.tv")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 18, height: 18)
                        Text("Replay welcome tour")
                            .foregroundStyle(.primary)
                            .font(.headline)
                            .underline(true)
                    }
                }
            }
            
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    VendoredAirbnbHomeView()
}

struct VendoredAirbnbSearchView:View {
    @Binding var searchQuery: String

    var body: some View {
        HStack (spacing:20){
            // search
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Start your search", text: $searchQuery)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(.white)
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.3),radius: 10)
            // filter icon
            Button {
                
            }label: {
                ZStack {
                    Circle()
                        .fill(.clear)
                        .frame(width: 45, height: 45)
                        .overlay(Circle().stroke(.gray.opacity(0.6), lineWidth: 1))
                    Image(systemName: "slider.horizontal.3")
                }
                .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)
    }
}

struct VendoredAirbnbTabsContentView:View {
    // list tabs
    var tabs:[VendoredAirbnbTabResponse] = vendoredAirbnbTabData
    // state index
    @State private var selectedIndex = 1
    // animation
    @Namespace private var animation
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false){
            LazyHStack (spacing:0){
                ForEach(tabs.indices, id: \.self) { index in
                    Button {
                        withAnimation {
                            selectedIndex = index
                        }
                    }label: {
                        VStack (spacing:14){
                            // icon and text
                            VStack (spacing:6){
                                KFImage(URL(string: tabs[index].imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 26, height: 26)
                                Text(tabs[index].title)
                                    .font(.subheadline)
                                    .fontWeight(selectedIndex == index ? .semibold : .regular)
                                    .foregroundStyle(.black)
                            }
                            // line vertical
                            ZStack {
                                Rectangle()
                                    .fill(.gray.opacity(0.2))
                                    .frame(height:1.5)
                                if selectedIndex == index {
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(height:1.5)
                                        .matchedGeometryEffect(id: "underline", in: animation) // for smooth animation
                                }
                            }
                        }
                    }
                    .frame(width: 100)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct VendoredAirbnbListBookingView:View {
    var searchQuery: String = ""
    var bookingsDatas:[VendoredAirbnbBookingResponse] = bookingsData

    private var filteredBookings: [VendoredAirbnbBookingResponse] {
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return bookingsDatas }
        return bookingsDatas.filter {
            $0.name.localizedCaseInsensitiveContains(query)
                || $0.mileAway.localizedCaseInsensitiveContains(query)
        }
    }
    
    var body: some View {
        LazyVStack (spacing:24){
            ForEach(filteredBookings) { booking in
                NavigationLink (destination: VendoredAirbnbDetailView(booking: booking)){
                    VendoredAirbnbBookingRowView(booking: booking)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct VendoredAirbnbBookingRowView:View {
    var booking:VendoredAirbnbBookingResponse
    // width screen
    var width = UIScreen.main.bounds.width
    // selected index slide
    @State private var selectedIndex:Int = 0
    var body: some View {
        VStack {
            // images slider and favourite icon
            ZStack (alignment: .top){
                // images slides
                TabView (selection: $selectedIndex){
                    ForEach(booking.placeImages.indices, id: \.self) { index in
                        KFImage(URL(string: booking.placeImages[index]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .tag(booking.placeImages[index])
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                // indicator dot
                VStack {
                    Spacer()
                    HStack {
                        ForEach(0..<booking.placeImages.count, id: \.self) { index in
                            Circle()
                                .fill(index == selectedIndex ? .white: .gray)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 20)
                }
                // favourite icon
                HStack {
                    Button {
                        
                    }label: {
                        Text("Guest favourite")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .foregroundStyle(.black)
                            .clipShape(Capsule())
                    }
                    Spacer()
                    Image(systemName: booking.isFavourite ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(booking.isFavourite ? Color.vendoredAirbnbVendoredAirbnbPrimary : .black)
                }
                .padding()
            }
            // content info
            VStack (spacing:0){
                HStack {
                    Text(booking.name)
                        .font(.headline)
                    Spacer()
                    HStack (spacing:6){
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                        Text(booking.rating)
                            .font(.headline)
                            .fontWeight(.regular)
                    }
                }
                Text(booking.mileAway)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(booking.date)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(booking.price)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.black)
        }
    }
}
