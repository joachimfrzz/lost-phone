//

//
//  AddGroupView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 11/4/24.
//

import SwiftUI
import Kingfisher

struct VendoredWhatsAppCommunitiesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    // profile
                    VendoredWhatsAppProfileView()
                    
                    // welcome to group
                    VendoredWhatsAppWelcomeNoteView()
                    
                    // manager group
                    VendoredWhatsAppManageGroupView()
                    
                    // your group
                    VendoredWhatsAppYourGroupView()
                    
                    // other group
                    VendoredWhatsAppOtherGroupView()
                    
                    // exit group
                    VendoredWhatsAppExitGroupView()

                    
                }
                .padding()
            }
            .navigationBarTitle("Community", displayMode: .inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing){
                    Text("Edit")
                        .font(.subheadline)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                }
            }
            .background(Color.vendoredWhatsAppBackgroundColor)
        }
    }
}

#Preview {
    VendoredWhatsAppCommunitiesView()
}

struct VendoredWhatsAppProfileView: View {
    var body: some View {
        VStack (spacing: 5){
            KFImage(URL(string: "https://media.timeout.com/images/105799362/image.jpg"))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black.opacity(0.2)))
            Text("SG Run Club")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Community - 2 groups")
                .font(.subheadline)
                .foregroundStyle(.gray)
            
        }
    }
}

struct VendoredWhatsAppWelcomeNoteView: View {
    var body: some View {
        Text("Welcome to our Run Club! We are a fun")
            .font(.headline)
            .fontWeight(.regular)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,16)
            .padding(.vertical,10)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct VendoredWhatsAppManageGroupView: View {
    var body: some View {
        VStack (alignment: .leading,spacing: 10){
            HStack {
                Text("Manage Groups")
                    .font(.headline)
                    .fontWeight(.regular)
                    
                Spacer()
                HStack (spacing: 10){
                    Text("2")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(.gray)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(.gray)
                        .fontWeight(.semibold)
                        
                }
            }
            Divider()
            HStack{
                Text("View Members")
                    .font(.headline)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
            }
            Divider()
            HStack{
                Text("Community Settings")
                    .font(.headline)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal,16)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct VendoredWhatsAppYourGroupView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text("Your Groups")
                .font(.title2)
                .fontWeight(.semibold)
            VStack {
                HStack (spacing: 14){
                    Image(systemName: "speaker.wave.3.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18,height: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        .padding(.all, 12)
                        .background(Color.vendoredWhatsAppVendoredWhatsAppPrimary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack (alignment: .leading, spacing: -2){
                        Text("Announcements")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black)
                        Text("Group 'SG Runners' ")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                    }
                    Spacer()
                    VStack (alignment: .trailing, spacing: 5){
                        Text("3:42 PM")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Image(systemName: "pin.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .padding(.leading, 40)
                
                HStack (spacing: 14){
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18,height: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .padding(.all, 12)
                        .background(Color.black.opacity(0.25))
                        .clipShape(Circle())
                    
                    VStack (alignment: .leading, spacing: -2){
                        Text("SG Runners")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black)
                        Text("You added this group to ..")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                    }
                    Spacer()
                    VStack (alignment: .trailing, spacing: 5){
                        Text("3:42 PM")
                            .font(.subheadline)
                            .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        Circle()
                            .scaledToFill()
                            .frame(width: 10,height: 10)
                            .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal,16)
            .padding(.vertical,10)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct VendoredWhatsAppOtherGroupView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text("Other Groups")
                .font(.title2)
                .fontWeight(.semibold)
            VStack {
                HStack (spacing: 14){
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 18,height: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        .padding(.all, 12)
                        .background(Color.vendoredWhatsAppBackgroundColor)
                        .clipShape(Circle())
                    
                    Text("Add Group")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal,16)
            .padding(.vertical,10)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct VendoredWhatsAppExitGroupView: View {
    var body: some View {
        VStack (spacing: 10){
            Text("Exit Community")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(Color.vendoredWhatsAppDangerColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text("Report Community")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(Color.vendoredWhatsAppDangerColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text("Deactivate Community")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(Color.vendoredWhatsAppDangerColor)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal,16)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


