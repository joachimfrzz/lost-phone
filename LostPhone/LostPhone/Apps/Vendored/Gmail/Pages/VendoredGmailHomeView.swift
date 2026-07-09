//
//  VendoredGmailHomeView.swift
//  Youtube_Gmail
//
//  Created by Sopheamen VAN on 9/10/24.
//

import SwiftUI
// load lib image network cache
import Kingfisher

struct VendoredGmailHomeView: View {
    // now set state to trigger sidemenu
    @State private var showSideMenu: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // main view
                VendoredGmailMainHomeView(showSideMenu: $showSideMenu)
                    .offset(x: showSideMenu ? 300 : 0)
                    .animation(.easeInOut(duration: 0.3), value: showSideMenu)
                // sidemenu later
                HStack {
                    VendoredGmailSideMenuView()
                        .frame(width: 300)
                        .offset(x: showSideMenu ? 0 : -300)
                        .animation(.easeInOut(duration: 0.3), value: showSideMenu)
                    Spacer()
                }
                
                // set overlay to toggle sidemenu
                if showSideMenu {
                    Color.black.opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                showSideMenu.toggle()
                            }
                        }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    VendoredGmailHomeView()
}

struct VendoredGmailMainHomeView:View {
    // load email records
    var emailRecords: [VendoredGmailEmailResponse] = emailData
    
    @Binding var showSideMenu: Bool
    var body: some View {
        ZStack (alignment: .bottomTrailing){
            // content
            ScrollView {
                VStack {
                    // header
                    HStack (spacing:20){
                        // icon burger
                        Button {
                            showSideMenu.toggle()
                        }label: {
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 14, height: 14)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                        }
                        // textfield search
                        TextField("Search in emails", text: .constant(""))
                        // profile url
                        KFImage(URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 34, height: 34)
                            .clipShape(Circle())
                    }
                    .padding(.horizontal)
                    .frame(height:50)
                    .background(Color.vendoredGmailVendoredGmailGray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    // inbox title
                    Text("inbox")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.5))
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    // list items
                    LazyVStack (spacing:12){
                        ForEach(emailRecords) { email in
                            VendoredGmailEmailRowView(email: email)
                        }
                    }
                }
                .padding()
            }
            // footer flaoting send email
            VendoredGmailFloatingButtonView()
        }
    }
}

struct VendoredGmailEmailRowView:View {
    var email: VendoredGmailEmailResponse
    var body: some View {
        HStack (alignment: .top, spacing: 16){
            // profile
            KFImage(URL(string: email.profileUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white.opacity(0.4), lineWidth: 1))
            // content and attachments
            VStack (alignment: .leading, spacing: 8){
                //
                VStack (alignment: .leading, spacing:0){
                    Text(email.toAndCC)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.white.opacity(0.8))
                    Text(email.description)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.white.opacity(0.6))
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                // attachments
                HStack (spacing:12){
                    ForEach(email.attachments, id:\.self) { attachment in
                        HStack {
                            Image(systemName: "photo")
                                .foregroundStyle(Color.vendoredGmailVendoredGmailPrimary)
                            Text(attachment)
                                .font(.caption)
                                .lineLimit(1)
                                .foregroundStyle(.white.opacity(0.6))
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .frame(width: 120)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(.white.opacity(0.5)))
                    }
                }
            }
            // date time ago and star icon
            VStack (spacing: 24){
                Text(email.dateAgo)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.white.opacity(0.6))
                Image(systemName: email.isStarred ? "star.fill" : "star")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(email.isStarred ? Color.vendoredGmailVendoredGmailStarred : .white.opacity(0.6))
            }
        }
    }
}

struct VendoredGmailFloatingButtonView:View {
    var body: some View {
        Button {
            
        }label: {
            HStack (spacing: 10){
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.vendoredGmailVendoredGmailPrimary)
                Text("Compose")
                    .font(.headline)
                    .foregroundStyle(Color.vendoredGmailVendoredGmailPrimary)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 24)
            .background(Color.vendoredGmailVendoredGmailSideMenuBackground)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .padding(.trailing, 20)
    }
}
