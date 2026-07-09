//
//  HomeView.swift
//  Youtube_uber_clone
//
//  Created by Sopheamen VAN on 17/11/24.
//

import SwiftUI
// load lib for image network cache
import Kingfisher

struct HomeView: View {
    var tabs:[TabResponse] = tabData
    @State private var selectedIndex = 1
    // for smooth animation
    @Namespace private var animation
    // width 50%
    var width = UIScreen.main.bounds.width / 2
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // content
                VStack {
                    if selectedIndex == 0 {
                        // rides
                        VStack (spacing:10){
                            // search
                            SearchRidesView()
                            // history
                            RidesHistoryView()
                            // suggestion
                            SuggestionView()
                            // ads
                            AdsView()
                        }
                    } else {
                        // uber eats
                        VStack (spacing:20){
                            // delivery
                            DeliveryView()
                            // search
                            SearchUberEatsView()
                            // category
                            CategoryView()
                            // featured
                            FeaturedRestaurantView()
                            Divider()
                            // place you might like
                            PlaceYouMightLikeView()
                        }
                    }
                }
                .padding(.vertical, 16)
            }
            // title and tabs
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // tabs
                ToolbarItem (placement: .principal){
                    HStack (spacing:0){
                        ForEach(tabs.indices, id: \.self) { index in
                            Button {
                                withAnimation {
                                    selectedIndex = index
                                }
                            }label: {
                                VStack (spacing:6){
                                    // icon and text
                                    HStack (spacing:12){
                                        Image(tabs[index].imageUrl)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 38, height: 38)
                                        
                                        Text(tabs[index].title)
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.black)
                                    }
                                    // border line full width and border underline animation
                                    ZStack {
                                        Rectangle()
                                            .fill(.gray.opacity(0.4))
                                            .frame(width: width, height: 3)
                                        if selectedIndex == index {
                                            Rectangle()
                                                .fill(.black)
                                                .frame(width: width, height: 3)
                                                .matchedGeometryEffect(id: "underline", in: animation)
                                        }
                                    }
                                }
                            }
                            .frame(width: width)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

struct SearchRidesView:View {
    var body: some View {
        HStack (spacing:12){
            // icon
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 22)
            // textfield
            TextField("Where to?", text: .constant(""))
                .font(.headline)
            Spacer()
            // button
            HStack (spacing:10){
                Image(systemName: "clock.fill")
                    .foregroundStyle(.black)
                Text("Now")
                    .font(.headline)
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 6, height: 6)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                    .padding(.top, 2)
            }
            .frame(width: 110)
            .frame(height: 40)
            .background(Color.whiteColor)
            .clipShape(Capsule())
        }
        .padding(.vertical, 10)
        .padding(.leading)
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(Color.textFieldColor)
        .clipShape(Capsule())
        .padding(.horizontal)
    }
}

struct RidesHistoryView:View {
    // load history data
    var historyDatas:[RidesHistoryResponse] = ridesHistoryData
    var body: some View {
        LazyVStack (spacing:12){
            ForEach(historyDatas) { history in
                RidesHistoryRowView(history: history)
            }
        }
    }
}

struct RidesHistoryRowView:View {
    var history:RidesHistoryResponse
    var body: some View {
        HStack (spacing:20){
            Image(systemName: "clock.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
            // content
            VStack (alignment: .leading, spacing: 0){
                Text(history.location)
                    .font(.headline)
                Text(history.streetName)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.7))
                Divider()
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

struct SuggestionView:View {
    // load suggestion items
    var suggestionDatas:[RidesSuggestionResponse] = ridesSuggestionsData
    
    var body: some View {
        VStack {
            // title and see all
            HStack {
                Text("Suggestion")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Text("See all")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            // list item
            HStack {
                ForEach(suggestionDatas) { suggestion in
                    SuggestionRowView(suggestion: suggestion)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
    }
}

struct SuggestionRowView:View {
    var suggestion: RidesSuggestionResponse
    // get width screen as 4 items
    var size = (UIScreen.main.bounds.width / 4) - 14
    var body: some View {
        Button {
            
        }label: {
            ZStack (alignment: .top){
                // item
                VStack {
                    Image(suggestion.imageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 40)
                    
                    Text(suggestion.name)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        
                }
                .frame(width: size, height: size + 8)
                .background(Color.cardColor)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // badge
                if suggestion.isPromoted {
                    Text("Promo")
                        .font(.footnote)
                        .foregroundStyle(Color.whiteColor)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 6)
                        .background(Color.primaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .offset(x: 0, y: -20)
                        
                }
            }
        }
    }
}

struct AdsView:View {
    // load ads item
    var adsData:[RidesAdsResponse] = ridesAdsData
    // get width
    var width = UIScreen.main.bounds.width
    var body: some View {
        // adds scrollable content
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack (spacing:12){
                ForEach(adsData) { ads in
                    Image(ads.imageUrl)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width - 50, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct DeliveryView:View {
    var location:RidesHistoryResponse = ridesHistoryData[0]
    
    var body: some View {
        HStack {
            // deliver now
            HStack {
                VStack (alignment: .leading, spacing: 0){
                    Text("Deliver now")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                    Text("\(location.streetName)...")
                        .font(.subheadline)
                }
                .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.down")
                    .fontWeight(.semibold)
            }
            .frame(width: 160)
            Spacer()
            // dlievery button and cart icon
            HStack (spacing:20){
                // button
                Button {
                    
                }label: {
                    HStack (spacing:14){
                        Text("Delivery")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 7, height: 7)
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                            .padding(.top, 2)
                        
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 40)
                    .background(Color.cardColor)
                    .clipShape(Capsule())
                }
                
                Button {
                    
                }label: {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.black)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchUberEatsView:View {
    var body: some View {
        HStack (spacing:12){
            // icon
            Image(systemName: "magnifyingglass")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 22)
            // textfield
            TextField("Search UbeaEats", text: .constant(""))
                .font(.headline)
            
        }
        .padding(.vertical, 10)
        .padding(.leading)
        .padding(.trailing, 10)
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(Color.textFieldColor)
        .clipShape(Capsule())
        .padding(.horizontal)
    }
}

struct CategoryView:View {
    // load category items
    var categoryDatas:[EatsCategoryResponse] = eatsCategoriesData
    var body: some View {
        VStack (spacing: 16){
            // category list also scrollable content
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:20){
                    ForEach(categoryDatas) { category in
                        Button {
                            // action
                        }label: {
                            // layout
                            VStack (spacing:10){
                                // image
                                KFImage(URL(string: category.imageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                
                                // text
                                Text(category.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                    .lineLimit(1)
                            }
                            .frame(width: 70)
                        }
                    }
                }
                .padding(.horizontal)
            }
            // service list
            ScrollView (.horizontal, showsIndicators: false){
                HStack (spacing:14){
                    // offer
                    Button {
                        // action
                    }label: {
                        // layout
                        HStack (spacing:10){
                            // icon
                            Image(systemName: "tag")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                                .padding(.top, 2)
                            // text
                            Text("Offers")
                              
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 40)
                        .background(Color.cardColor)
                        .clipShape(Capsule())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    }
                    // delivery fee
                    Button {
                        // action
                    }label: {
                        // layout
                        HStack (spacing:10){
                           
                            // text
                            Text("Delivery Fee")
                            // icon
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 7, height: 7)
                                .padding(.top, 2)
                              
                        }
                        .padding(.horizontal, 16)
                        .frame(height: 40)
                        .background(Color.cardColor)
                        .clipShape(Capsule())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    }
                    // under 30min
                    Button {
                        // action
                    }label: {
                        // layout
                        Text("Under 30 min")
                            .padding(.horizontal, 16)
                            .frame(height: 40)
                            .background(Color.cardColor)
                            .clipShape(Capsule())
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct FeaturedRestaurantView:View {
    // load featured item
    var restaurantDatas:[EatsRestaurantResponse] = eatsRestaurantsFeaturedData
    
    var body: some View {
        VStack (spacing:12){
            // title and action button
            HStack {
                Text("Featured on UberEats")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                // button
                Button {
                    // action
                }label: {
                    // layout
                    ZStack {
                        Circle()
                            .fill(Color.cardColor)
                            .frame(width: 38, height: 38)
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(.horizontal)
            
            // list items and scrollable content
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:12){
                    ForEach(restaurantDatas) { restaurant in
                        RestraurantView(restaurant: restaurant)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RestraurantView:View {
    var restaurant:EatsRestaurantResponse
    // get screen width
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack (spacing:12){
            // image and badge content and favourite
            ZStack (alignment: .top){
                KFImage(URL(string: restaurant.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width - 50, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // badge
                HStack {
                    if restaurant.isOffer {
                        Text("Offers available")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.whiteColor)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .background(Color.primaryColor)
                    }
                    Spacer()
                    
                    Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(restaurant.isFavorite ? Color.primaryColor : Color.whiteColor)
                }
                .padding(.vertical)
                .padding(.trailing)
            }
            // content info
            VStack (spacing:0){
                // name and rating
                HStack (alignment: .top){
                    Text(restaurant.name)
                        .font(.headline)
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(Color.cardColor)
                            .frame(width: 34, height: 34)
                        Text(restaurant.totalRate)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                // delivery fee and duration
                HStack {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18, height: 18)
                    Text("\(restaurant.deliveryFee) Delivery Fee - ")
                        .fontWeight(.semibold)
                    Text(restaurant.duration)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
            }
            .padding(.horizontal, 8)
        }
    }
}

struct PlaceYouMightLikeView:View {
    // load featured item
    var restaurantDatas:[EatsRestaurantResponse] = placesYouMightLikeData
    
    var body: some View {
        VStack (spacing:12){
            // title and action button
            HStack {
                Text("Places you might like")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                // button
                Button {
                    // action
                }label: {
                    // layout
                    ZStack {
                        Circle()
                            .fill(Color.cardColor)
                            .frame(width: 38, height: 38)
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(.horizontal)
            
            // list items and scrollable content
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:12){
                    ForEach(restaurantDatas) { restaurant in
                        RestraurantView(restaurant: restaurant)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

