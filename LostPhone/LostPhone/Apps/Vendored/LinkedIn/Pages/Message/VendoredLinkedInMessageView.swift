//
//  VendoredLinkedInMessageView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 29/4/24.
//

import SwiftUI

struct VendoredLinkedInMessageView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var searchField = ""
    
    @State private var selectedTab = "Focused"
    
    let tabs = [ "Focused","Other" ]
    @Namespace private var underlineNamespace
    
    let size = (UIScreen.main.bounds.width / 2)
    

    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Button(action: {
                            withAnimation {
                                selectedTab = tab
                            }
                        }) {
                            Text(tab)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(selectedTab == tab ? Color.vendoredLinkedInActiveGreenTab : .black.opacity(0.6))
                                .padding(.bottom, 12)
                                .overlay(
                                    selectedTab == tab ?
                                        Rectangle()
                                        .frame(width: size,height: 2)
                                        .foregroundColor(Color.vendoredLinkedInActiveGreenTab)
                                            .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                                        : nil
                                    , alignment: .bottom
                                )
                                
                                
                        }
                        .frame(width: size)
                       
                    }
                   
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55, alignment: .leading)
                .background(.white)
                
                
                // content
                getContentTab(value: selectedTab)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.vendoredLinkedInBackgroundColor)
            .toolbar {
               
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                            .foregroundStyle(.black.opacity(0.8))
                    }

                }
                
                // search textfield
                ToolbarItem (placement: .principal){
                    HStack (spacing: 10){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.5))

                        TextField("Search messages",text: $searchField)
                        
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.8))
                    }
                    .padding(.horizontal,10)
                    .frame(height: 35)
                    .background(Color.vendoredLinkedInTextFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: VendoredLinkedInAppSetting.smallRadius))
                    .padding(.horizontal,VendoredLinkedInAppSetting.smallPadding)
                }
                
                // message
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 4, height: 4)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                        .padding(.trailing,10)
                        
                        
                        Button {
                            
                        }label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 23, height: 23)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black.opacity(0.8))
                        }
                    }
                }
            }
        }
        
        
    }
    @ViewBuilder
    func getContentTab(value: String) -> some View {
        switch value {
        case "Focused":
            VendoredLinkedInFocusedView()
        case "Other":
            VendoredLinkedInOtherView()
               
        default:
            Text("Empty View")
        }
    }
}

#Preview {
    VendoredLinkedInMessageView()
}

struct VendoredLinkedInFocusedView: View {
    var messageDatas:[VendoredLinkedInMessageResponse] = messagesData
    var body: some View {
        LazyVStack (spacing:10){
            ForEach(messageDatas) { message in
                NavigationLink(destination: VendoredLinkedInMessageDetailView(message: message)){
                    VendoredLinkedInmessageRowView(message: message)
                }
               

            }
            
        }
        .padding(.vertical,10)
        .padding(.horizontal)
        .background(.white)
    }
}

struct VendoredLinkedInmessageRowView:View {
    var message: VendoredLinkedInMessageResponse
    var body: some View {
        HStack {
            HStack (spacing:12){
                VendoredLinkedInProfileImageView(profileImage: message.user.profileImage, size: 55)
                VStack (alignment: .leading,spacing:0){
                    Text(message.user.fullname)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black)
                    Text(message.text)
                        .font(.subheadline)
                        .fontWeight(message.badgeNumber != 0 ? .semibold : .regular)
                        .foregroundStyle(message.badgeNumber == 0 ? .black.opacity(0.7) : .black)
                        .lineLimit(1)
                    
                    
                    Divider()
                        .padding(.top,5)
                }
            }
            Spacer()
            VStack (spacing:8){
                Text(message.dateAgo)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.7))
                if  (message.badgeNumber != 0),  message.badgeNumber > 0 {
                    ZStack {
                        Circle()
                            .fill(Color.vendoredLinkedInVendoredLinkedInPrimary)
                            .frame(width: 20,height: 20)
                        
                        Text("\(message.badgeNumber)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
            }
            
        }
    }
}

struct VendoredLinkedInOtherView: View {
    var body: some View {

        VStack (spacing:30){
           
            // content
            Image("empty_state")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
            
            VStack (spacing:12){
                Text("No messages - yet!")
                    .font(.title2)
                Text("Reach out and start a converstion. Great things might happen.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Button {
                    
                }label: {
                    Text("Start a new message")
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
        .padding(.top,100)
    }
}


