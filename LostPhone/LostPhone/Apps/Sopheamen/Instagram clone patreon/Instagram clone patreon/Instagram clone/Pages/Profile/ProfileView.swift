//
//  ProfileView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 18/3/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var presentSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    // header profile view
                    HStack {
                     
                        ProfileViewAndStory()
                        
                        Spacer()
                        
                        // posts, followers, following
                        HStack {
                            CustomLikesFollowersFollowing(title: "Posts", numberCount: userDataCurrent.totalPosts)
                            CustomLikesFollowersFollowing(title: "Followers", numberCount: 10 )
                            CustomLikesFollowersFollowing(title: "Following", numberCount: 2301)
                        }
                    
                    }
                    .padding(.horizontal)
                    
                    // name and bio
                    NameAndBioView()
                        .padding(.horizontal)
                   
                    // button edit profile, share profile and add more people
                    EditShareAndAddNewPeopleButtonView()
                        .padding(.horizontal)
                    
                    // story highlight
                    AddStoryView()
                        .padding(.horizontal)
                    
                    // show tab photos, videos, and tag of you
                    PhotosVideoTagOfYouView()
                       
                    
                    
                }
                
            }
            .toolbar {
//                ToolbarItem (placement: .topBarLeading) {
//                    HStack {
//                        Text(userDataCurrent.username)
//                            .font(.title)
//                            .fontWeight(.semibold)
//                        Image(systemName: "chevron.down")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 8,height: 8)
//                            .padding(.top,4)
//                            .fontWeight(.semibold)
//                    }
//                }
//                ToolbarItem (placement: .topBarTrailing) {
//                    HStack (spacing: 14){
//                        Button {
//                            
//                        } label: {
//                           Image(systemName: "plus.app")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 22,height: 22)
//                                .foregroundStyle(.black)
//                        }
//                        Button {
//                            presentSheet = true
//                        } label: {
//                           Image("list_icon")
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 28,height: 28)
//                                .foregroundStyle(.black)
//                        }
//                    }
//                    
//                }
            }
            .sheet(isPresented: $presentSheet){
                ProfileSettingView()
                    .presentationDetents([.height(600), .large])
            }
            .padding(.top,12)
            
            
        }
    }
}


#Preview {
    ProfileView()
}

// profile view
struct ProfileViewAndStory: View {
    
    var body: some View {
        ZStack {
            ProfileImageView(profileImage: userDataCurrent.profileImage, size: 100)
            Button {
                
            }label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 28,height: 28)
                    .background(.white)
                    .clipShape(Circle())
                    .foregroundStyle(Color.primaryColor)
                    .overlay(Circle().stroke(.white, lineWidth: 4))
            }
            .offset(x: 35,y: 35)
                
            
        }
        .frame(width: 100,height: 100)
    }
}

// posts, followers and followings
struct CustomLikesFollowersFollowing: View {
    let title: String
    let numberCount: Int
    var body: some View {
        VStack {
            Text("\(numberCount)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(height: 16)
            Text(title)
                .font(.subheadline)
                .frame(height: 8)
        }
        .frame(width: 75)
    }
}

// edit button, share button, and add new people button
struct EditShareAndAddNewPeopleButtonView: View {
    
    let size = (UIScreen.main.bounds.width / 2)
    
    var body: some View {
        HStack {
            NavigationLink(destination: EditProfileView().hideTabBar()) {
                ButtonGrayView(title: "Edit Profile")
                    .frame(maxWidth: size)
            }
            Spacer()
            ButtonGrayView(title: "Share profile")
                .frame(maxWidth: size)
            Button {
                
            }label: {
                Image("add_contact_icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 18,height:18)
                    .foregroundStyle(.black)
                    .padding(.horizontal,12)
                    .padding(.vertical,8)
                
            }
            .background(Color.textFieldBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

// name and bio view
struct NameAndBioView: View {
    var body: some View {
        // name and bio
        VStack (alignment: .leading) {
            Text("Danel' Dauletzhan")
                .font(.headline)
                .fontWeight(.semibold)
                .frame(height: 16)
            Text("@theddanel")
                .font(.subheadline)
                .frame(height: 14)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
    }
}

// add story view
struct AddStoryView: View {
    let storiesData:[UserStoryResponse] = userStoriesData
    var body: some View {
        VStack {
            // title and sub title
            VStack (alignment: .leading,spacing: 0) {
                Text("Story highlights")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                   
                Text("Keep your favourite stories on your profile")
                    .frame(maxWidth: .infinity, alignment: .leading)
                   
            }
            .font(.subheadline)
            .padding(.bottom,12)
            // story view
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 18){
                    // add story button view
                    Button {
                        
                    }label: {
                        VStack (spacing: 5){
                            ZStack {
                                Circle()
                                    .fill(.clear)
                                    .frame(width: 65,height: 65)
                                    .overlay(Circle().stroke(Color.textFieldBackgroundColor, lineWidth: 1.5))
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 23,height: 23)
                                
                            }
                            Text("New")
                                .font(.subheadline)
                        }
                    }
                    .foregroundStyle(.black)
                    
                    // get all stories view
                    LazyHStack (spacing: 18){
                        ForEach(storiesData) { item in
                            VStack (spacing: 5){
                                ProfileImageView(profileImage: item.imageUrl, size: 65)
                                Text(item.caption)
                                    .font(.subheadline)
                                    .frame(width: 65)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
               
            }
            }
    }
}
struct PhotosVideoTagOfYouView: View {
    let icons = ["grid_icon", "reels_icon", "tag_icon"]
    @State private var selectedTab = 0
    @Namespace private var underlineNamespace
    
    let width = (UIScreen.main.bounds.width / 3)
    
    var body: some View {
        // custom tab view
        VStack (spacing: 0){
            HStack {
                ForEach(0..<icons.count, id: \.self) { index in
                    Button(action: {
                        withAnimation {
                            selectedTab = index
                        }
                    }) {

                        VStack (spacing: 10){
                            Image(icons[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22,height: 22)
                               
                            
                            if selectedTab == index {
                                Rectangle()
                                    .fill(.black)
                                    .frame(height: 1.5)
                                    .matchedGeometryEffect(id: "tabIndicator", in: underlineNamespace)
                            }
                        }
                        
                        
                            
                    }
                    .frame(width: width)
                }
               
            }
            .frame(height: 40, alignment: .leading)
           
           // get content
           getContentTab(value: selectedTab)
        }
    }
    
    @ViewBuilder
    func getContentTab(value: Int) -> some View {
        switch value {
        case 0:
            PostGridPhotoView()
        case 1:
            PostGridVideoView()
        case 2:
            ContactView()
        default:
            EmptyView()
        }
    }
}

struct ContactView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("contact_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .padding(.all, 20)
                .overlay(Circle().stroke(.black, lineWidth: 2))

            Text("Photos and videos of you")
                .font(.title3)
                .fontWeight(.semibold)
            Text("When people tag you in photos and videos")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.gray)
            Spacer()
        }

        .frame(height: 200)
        .frame(maxWidth: .infinity)
        
    }
}



