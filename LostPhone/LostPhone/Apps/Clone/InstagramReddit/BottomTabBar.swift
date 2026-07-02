//
    // Project: InstagramRecreation2
    //  File: BottomTabBar.swift
    //  Created by Noah Carpenter
    //  🐱 Follow me on YouTube! 🎥
    //  https://www.youtube.com/@NoahDoesCoding
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
    //  Dream Big, Code Bigger
    

import SwiftUI

struct BottomTabBar: View {
    @State private var selected: Int = 0
    var body: some View {
        HStack{
            TabItem(icon: "house.fill", index: 0, selected: $selected)
            Spacer()
            TabItem(icon: "magnifyingglass", index: 1, selected: $selected)
            Spacer()
            TabItem(icon: "plus.app.fill", index: 2, selected: $selected)
            Spacer()
            TabItem(icon: "play.rectangle", index: 3, selected: $selected)
            Spacer()
            TabItem(icon: "person.circle", index: 4, selected: $selected)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}
struct TabItem: View{
    let icon: String
    let index: Int
    @Binding var selected: Int
    
    var body: some View{
        
        VStack{
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(selected == index ? .primary : .secondary)
        }
        .frame(height: 40)
        .contentShape(Rectangle())
        .onTapGesture {
            selected = index
        }
    }
}


#Preview {
    BottomTabBar()
}
