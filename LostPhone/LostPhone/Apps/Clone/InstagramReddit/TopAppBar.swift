//
    // Project: InstagramRecreation2
    //  File: TopAppBar.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

struct TopAppBar: View {
    var body: some View {
        HStack{
            Text("Instagram")
                .font(.system(size: 28, weight: .bold, design: .default))
                .kerning(0.5)
            Spacer()
            
            HStack(spacing: 16){
                Image(systemName: "plus.app")
                Image(systemName: "heart")
                
                ZStack{
                    Image(systemName: "paperplane")
                    Text("3")
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 1)
                        .background(Capsule().fill(Color.red))
                        .offset(x: 8, y: -8)
                        
                }

            }
            .font(.title2)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        
    }
}

#Preview {
    TopAppBar()
}
