//
//  VendoredSnapchatMapView.swift
//  Snapchat Clone
//
//  Created by Sopheamen VAN on 18/5/24.
//

import SwiftUI
import MapKit
import Kingfisher

struct VendoredSnapchatMapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    private let mapFriends: [VendoredSnapMapFriend] = [
        VendoredSnapMapFriend(image: "default_user", coordinate: CLLocationCoordinate2D(latitude: 37.776, longitude: -122.418)),
        VendoredSnapMapFriend(image: "default_user", coordinate: CLLocationCoordinate2D(latitude: 37.773, longitude: -122.421))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // add map view
                Map(coordinateRegion: $region, annotationItems: mapFriends) { friend in
                    MapAnnotation(coordinate: friend.coordinate) {
                        Image(friend.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                // add icons and options
                VStack {
                    VendoredSnapchatProfileMapAndOptionIconsView()
                    Spacer()
                    VendoredSnapchatEmojiView()
                    Spacer()
                    VendoredSnapchatMyBitmojiPlaceFriendView()
                    
                    
                }
                .padding(.horizontal)
                .padding(.bottom,30)
            }
            .navigationBarTitleDisplayMode(.inline)
           
           
            
            
        }
    }
}

#Preview {
    VendoredSnapchatMapView()
}

struct VendoredSnapMapFriend: Identifiable {
    let id = UUID()
    let image: String
    let coordinate: CLLocationCoordinate2D
}

struct VendoredSnapchatProfileMapAndOptionIconsView: View {
    var body: some View {
        HStack (alignment: .top){
            HStack {
                VendoredSnapchatProfileImageView(profileImage: vendoredSnapchatUserDataCurrent.profileImage, size: 35)
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 2)
                VendoredSnapchatIconButtonOpacity(iconName: "magnifyingglass")
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 2)
                HStack (spacing:20){
                    
                    KFImage(URL(string: "https://images.unsplash.com/photo-1716903778207-445ce0f12820?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28,height:28)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.yellow,lineWidth: 3))
                    
                   
                    Text("Detriot")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .padding(.leading,8)
                .padding(.trailing,20)
                .padding(.vertical,6)
                .background(Color.black.opacity(0.08))
                .padding(.top, 1)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .frame(width: 140)
                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 2)
                
                    
                
            }
            Spacer()
             
            HStack (alignment: .top){
               
                // icons options
                
                VStack {
                    VendoredSnapchatIconButtonOpacity(iconName: "gearshape.fill" ,size:18, circleSize: 43)
                    
                    VStack (spacing:10){
                        VendoredSnapchatIconImageButton(imageName: "t_icon",size: 20,backgroundColor: Color.vendoredSnapchatIconDarkBlueColor)
                        VendoredSnapchatIconImageButton(imageName: "earth_icon",size: 20,backgroundColor: Color.vendoredSnapchatIconBlueColor)
                        VendoredSnapchatIconButtonOpacity(iconName: "chevron.down",size: 8)
                        
                    }
                    .padding(.top, 12)
                    .padding(.bottom,10)
                    .padding(.horizontal,6)
                    .background(Color.black.opacity(0.08))
                    .padding(.top, 1)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }
                
            }
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 2)
            
        }
       
    }
}

struct VendoredSnapchatEmojiView: View {
    var body: some View {
        ZStack {
            Image(vendoredSnapchatUserDataCurrent.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
            Text("Me")
                .font(.subheadline)
                .bold()
                .foregroundStyle(.black)
                .padding(.vertical,0)
                .padding(.horizontal,10)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(x:0,y:40)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 2)
        .frame(width: 80, height: 80)
    }
}

struct VendoredSnapchatMyBitmojiPlaceFriendView: View {
    var body: some View {
        HStack (alignment: .bottom){
            VendoredSnapchatCircleProfileTextView(image: vendoredSnapchatUserDataCurrent.profileImage, title: "My Bitmoji")
                
            Spacer()
            VStack (spacing:14){
                Image("navigation_icon")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.black)
                    .frame(width: 15, height:15)
                    .fontWeight(.bold)
                    .padding(.all,12)
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                VendoredSnapchatCircleBuildingTextView(image: "building_icon", title: "Places")
                    
            }
            Spacer()
            VendoredSnapchatCircleProfileTextView(image: "default_user", title: "Friends")
                
            
        }
    }
}
