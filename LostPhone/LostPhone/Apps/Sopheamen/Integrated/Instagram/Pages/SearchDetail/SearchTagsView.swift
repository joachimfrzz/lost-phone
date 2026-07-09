//
//  SearchTagsView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct SearchTagsView: View {
    let tagsData:[SearchTagRespoonse] = searchTagData
    var body: some View {
        LazyVStack {
            ForEach(tagsData) { item in
                HStack (spacing: 14){
                    Image("hashtag_icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 23,height: 23)
                        .padding(.all,12)
                        .overlay(Circle().stroke(Color.blackOpacity.opacity(0.3)))
                        
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.tagName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("\(item.totalPosts)K posts")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    
                }
                .padding(.vertical,6)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    SearchTagsView()
}
