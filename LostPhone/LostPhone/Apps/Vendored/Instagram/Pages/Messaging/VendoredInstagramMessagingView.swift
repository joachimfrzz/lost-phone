//
//  VendoredInstagramMessagingView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 21/3/24.
//

import SwiftUI

struct VendoredInstagramMessagingView: View {
    let userDataMessaging: [VendoredInstagramUserInstagramResponse] = vendoredInstagramUserData
    @Environment(\.dismiss)  var dismiss
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VendoredInstagramTextFieldSearchView()
                      
                    // message title
                    HStack {
                        Text("Messages")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("Requests")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    // user data messaging
                    LazyVStack (spacing: 16){
                        ForEach(userDataMessaging) { user in
                            NavigationLink(destination: VendoredInstagramMessagingDetailView(user: user).hideTabBar()) {
                                VendoredInstagramUserMessagingRowView(profileImageUrl: user.profileImage, username: user.username, lastModifierDate: "1h ago")
                                       }
                            .foregroundStyle(.black)
                        }
                    }
                    
                       
                }
                .padding(.horizontal)
                .padding(.vertical,10)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem (placement: .topBarLeading) {
                    
                    HStack (spacing: 0){
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
                        Text(vendoredInstagramUserDataCurrent.username)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 6,height: 6)
                            .padding(.top,4)
                            .fontWeight(.semibold)
                            .padding(.leading, 8)
                    }
                }
                ToolbarItem (placement: .topBarTrailing) {
                    HStack (spacing: 14){
                        Button {
                            
                        } label: {
                           Image("edit_messaging_icon")
                              
                        }
                        
                    }
                    
                }
            }
           
           
        }
        
        
    }
}

#Preview {
    VendoredInstagramMessagingView()
}
