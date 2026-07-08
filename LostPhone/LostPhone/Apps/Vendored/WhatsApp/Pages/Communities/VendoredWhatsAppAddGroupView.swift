//
//  AddGroupView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 11/4/24.
//

import SwiftUI

struct VendoredWhatsAppCommunitiesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 20){
                    VStack (spacing: 10){
                        HStack (spacing: 14){
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18,height: 18)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                                .padding(.all, 12)
                                .background(Color.vendoredWhatsAppBackgroundColor)
                                .clipShape(Circle())
                            
                            Text("Create New Group")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                            .padding(.leading, 40)
                        HStack (spacing: 14){
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18,height: 18)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                                .padding(.all, 12)
                                .background(Color.vendoredWhatsAppBackgroundColor)
                                .clipShape(Circle())
                            
                            Text("Add Existing Group")
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
                    
                    // announcement
                    VStack (spacing: 10){
                        HStack{
                            Text("Groups in this community")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .textCase(.uppercase)
                            Spacer()
                            Text("Edit")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .textCase(.uppercase)
                        }
                        HStack{
                            Image(systemName: "waveform.badge.exclamationmark")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18,height: 18)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                                .padding(.all, 12)
                                .background(Color.vendoredWhatsAppVendoredWhatsAppPrimary.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading,spacing:0){
                                Text("Announcements")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                Text("Announcement group")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.gray)
                                    .padding(.top,-3)
                                   
                            }
                                
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,16)
                        .padding(.vertical,10)
                        
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
            }
            .navigationBarTitle("Edit", displayMode: .inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing){
                    Text("Create")
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
