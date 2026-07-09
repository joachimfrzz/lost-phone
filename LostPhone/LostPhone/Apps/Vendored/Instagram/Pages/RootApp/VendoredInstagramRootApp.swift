//
//  VendoredInstagramRootApp.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 8/3/24.
//

import SwiftUI

struct VendoredInstagramRootApp: View {
    @State private var selectedIndex = 0
    @State private var isUploadPresented: Bool = false
    
    var body: some View {
            TabView (selection: $selectedIndex){
                VendoredInstagramHomeView()
                    .tabItem {
                        if(selectedIndex == 3) {
                            Image("home_white_icon")
                        }
                        Image((selectedIndex == 0 || selectedIndex == 2) ? "home_active_icon" : "home_icon")
                    }
                    .onAppear { selectedIndex = 0 }
                    .tag(0)
                
                VendoredInstagramSearchView()
                    .tabItem {
                        if(selectedIndex == 3) {
                            Image("search_white_icon")
                        }
                        Image(selectedIndex == 1 ? "search_active_icon" : "search_icon")
                    }
                    .onAppear { selectedIndex = 1 }
                    .tag(1)
                
                VendoredInstagramHomeView()
                    .tabItem {
                        if(selectedIndex == 3) {
                            
                            Button {
                                
                            }label: {
                                Image("plus_white_icon")
                            }
                        }
                        Button {
                            
                        }label: {
                            Image("plus_icon")
                        }
                    }
                    .onAppear { selectedIndex = 2 }
                    .tag(2)
                
                VendoredInstagramReelsView()
                    .tabItem {
                        
                        Image(selectedIndex == 3 ? "reels_white_icon" : "reels_icon")
                    }
                    .onAppear { selectedIndex = 3 }
                    .tag(3)
                
                VendoredInstagramProfileView()
                    .tabItem {
                        if(selectedIndex == 3) {
                            Image("account_white_icon")
                        }
                        Image( selectedIndex == 4 ? "account_active_icon" : "account_icon")
                    }
                    .onAppear { selectedIndex = 4 }
                    .tag(4)
            }
            .colorScheme(selectedIndex ==  3  ? .dark : .light)
            .onChange(of: selectedIndex) {
                if(selectedIndex == 2){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.isUploadPresented = true
                        self.selectedIndex = 0
                    }
                }

            }
            .sheet(isPresented: $isUploadPresented) {
                VendoredInstagramBrowseGalleryView() // Your upload view here
            }
            .navigationBarBackButtonHidden(true)
            
   
   
    }
}

#Preview {
    VendoredInstagramRootApp()
}
