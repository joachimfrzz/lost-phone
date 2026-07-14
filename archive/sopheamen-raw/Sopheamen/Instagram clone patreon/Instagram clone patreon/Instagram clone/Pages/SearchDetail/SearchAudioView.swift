//
//  SearchAudioView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI
import Kingfisher
struct SearchAudioView: View {
    let audioData:[SearchAudioResponse] = searchAudioData
    var body: some View {
        LazyVStack {
            ForEach(audioData) { item in
                HStack (spacing: 14){
                    KFImage(URL(string: item.imageCoverUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45,height: 45)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    VStack (alignment: .leading, spacing: 0){
                        Text(item.songName)
                            .fontWeight(.semibold)
                        HStack (spacing: 0){
                            Text(item.ownerName)
                            Text(" - \(item.totalReels)K reels")
                            
                        }
                        .font(.footnote)
                        .foregroundStyle(.gray)
                       
                            
                    }
                    .font(.subheadline)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical,6)
            }
        }
    }
}

#Preview {
    SearchAudioView()
}
