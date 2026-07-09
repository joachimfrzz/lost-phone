//
//  MessagingDetailView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 21/3/24.
//

import SwiftUI

struct MessagingDetailView: View {
    let user:UserInstagramResponse
    let messagingData:[MessagingResponse] = messagesData
    @Environment(\.dismiss)  var dismiss
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack (alignment: .bottom){
                ScrollView {
                    // content
                    VStack {
                        
                        // profile header
                        VStack {
                            ProfileImageView(profileImage: user.profileImage, size: 90)
                                .overlay(RoundedRectangle(cornerRadius: 90/2).stroke(.black.opacity(0.1)))
                            VStack (spacing: 3){
                                HStack (spacing: 5){
                                    Text(user.fullname)
                                        .font(.headline)
                                    Image("verified")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 21, height: 21)
                                        .padding(.top,3)
                                    
                                }
                                Text("Instagram")
                                    .font(.subheadline)
                                    .foregroundStyle(.black.opacity(0.8))
                                Text("95M followers - 3.9K posts")
                                    .font(.subheadline)
                                    .foregroundStyle(.black.opacity(0.8))
                                Text("You've followed this Instagram account since 2019...")
                                    .font(.subheadline)
                                    .foregroundStyle(.black.opacity(0.8))
                                
                                // View profile view
                                ButtonGrayView(title: "View profile")
                                    .padding(.top, 14)
                                //
                            }
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        // messages view
                        VStack (spacing: 5){
                            Text("6.00 PM")
                                .font(.caption)
                                .foregroundStyle(.black.opacity(0.8))
                            ForEach(messagingData) { item in
                                BubbleTextView(text: item.text ,isMe: item.isMe)
                            }
                           
                        }
                        .padding(.vertical, 16)
                        .padding(.bottom, 80)
                       
                        
                    }
                    .padding(.horizontal)
                }
                
                // bottom footer
                VStack {
                    
                    // button
                    HStack (spacing: 0){
                        Image("camera_white_icon")
                            .foregroundStyle(.white)
                            .padding(.all, 9)
                            .background(Color.primaryColor)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        TextField("Message...", text: $searchText)
                            .padding(.all,10)
                        Spacer()
                        HStack (spacing: 20){
                            Button {
                                
                            } label: {
                                Image("record_icon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 15,height: 15)
                                    .foregroundStyle(.black)
                            }
                            Button {
                                
                            } label: {
                                Image("gallery_icon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 22,height: 22)
                                    .foregroundStyle(.black)
                            }
                            Button {
                                
                            } label: {
                                Image("send_emoji_icon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 25,height: 25)
                                    .foregroundStyle(.black)
                            }
                        }
                        .padding(.trailing, 20)
                    }
                    .background(Color.textFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 75)
                .background(.white)
                
              
               
              
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                           Image(systemName: "chevron.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20,height: 20)
                                .foregroundStyle(.black)
                                .padding(.top,4)
                        }
                        
                        HStack (spacing: 10){
                            ProfileImageView(profileImage: user.profileImage, size: 40)
                            VStack (alignment: .leading, spacing: -3){
                                HStack (spacing: 5){
                                    Text(user.fullname)
                                        .font(.headline)
                                    Image("verified")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 16, height: 16)
                                        
                                }
                                Text(user.fullname)
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        

                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    MessagingDetailView(user: userData[0])
}


