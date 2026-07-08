//
//  TabView.swift
//  linkedin_clone
//
//  Created by Dipak on 26/02/23.
//

import SwiftUI

struct VendoredLinkedInTabScreen: View {
    var body: some View {
        TabView{
            VendoredLinkedInHomeScreen()
                .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
            }
            VendoredLinkedInMyNetworkScreen()
                .tabItem {
                        Image(systemName: "person.2.fill")
                        Text("MyNetwork")
            }
            Text("Post").tabItem{
                Image(systemName: "plus.app.fill")
                Text("Post")
            }
            Text("Notifications").tabItem{
                Image(systemName: "bell.badge.fill")
                Text("Post")
            }
            Text("Job").tabItem{
                Image(systemName: "briefcase.fill")
                Text("Post")
            }
            
        }
    }
}

