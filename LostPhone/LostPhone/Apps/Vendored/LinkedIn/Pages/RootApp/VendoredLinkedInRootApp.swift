//
//  VendoredLinkedInRootApp.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 3/5/24.
//

import SwiftUI

struct VendoredLinkedInRootApp: View {
    @State private var selectedTab: Int = 0
    @State private var searchField = ""
    @State private var isUploadPresented: Bool = false
    

    
    var body: some View {
        NavigationStack {
            VStack {
                        
                // Content Views
                Group {
                    switch selectedTab {
                    case 0:
                        VendoredLinkedInHomeView()
                    case 1:
                        VendoredLinkedInMyNetworkView()
                    case 3:
                        VendoredLinkedInNotificationView()
                    case 4:
                        VendoredLinkedInJobView()
                    default:
                        VendoredLinkedInHomeView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               
               
                
                // Custom Tab Bar
                HStack(spacing: 0) {
                    // Home Tab
                    VendoredLinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 0, label: "Home", systemIconName: "house.fill")
                    
                    // My Network Tab
                    VendoredLinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 1, label: "My Network", systemIconName: "person.2.fill")
                    
                    // Post Tab
                    VendoredLinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 2, label: "Post", systemIconName: "plus.app.fill")
                    
                    // Notifications Tab
                    VendoredLinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 3, label: "Notifications", systemIconName: "bell.fill")
                    
                    // Jobs Tab
                    VendoredLinkedInTabBarButton(selectedTab: $selectedTab, assignedTab: 4, label: "Jobs", systemIconName: "briefcase.fill")
                }
                .frame(height: 44)
                .background(Color(UIColor.systemBackground))
                
                
            }
            .onChange(of: selectedTab) {
                if(selectedTab == 2){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.isUploadPresented = true
                        self.selectedTab = 0
                    }
                }

            }
            .sheet(isPresented: $isUploadPresented) {
                VendoredLinkedInUploadPostView()
            }
            .toolbar {
                // profile
                ToolbarItem(placement: .topBarLeading) {
                    VendoredLinkedInProfileImageView(profileImage: vendoredLinkedInUserDataCurrent.profileImage, size: 35)
                }
                
                // search textfield
                ToolbarItem (placement: .principal){
                    HStack (spacing: 10){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.primary)

                        TextField("Search",text: $searchField)
                    }
                    .padding(.horizontal,10)
                    .frame(height: 35)
                    .background(Color.vendoredLinkedInTextFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: VendoredLinkedInAppSetting.smallRadius))
                    .padding(.horizontal,VendoredLinkedInAppSetting.smallPadding)
                }
                
                // message
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: VendoredLinkedInMessageView()) {
                        Image(systemName: "ellipsis.message.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(.primary)
                           
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    VendoredLinkedInRootApp()
}

// Tab Bar Button
struct VendoredLinkedInTabBarButton: View {
    @Binding var selectedTab: Int
    let assignedTab: Int
    let label: String
    let systemIconName: String
    
    var body: some View {
        Button(action: {
            
            withAnimation {
                selectedTab = assignedTab
            }
        }) {
            VStack {
                Image(systemName: systemIconName)
                    .font(.system(size: 18))
                Text(label)
                    .font(.footnote)
            }
            .foregroundStyle(selectedTab == assignedTab ? .primary : .secondary)
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(selectedTab == assignedTab ? Color.primary : .clear),
                alignment: .top
            )
        }
        .frame(maxWidth: .infinity)
        
    }
}


