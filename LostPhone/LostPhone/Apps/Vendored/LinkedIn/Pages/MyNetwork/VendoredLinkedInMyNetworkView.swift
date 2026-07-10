//
//  VendoredLinkedInMyNetworkView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 26/4/24.
//

import SwiftUI
import Kingfisher

struct VendoredLinkedInMyNetworkView: View {
    
    
 
    
    var body: some View {
            ScrollView {
                VStack {
                   
                    // manage my network and invitation
                    VStack {
                        // manage my network
                        VendoredLinkedInManageMyNetworkView()
                        VendoredLinkedInInvitationView()
                    }
                    
                    
                    // people skill
                    VendoredLinkedInPeopleSkillView()
                    
                    // audio event
                    VendoredLinkedInAudioEventView()
                    
                    // group interested in
                    VendoredLinkedInGroupInterestedInView()
                    
                    // suggest for you
                    
                    VendoredLinkedInMoreSuggestionForYouView()
                }
                .padding(.vertical, 10)
                
            }
            .background(Color.vendoredLinkedInBackgroundColor)
    }
}

#Preview {
    VendoredLinkedInMyNetworkView()
}

struct VendoredLinkedInManageMyNetworkView: View {
    var body: some View {
        HStack {
            Text("Manage my network")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            Spacer()
            Image(systemName: "chevron.forward")
                .resizable()
                .scaledToFill()
                .frame(width: 8, height: 8)
                .foregroundStyle(.black.opacity(0.8))
            
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .background(.white)
        
    }
}
struct VendoredLinkedInInvitationView: View {
    var body: some View {
        HStack {
            Text("Invitations")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            Spacer()
            Image(systemName: "chevron.forward")
                .resizable()
                .scaledToFill()
                .frame(width: 8, height: 8)
                .foregroundStyle(.black.opacity(0.8))
            
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .background(.white)
        
    }
}

struct VendoredLinkedInPeopleSkillView: View {
    @StateObject var viewModel = VendoredLinkedInUserViewModel()
   
    var body: some View {
        VStack (spacing:10){
            Text("People skilled in Usability are following")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack (spacing:10){
                ForEach(viewModel.peopleSkilledUsers) {user in
                    VendoredLinkedInPeopleSkillRowView(user: user)
                }
            }
            
            // see all button
            Button {
                
            }label: {
                Text("See all")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            }
            .padding(.top,10)
            
            
            
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .background(.white)
    }
}

struct VendoredLinkedInPeopleSkillRowView : View {
    var user:VendoredLinkedInUserLinkedInResponse
    var body: some View {
        ZStack (alignment: .leading){
            VStack {
                ZStack (alignment: .topTrailing){
                    KFImage(URL(string: user.imageCover))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                    
                    Button {
                        
                    }label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .padding(.all, 8)
                            .background(Color.black.opacity(0.8))
                            .clipShape(Circle())
                            .padding(.vertical,6)
                            .padding(.horizontal,8)
                    }
                }
                
                VStack (spacing: -2){
                    // follow
                    Button {
                        
                    }label: {
                        Text("Follow")
                            .font(.subheadline)
                            .padding(.vertical,4)
                            .padding(.horizontal)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    // fullname and followers
                    HStack (spacing: 0){
                        Text(user.fullname)
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text(" - \(user.totalFollowers) followers")
                            .font(.subheadline)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // headLine
                    Text(user.headLineBio)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .frame(height: 100)
                .padding(.horizontal)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.5)))
            
            
            VendoredLinkedInProfileImageView(profileImage: user.profileImage, size: 80)
                .offset(x: 20)
                
        }
       
        
    }
}

struct VendoredLinkedInAudioEventView:View {
    var audioEvents:[VendoredLinkedInAudioEventResponse] = audioEventsData
   
    var body: some View {
        VStack (spacing:10){
            Text("Audio events for you")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack (spacing:10){
                ForEach(audioEvents) {audio in
                    VendoredLinkedInAudioEventRow(audio: audio)
                }
            }
            
            // see all button
            Button {
                
            }label: {
                Text("See all")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            }
            .padding(.top,10)
            
            
            
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .background(.white)
    }
}

struct VendoredLinkedInAudioEventRow:View {
    var audio:VendoredLinkedInAudioEventResponse
    var body: some View {
       
            VStack {
                ZStack (alignment: .topTrailing){
                    KFImage(URL(string: audio.imageCover))
                        .resizable()
                        .scaledToFill()
                        .frame(height: 100)
                        .clipped()
                    
                    Button {
                        
                    }label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .padding(.all, 8)
                            .background(Color.black.opacity(0.8))
                            .clipShape(Circle())
                            .padding(.vertical,6)
                            .padding(.horizontal,8)
                    }
                }
                
                VStack (spacing:-2){
                    HStack (alignment: .top){
                        // title
                        Text(audio.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        // follow
                        Button {
                            
                        }label: {
                            Text("Follow")
                                .font(.subheadline)
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                        }
                    }
                    
                    
                    // headLine
                    Text("\(audio.date)")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black.opacity(0.7))
                    
                    HStack {
                        Image(systemName: "person.2.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 12,height: 12)
                        Text("\(audio.totalAttendees) attendees")
                            .font(.footnote)
                    }
                    .foregroundStyle(.black.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.vertical,6)
                .padding(.horizontal)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.5)))
            
            
           
       
        
    }
}

struct VendoredLinkedInGroupInterestedInView:View {
    @StateObject var viewModel = VendoredLinkedInUserViewModel()
    
    let columns:[GridItem] = [
        GridItem(.flexible(), spacing: VendoredLinkedInAppSetting.smallPadding),
        GridItem(.flexible(), spacing: VendoredLinkedInAppSetting.smallPadding),
    ]
    let size = (UIScreen.main.bounds.width / 2)
    var body: some View {
        VStack (spacing:20){
            Text("Groups you may be intested in")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            LazyVGrid(columns: columns, spacing: 22) {
                ForEach(viewModel.groupInterestedIn) { group in
                    VendoredLinkedInGroupInterestedInRowView(width: size, group: group)
                }
            }
            
            // see all button
            Button {
                
            }label: {
                Text("See all")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            }
           
            
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .background(.white)
    }
}

struct VendoredLinkedInGroupInterestedInRowView: View {
    var width:CGFloat
    var group:VendoredLinkedInUserLinkedInResponse
    var body: some View {
        VStack (spacing:0){
           
            // cover and close icon button
            ZStack (alignment: .topTrailing){

                KFImage(URL(string: group.imageCover))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width-20,height: 70)
                    .clipped()
                    .clipShape(VendoredLinkedInRoundedSpecificCorners(radius: 10, corners: [.topLeft, .topRight]))
                    
                    .offset(y:10)
                    
                Button {
                    
                }label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10,height: 10)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding(.all, 8)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Circle())
                        .padding(.vertical,6)
                        .padding(.horizontal,8)
                }
                .offset(y:10)
                
            }
            
            // profile and more info
            VStack {
                VendoredLinkedInProfileImageRectangleView(profileImage: group.profileImage, size: 80)
                    .padding(.bottom,10)
                Text(group.headLineBio)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Text("\(group.totalFollowers) members")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(2)
                
                Button {
                    
                }label: {
                    Text("Join")
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .padding(.horizontal,50)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal)
            .offset(y:-30)
                
        }
        .frame(height:240)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
    }
}


struct VendoredLinkedInMoreSuggestionForYouView:View {
    @StateObject var viewModel = VendoredLinkedInUserViewModel()
    
    let columns:[GridItem] = [
        GridItem(.flexible(), spacing: VendoredLinkedInAppSetting.smallPadding),
        GridItem(.flexible(), spacing: VendoredLinkedInAppSetting.smallPadding),
    ]
    let size = (UIScreen.main.bounds.width / 2)
    var body: some View {
        VStack (spacing:30){
            Text("More suggestions for you")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(viewModel.suggestionUsers) { group in
                    VendoredLinkedInMoreSuggestionForYouRowView(width: size, group: group)
                }
            }
            
            // see all button
            Button {
                
            }label: {
                Text("See all")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.vendoredLinkedInVendoredLinkedInPrimary)
            }
            .padding(.top,-10)
            
           
            
        }
        .padding(.horizontal)
        .padding(.vertical,12)
        .background(.white)
    }
}

struct VendoredLinkedInMoreSuggestionForYouRowView: View {
    var width: CGFloat
    var group: VendoredLinkedInUserLinkedInResponse
    var body: some View {
        VStack (spacing:0){
           
            // cover and close icon button
            ZStack (alignment: .topTrailing){
                KFImage(URL(string: group.imageCover))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width-20,height: 70)
                    .clipped()
                    .clipShape(VendoredLinkedInRoundedSpecificCorners(radius: 10, corners: [.topLeft, .topRight]))
                    
                    .offset(y:18)
                    
                    
                Button {
                    
                }label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 10,height: 10)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding(.all, 8)
                        .background(Color.black.opacity(0.8))
                        .clipShape(Circle())
                        .padding(.vertical,6)
                        .padding(.horizontal,8)
                }
                .offset(y:18)
                
            }
            
            // profile and more info
            VStack {
                VendoredLinkedInProfileImageView(profileImage: group.profileImage, size: 80)
                    .padding(.bottom,10)
                Text(group.fullname)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                Text(group.headLineBio)
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(2)
                   
                VStack (spacing:5){
                    Text("Based on your profile")
                        .font(.footnote)
                        .foregroundStyle(.black.opacity(0.7))
                        .lineLimit(2)
                    Button {
                        
                    }label: {
                        Text("Connect")
                            .font(.subheadline)
                            .frame(width:60)
                            .padding(.vertical,4)
                            .padding(.horizontal,40)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding(.horizontal)
            .offset(y:-30)
                
        }
        .frame(height:240)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.3)))
    }
}




