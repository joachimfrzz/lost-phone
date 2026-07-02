//
    // Project: InstagramRecreation2
    //  File: ContentView.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

struct InstagramRedditContentView: View {
    var body: some View {

        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0){
                TopAppBar()
                Divider()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0){
                        StoriesBar()
                        Divider()
                        FeedList()


                    }
                }
                Divider()
                BottomTabBar()
                
            }
            
        }
        
    }
}



#Preview {
    InstagramRedditContentView()
}
