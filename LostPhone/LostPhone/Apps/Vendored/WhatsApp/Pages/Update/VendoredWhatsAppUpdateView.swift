//
//  VendoredWhatsAppUpdateView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 4/4/24.
//

import SwiftUI

struct VendoredWhatsAppUpdateView: View {
   
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 16){
                    // status
                    VendoredWhatsAppstatusAndProfileView()
                    .padding(.top,14)
                    
                    // channel
                    VStack (alignment: .leading,spacing: -10){
                       // list channels view
                        VendoredWhatsAppchannelFeedView()
                        // find channel
                        VendoredWhatsAppfindChannelView()
                        
                        
                       
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                }
                
                
                
            }
            .navigationTitle("Updates")
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    HStack {
                        Button {
                            
                        }label: {
                            Image(systemName: "plus")
                        }
                        
                        Button {
                            
                        }label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
            }
            .background(Color.vendoredWhatsAppBackgroundColor)
           
           
        }
    }
}

#Preview {
    VendoredWhatsAppUpdateView()
}

struct VendoredWhatsAppstatusAndProfileView: View {
    var body: some View {
        VStack (alignment: .leading,spacing: 10){
            Text("Status")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            HStack {
                HStack (spacing: 14){
                    VendoredWhatsAppProfileStoryView()
                    VStack (alignment: .leading,spacing: -3){
                        Text("My Status")
                            .font(.headline)
                        Text("Add to my status")
                            .font(.subheadline)
                            .foregroundStyle(Color.vendoredWhatsAppBlackOpacity)
                    }
                }
                .padding(.horizontal)
                Spacer()
                HStack (spacing: 14){
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15,height: 15)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        .padding(.all, 12)
                        .background(Color.vendoredWhatsAppBackgroundColor)
                        .clipShape(Circle())
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 15,height: 15)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        .padding(.all, 12)
                        .background(Color.vendoredWhatsAppBackgroundColor)
                        .clipShape(Circle())
                        
                }
                .padding(.horizontal)
                
            }
            .frame(height: 90)
            .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.vendoredWhatsAppBackgroundColor))
            .background(.white)
        }
    }
}

struct VendoredWhatsAppchannelFeedView: View {
    let channelAllFeedData:[VendoredWhatsAppChannelFeedResponse] = channelFeedData
    
    var body: some View {
        VStack {
            // title
            Text("Channels")
                 .font(.subheadline)
                 .fontWeight(.semibold)
                 .frame(maxWidth: .infinity, alignment: .leading)
                
            // list feed channel
            LazyVStack {
                ForEach(channelAllFeedData) { feed in
                    VStack (spacing: 14){
                        VendoredWhatsAppChannelFeedRowView(channelFeedResponse: feed)
                        Divider()
                    }
                    .padding(.bottom,10)
                    
                }
            }
            
            
        }
        .padding(.vertical,12)
        .padding(.horizontal)
    }
}

struct VendoredWhatsAppfindChannelView: View {
    let findChannelAllData:[VendoredWhatsAppChannelResponse] = channelData
    var body: some View {
        // list find channel
        VStack {
            // title and see all
            HStack{
                Text("Find Channels")
                     .font(.subheadline)
                     .fontWeight(.semibold)
                     .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Button {
                    
                }label: {
                    Text("See All")
                         .font(.subheadline)
                         .fontWeight(.semibold)
                         .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                }
                     
            }
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack (spacing:16){
                    ForEach(findChannelAllData) { channel in
                        VStack {
                            ZStack (alignment: .bottomTrailing){

                                Image(channel.profileUrl)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .overlay(Circle().stroke(Color.gray.opacity(0.8), lineWidth: 0.5))
                                    .clipShape(Circle())
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:22, height: 22)
                                    .foregroundStyle(Color.vendoredWhatsAppChatColor)
                                    .overlay(Circle().stroke(.white, lineWidth: 2.5))
                                    .offset(x:5, y:0)
                            }
                            Text(channel.name)
                                .font(.footnote)
                                .frame(width: 65)
                                .lineLimit(1)
                        }
                       
                    }
                }
            }
            
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
}
