//
//  VendoredWhatsAppChatView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct VendoredWhatsAppChatView: View {
    let chatAllData:[VendoredWhatsAppChatResponse] = vendoredWhatsAppChatData
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    VStack (spacing: 10){
                        HStack {
                            Text("Broadcast Lists")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                            Spacer()
                            Text("New Group")
                                .font(.headline)
                                .fontWeight(.regular)
                                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        // list user chat view
                        LazyVStack {
                            ForEach(chatAllData) { item in

                                NavigationLink(destination: VendoredWhatsAppChatDetailView(chatResponse: item).hideTabBar()){
                                    VStack (spacing: 5){
                                        VendoredWhatsAppChatRowView(chatResponse: item)
                                            .padding(.horizontal)
                                        Divider()
                                            .padding(.leading, 100)
                                    }
                                }
                                
                            }
                        }
                        .padding(.bottom, 40)
                        
                    }
                }
                
            }
            .background(Color(hex: "#111B21"))
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button {
                        
                    }label: {
                        Text("Edit")
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem (placement: .topBarTrailing){
                    HStack (spacing: 20){
                        Button {
                            
                        }label: {
                           Image(systemName: "camera")
                                .resizable()
                                .scaledToFill()
                                .frame(width:20, height: 20)
                        }
                        .padding(.top, 3)
                        Button {
                            
                        }label: {
                           Image(systemName: "square.and.pencil")
                                .resizable()
                                .scaledToFill()
                                .frame(width:22, height: 20)
                        }
                    }
                }
            }
          
        }
    }
}

#Preview {
    VendoredWhatsAppChatView()
}
