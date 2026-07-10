//
//  VendoredFacebookHomeView.swift
//  Youtube_Facebook
//
//  Created by Sopheamen VAN on 23/10/24.
//

import SwiftUI
// load image lib cache
import Kingfisher

struct VendoredFacebookHomeView: View {
    // set header to background white
    init() {
       // Set the background color of the navigation bar
       let appearance = UINavigationBarAppearance()
       appearance.configureWithOpaqueBackground()
       appearance.backgroundColor = .white

       UINavigationBar.appearance().standardAppearance = appearance
       UINavigationBar.appearance().scrollEdgeAppearance = appearance
   }
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack (spacing:8){
                    // profile what is on your mind
                    VendoredFacebookProfileWhatIsOnYourMindView()
//                    // story view
                    VendoredFacebookStoryView()
                    // feed view
                    VendoredFacebookFeedView()
                }
            }
            .background(Color.vendoredFacebookBackgroundColor)
            // logo and icons
            .toolbar {
                // logo
                ToolbarItem (placement: .topBarLeading){
                    Text("facebook")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.vendoredFacebookVendoredFacebookPrimary)
                }
                // icons
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 0){
                        // plus
                        Button {
                            
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(Color.vendoredFacebookGrayBackgroundColor)
                                    .frame(width: 35, height: 35)
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 17, height: 17)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                        }
                        // search
                        Button {
                            
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(Color.vendoredFacebookGrayBackgroundColor)
                                    .frame(width: 35, height: 35)
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 19, height: 19)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                        }
                        // messenger
                        Button {
                            
                        }label: {
                            ZStack {
                                Circle()
                                    .fill(Color.vendoredFacebookGrayBackgroundColor)
                                    .frame(width: 35, height: 35)
                                Image("messenger")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 19, height: 19)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    VendoredFacebookHomeView()
}

struct VendoredFacebookProfileWhatIsOnYourMindView:View {
    var body: some View {
        HStack {
            KFImage(URL(string: "https://images.unsplash.com/photo-1499996860823-5214fcc65f8f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGUlMjBtYWxlfGVufDB8fDB8fHww"))
                .resizable()
                .scaledToFill()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
            Text("What's on your mind?")
                .font(.headline)
                .fontWeight(.regular)
            Spacer()
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 22)
                .foregroundStyle(Color.vendoredFacebookSuccessColor)
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .background(.white)
    }
}

struct VendoredFacebookStoryView:View {
    var stories:[VendoredFacebookStoryResponse] = vendoredFacebookStoryData
    var body: some View {
        VStack (spacing:12){
            // tab story, reels
            VendoredFacebookTabStoryReelsView()
            // list
            ScrollView (.horizontal, showsIndicators: false){
                LazyHStack (spacing:10){
                    ForEach(stories) { story in
                        VendoredFacebookStoryRowView(story: story)
                    }
                }
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(.white)
    }
}

struct VendoredFacebookTabStoryReelsView:View {
    @State private var selectedIndex = "Stories"
    var tabs = ["Stories", "Reels"]
    @Namespace private var underlineAnimation
    var body: some View {
        HStack {
            ForEach(tabs, id:\.self){ tab in
                Button {
                    withAnimation {
                        selectedIndex = tab
                    }
                }label: {
                    VStack (spacing:8){
                        Text(tab)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(selectedIndex == tab ? Color.vendoredFacebookVendoredFacebookPrimary : .black.opacity(0.8))
                        if selectedIndex == tab {
                            Rectangle()
                                .frame(height:2)
                                .foregroundStyle(Color.vendoredFacebookVendoredFacebookPrimary)
                                .matchedGeometryEffect(id: "underline", in: underlineAnimation)
                        } else {
                            Rectangle()
                                .frame(height:2)
                                .foregroundStyle(.clear)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
        }
    }
}

struct VendoredFacebookStoryRowView:View {
    var story: VendoredFacebookStoryResponse
    var body: some View {
        ZStack (alignment: .topLeading){
            // image
            KFImage(URL(string: story.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            // profile and online circle
            ZStack (alignment: .bottomTrailing){
                KFImage(URL(string: story.user.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 42, height: 42)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.5)))
                    .padding(.all, 10)
                if story.user.isOnline {
                    Circle()
                        .fill(Color.vendoredFacebookSuccessColor)
                        .frame(width: 12, height: 12)
                        .overlay(Circle().stroke(.white))
                        .offset(x: -10, y: -10)
                }
            }
        }
    }
}

struct VendoredFacebookFeedView:View {
    var feeds:[VendoredFacebookFeedResponse] = feedData
    var body: some View {
        LazyVStack {
            ForEach(feeds.indices, id:\.self) { index in
                switch feeds[index].type {
                case 1:
                    VendoredFacebookNewsFeedView(feed: feeds[index], index: index)
                case 2:
                    VendoredFacebookPhotoFeedView(feed: feeds[index])
                default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}

struct VendoredFacebookNewsFeedView:View {
    var feed: VendoredFacebookFeedResponse
    var index: Int
    var body: some View {
        VStack (spacing:8){
            // profile and name
            HStack (spacing:10){
                // profile
                KFImage(URL(string: feed.companyProfileUrl!))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 42, height: 42)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.white.opacity(0.5)))
                
                // name and date ago
                VStack(alignment: .leading, spacing: 0) {
                    Text(feed.newsCompany ?? "")
                        .font(.headline)
                        .fontWeight(.semibold)
                    HStack (spacing:4){
                        Text("\(feed.dateAgo) -")
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.7))
                        Image(systemName: "globe.americas.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
                Spacer()
                // icons
                HStack (spacing:30){
                    // option
                    Button {
                        
                    }label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 4, height: 4)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    // close
                    Button {
                        
                    }label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
            }
  
            .padding(.top, index == 0 ? 10: 0)
            .padding(.horizontal)
            // caption
            Text(feed.caption ?? "")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .lineSpacing(-5)
                .padding(.horizontal)
            // image
            KFImage(URL(string: feed.imageUrls[0]))
                .resizable()
                .scaledToFill()
                .frame(height: 210)
                .clipped()
            // company name
            // title
            VStack (alignment: .leading, spacing: 0){
                Text(feed.newsCompany ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.6))
                Text(feed.newsTitle ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
            }
            .padding(.top, 10)
            .padding(.bottom, 12)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.vendoredFacebookNewsBackgroundColor)
            .overlay(RoundedRectangle(cornerRadius: 0).stroke(.gray.opacity(0.2)))
            .padding(.top, -8)
            // total likes, comments, shares
            HStack {
                // like and emoji
                HStack (spacing:0){
                    // likes
                    ZStack {
                        Circle()
                            .fill(Color.vendoredFacebookVendoredFacebookPrimary)
                            .frame(width: 24, height: 24)
                            .overlay(Circle().stroke(.white))
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .offset(x:4)
                    .zIndex(1)
                    // heart
                    ZStack {
                        Circle()
                            .fill(Color.vendoredFacebookDangerColor)
                            .frame(width: 24, height: 24)
                            .overlay(Circle().stroke(.white))
                        Image(systemName: "heart.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    Text("\(feed.totalLikes)K")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                        .padding(.leading, 8)
                }
                Spacer()
                // total comments and shares
                HStack {
                    Text("\(feed.totalComments)K comments")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                    Text("\(feed.totalShares)K shares")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            Divider()
                .background(.gray.opacity(0.2))
            // like, comment, share action button
            HStack {
                // like button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Like")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                Spacer()
                // comment button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Comments")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                Spacer()
                // send button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Send")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                Spacer()
                // share button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Share")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            
            // divider
            Rectangle()
                .fill(Color.vendoredFacebookBackgroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 8)
        }
    }
}

struct VendoredFacebookPhotoFeedView:View {
    var feed: VendoredFacebookFeedResponse
    
    var body: some View {
        VStack (spacing:8){
            // profile and name
            HStack (spacing:10){
                // profile
                ZStack (alignment: .topLeading){
                  
                    // profile and online circle
                    ZStack (alignment: .bottomTrailing){
                        KFImage(URL(string: feed.user.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 42, height: 42)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white.opacity(0.5)))
                            
                        if feed.user.isOnline {
                            Circle()
                                .fill(Color.vendoredFacebookSuccessColor)
                                .frame(width: 12, height: 12)
                                .overlay(Circle().stroke(.white))
                                .offset(x: 0, y: 0)
                        }
                    }
                }
                
                // name and date ago
                VStack(alignment: .leading, spacing: 0) {
                    Text(feed.user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    HStack (spacing:4){
                        Text("\(feed.dateAgo) -")
                            .font(.subheadline)
                            .foregroundStyle(.black.opacity(0.7))
                        Image(systemName: "globe.americas.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
                Spacer()
                // icons
                HStack (spacing:30){
                    // option
                    Button {
                        
                    }label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 4, height: 4)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                    // close
                    Button {
                        
                    }label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.7))
                    }
                }
            }
  
            
            .padding(.horizontal)
            // caption
            Text(feed.caption ?? "")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .lineSpacing(-5)
                .padding(.horizontal)
            // image
//            KFImage(URL(string: feed.imageUrls[0]))
//                .resizable()
//                .scaledToFill()
//                .frame(height: 210)
//                .clipped()
            if feed.imageUrls.count == 1 {
                KFImage(URL(string: feed.imageUrls[0]))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
            } else if feed.imageUrls.count == 2 {
                HStack {
                    KFImage(URL(string: feed.imageUrls[0]))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width / 2 - 14,height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    Spacer()
                    KFImage(URL(string: feed.imageUrls[1]))
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width / 2 - 14 ,height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 10)
            } else {
                VStack {
                    HStack {
                        KFImage(URL(string: feed.imageUrls[0]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 2 - 14,height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        Spacer()
                        KFImage(URL(string: feed.imageUrls[1]))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width / 2 - 14 ,height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    KFImage(URL(string: feed.imageUrls[2]))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 10)
            }
           
            // total likes, comments, shares
            HStack {
                // like and emoji
                HStack (spacing:0){
                    // likes
                    ZStack {
                        Circle()
                            .fill(Color.vendoredFacebookVendoredFacebookPrimary)
                            .frame(width: 24, height: 24)
                            .overlay(Circle().stroke(.white))
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    .offset(x:4)
                    .zIndex(1)
                    // heart
                    ZStack {
                        Circle()
                            .fill(Color.vendoredFacebookDangerColor)
                            .frame(width: 24, height: 24)
                            .overlay(Circle().stroke(.white))
                        Image(systemName: "heart.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                    Text("\(feed.totalLikes)K")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                        .padding(.leading, 8)
                }
                Spacer()
                // total comments and shares
                HStack {
                    Text("\(feed.totalComments)K comments")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                    Text("\(feed.totalShares)K shares")
                        .font(.subheadline)
                        .foregroundStyle(.black.opacity(0.7))
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            Divider()
                .background(.gray.opacity(0.2))
            // like, comment, share action button
            HStack {
                // like button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Like")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                Spacer()
                // comment button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "bubble.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Comments")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                Spacer()
                // send button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "paperplane")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Send")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
                Spacer()
                // share button
                Button {
                    
                }label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                        Text("Share")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                }
                .foregroundStyle(.black.opacity(0.8))
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            
            // divider
            Rectangle()
                .fill(Color.vendoredFacebookBackgroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: 8)
        }
    }
}




