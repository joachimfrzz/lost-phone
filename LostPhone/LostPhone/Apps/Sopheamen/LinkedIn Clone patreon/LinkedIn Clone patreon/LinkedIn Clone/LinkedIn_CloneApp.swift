//
//  LinkedIn_CloneApp.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 22/4/24.
//

import SwiftUI

@main
struct LinkedIn_CloneApp: App {
    
    init() {
           configureNavigationBar()
       }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func configureNavigationBar() {
            // Use UINavigationBarAppearance to change the navigation bar background color
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white  // Set the background color to white
            appearance.shadowColor = .clear  // Optionally remove the shadow

            // Apply the appearance to the navigation bar
            UINavigationBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    
}
