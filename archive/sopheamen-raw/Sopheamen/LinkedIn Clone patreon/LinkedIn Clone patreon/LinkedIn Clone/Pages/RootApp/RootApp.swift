//
//  RootApp.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 3/5/24.
//

import SwiftUI

struct RootApp: View {
    @State private var selectedTab: Int = 0
    @State private var searchField = ""
    @State private var isUploadPresented: Bool = false
    

    
    var body: some View {
        NavigationStack {
            VStack {
                        
                // Content Views
                TabView(selection: $selectedTab) {
                    HomeView().tag(0)
                    MyNetworkView().tag(1)
                    UploadPostView().tag(2)
                    NotificationView().tag(3)
                    JobView().tag(4)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
               
               
                
                // Custom Tab Bar
                HStack(spacing: 0) {
                    // Home Tab
                    TabBarButton(selectedTab: $selectedTab, assignedTab: 0, label: "Home", systemIconName: "house.fill")
                    
                    // My Network Tab
                    TabBarButton(selectedTab: $selectedTab, assignedTab: 1, label: "My Network", systemIconName: "person.2.fill")
                    
                    // Post Tab
                    TabBarButton(selectedTab: $selectedTab, assignedTab: 2, label: "Post", systemIconName: "plus.app.fill")
                    
                    // Notifications Tab
                    TabBarButton(selectedTab: $selectedTab, assignedTab: 3, label: "Notifications", systemIconName: "bell.fill")
                    
                    // Jobs Tab
                    TabBarButton(selectedTab: $selectedTab, assignedTab: 4, label: "Jobs", systemIconName: "briefcase.fill")
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
                UploadPostView()
            }
            .toolbar {
                // profile
                ToolbarItem(placement: .topBarLeading) {
                    ProfileImageView(profileImage: userDataCurrent.profileImage, size: 35)
                }
                
                // search textfield
                ToolbarItem (placement: .principal){
                    HStack (spacing: 10){
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.black.opacity(0.8))

                        TextField("Search",text: $searchField)
                    }
                    .padding(.horizontal,10)
                    .frame(height: 35)
                    .background(Color.textFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: AppSetting.smallRadius))
                    .padding(.horizontal,AppSetting.smallPadding)
                }
                
                // message
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: MessageView()) {
                        Image(systemName: "ellipsis.message.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 22, height: 22)
                            .foregroundStyle(.black.opacity(0.5))
                           
                    }
                }
            }
        }
        
      
    }
    
}

#Preview {
    RootApp()
}

// Tab Bar Button
struct TabBarButton: View {
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
            .foregroundColor(selectedTab == assignedTab ? .black : .gray)
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(selectedTab == assignedTab ? .black : .clear),
                alignment: .top
            )
        }
        .frame(maxWidth: .infinity)
        
    }
}


