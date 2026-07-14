//
//  DetailView.swift
//  youtube_airbnb_clone
//
//  Created by Sopheamen VAN on 29/1/25.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var booking:BookingResponse
    // scroll animation header
    @State private var scrollOffset: CGFloat = 0
    var headerHeight: CGFloat = 350
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                // content
                ZStack (alignment: .top){
                    // content scrollable
                    ScrollView {
                        VStack (spacing:20){
                            // image scrollable
                            ImagesScrollableView(headerHeight: headerHeight, scrollOffset: $scrollOffset, booking: booking)
                            // content info
                            ContentInfoDetailView(booking: booking)
                        }
                    }
                    // header scrollable content
                    HeaderScrollableView(headerHeight: headerHeight, scrollOffset: $scrollOffset, booking: booking)
                }
                .padding(.bottom, 100)
                // fixed floating footer button
                FloatingButtonView(booking: booking)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    DetailView(booking: bookingsData[0])
}

struct HeaderScrollableView:View {
   
    var headerHeight:CGFloat
    @Binding var scrollOffset:CGFloat
    var booking:BookingResponse
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(height: scrollOffset > headerHeight / 2 ? 120 : 80)
            .opacity(scrollOffset > headerHeight / 2 ? 1 : 0)
            .overlay(
                HStack {
                    Button {
                        dismiss()
                    }label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 36, height: 36)
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 8, height: 8)
                                .foregroundStyle(.black)
                        }
                    }
                    Spacer()
                    HStack (spacing:14){
                        Button {
                           
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 36, height: 36)
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(.black)
                            }
                        }
                        Button {
                           
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 36, height: 36)
                                Image(systemName: booking.isFavourite ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle( booking.isFavourite ? Color.primaryColor : .black)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            )
            .offset(y: scrollOffset > headerHeight / 2 ? 0 : -80)
            .animation(.easeInOut, value: scrollOffset)
            
        
    }
}

struct ImagesScrollableView:View {
    var headerHeight:CGFloat
    @Binding var scrollOffset:CGFloat
    var booking:BookingResponse
    var body: some View {
        GeometryReader { geo in
            let offset = geo.frame(in: .global).minY
            ImagesSlideView(booking: booking)
                .frame(height: headerHeight)
                .clipped()
                .offset(y: offset > 0 ? -offset : 0)
                .opacity(offset > -headerHeight ? 1 : 0)
                .onChange(of: offset) { _,newValue in
                    scrollOffset = -newValue
                }
        }
        .frame(height: headerHeight)
    }
}

struct ImagesSlideView:View {
    var booking:BookingResponse
    // width screen
    var width = UIScreen.main.bounds.width
    // selected index slide
    @State private var selectedIndex:Int = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            // images
            TabView (selection: $selectedIndex){
                ForEach(booking.placeImages.indices, id: \.self) { index in
                    KFImage(URL(string: booking.placeImages[index]))
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: 350)
                        .tag(booking.placeImages[index])
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 350)
            
            // icons
            VStack {
                HStack {
                    Button {
                        dismiss()
                    }label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 36, height: 36)
                            Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 8, height: 8)
                                .foregroundStyle(.black)
                        }
                    }
                    Spacer()
                    HStack (spacing:14){
                        Button {
                           
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 36, height: 36)
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(.black)
                            }
                        }
                        Button {
                           
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 36, height: 36)
                                Image(systemName: booking.isFavourite ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle( booking.isFavourite ? Color.primaryColor : .black)
                            }
                        }
                    }
                }
                Spacer()
                // indicator
                Text("\(selectedIndex+1)/\(booking.placeImages.count)")
                    .padding(.vertical, 2)
                    .padding(.horizontal, 12)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 50)
            .padding(.bottom)
            .padding(.horizontal)
        }
    }
}

struct ContentInfoDetailView:View {
    var booking:BookingResponse
    var body: some View {
        VStack (spacing:20){
            // description
            DescriptionView(booking: booking)
            // rating and total rating
            RatingAndTotalRatingView(booking: booking)
            // host by
            HostByView(booking: booking)
            // host list
            HostListView()
//             sleep list
            Divider()
            SleepListView()
            Divider()
//             what offers
            OfferView()
            // review list
            ReviewList(booking: booking)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct DescriptionView:View {
    var booking:BookingResponse
    var body: some View {
        VStack (spacing:12){
            Text(booking.description)
                .font(.title2)
                .fontWeight(.semibold)
            VStack (alignment: .leading, spacing: 0){
                Text("Entire cabin in \(booking.name)")
                    .font(.headline)
                Text(booking.capacity)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct RatingAndTotalRatingView:View {
    var booking:BookingResponse
    var body: some View {
        HStack {
            VStack (spacing:2){
                Text(booking.rating)
                    .font(.headline)
                HStack (spacing:2){
                    ForEach(1...5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                    }
                }
            }
            Spacer()
            Rectangle()
                .fill(.black.opacity(0.2))
                .frame(width: 1, height: 30)
            Spacer()
            VStack (spacing:-5){
                Text("Guest")
                Text("favourite")
            }
            .font(.headline)
            Spacer()
            Rectangle()
                .fill(.black.opacity(0.2))
                .frame(width: 1, height: 30)
            Spacer()
            VStack (spacing:-5){
                Text(booking.totalRating)
                    .font(.headline)
                Text("Reviews")
                    .font(.caption2)
                    .underline(true)
                
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical,12)
        .padding(.horizontal, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(.black.opacity(0.2))
        )
    }
}

struct HostByView:View {
    var booking:BookingResponse
    var body: some View {
        VStack (spacing:16){
            HStack (spacing:20){
                KFImage(URL(string: detailRecord.hostImgUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 0){
                    Text("Hosted by \(detailRecord.hostBy)")
                        .font(.headline)
                    Text("Superhost - \(detailRecord.hostAgo)")
                        .font(.subheadline)
                }
                Spacer()
            }
            Divider()
        }
    }
}

struct HostListView:View {
    var hostLists:[HostListResponse] = detailRecord.hostList
    var body: some View {
        VStack (spacing:20){
            ForEach(hostLists) { host in
                HStack (alignment: .top, spacing: 20){
                    Image(host.icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 26, height: 26)
                        .padding(.top, 4)
                    VStack (alignment: .leading, spacing: 0){
                        Text(host.name)
                            .font(.headline)
                        Text(host.description)
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct SleepListView:View {
    var bedRoomDetails:[SleepListResponse] = detailRecord.bedRoomDetail
    var body: some View {
        VStack (spacing:14){
            Text("Where you'll sleep")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack (spacing:12){
                ForEach(bedRoomDetails) { detail in
                    VStack (alignment: .leading){
                        KFImage(URL(string: detail.imgUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: .infinity, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text(detail.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.leading, 10)
                        Text(detail.description)
                            .font(.subheadline)
                            .padding(.leading, 10)
                    }
                }
            }
        }
    }
}

struct OfferView:View {
    var placeOfferLists:[PlaceOfferResponse] = detailRecord.placeOfferList
    var body: some View {
        VStack (spacing:14){
            Text("What this place offers")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack (spacing:24){
                ForEach(placeOfferLists) { place in
                    HStack (spacing:20){
                        Image(place.icon)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 26, height: 26)
                            .padding(.top, 4)
                        Text(place.name)
                            .font(.headline)
                            .fontWeight(.regular)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ReviewList:View {
    var reviewLists:[ReviewListResponse] = detailRecord.reviewList
    var booking:BookingResponse
    var body: some View {
        VStack {
            // list scrollable
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:20){
                    ForEach(reviewLists) { review in
                        ReviewRowList(review: review)
                    }
                }
            }
            // button total review
            Button {
                
            }label: {
                Text("Show all \(booking.totalRating) reviews")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.black.opacity(0.6)))
            }
        }
    }
}

struct ReviewRowList:View {
    var review:ReviewListResponse
    var body: some View {
        VStack {
            HStack {
                HStack (spacing:2){
                    ForEach(1...5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10, height: 10)
                    }
                }
                Text(review.dateAgo)
                    .font(.caption2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(review.description)
                .font(.subheadline)
                .lineLimit(4)
            Text("Show more")
                .font(.subheadline)
                .fontWeight(.semibold)
                .underline(true)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack (spacing:20){
                KFImage(URL(string: review.profileUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 0){
                    Text(review.name)
                        .font(.headline)
                    Text("5 years on Airbnb")
                        .font(.subheadline)
                }
                Spacer()
            }
        }
        .padding()
        .frame(width: 300)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.2), lineWidth: 1)
        )
    }
}

struct FloatingButtonView:View {
    var booking:BookingResponse
    var body: some View {
        HStack {
            Text(booking.price)
                .font(.title3)
                .fontWeight(.semibold)
                .underline(true)
                .foregroundStyle(.black.opacity(0.8))
            Spacer()
            Button {
                
            }label: {
                Text("Reserve")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .foregroundStyle(.white)
                    .background(Color.primaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity)
        .frame(height: 90)
        .overlay(
            RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.5))
        )
    }
}

