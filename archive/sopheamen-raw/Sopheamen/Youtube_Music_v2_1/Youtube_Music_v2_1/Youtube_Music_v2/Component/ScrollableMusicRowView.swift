//
//  ScrollableMusicRowView.swift
//  Youtube_Music_v2
//
//  Created by Sopheamen VAN on 4/9/24.
//

import SwiftUI
import Kingfisher

struct ScrollableMusicRowView: View {
    var music: MusicResponse
    var width, height: CGFloat?
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            ZStack {
                KFImage(URL(string: music.coverUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: width ?? 300, height: height ?? 160)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
              
                
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                
            }
            VStack (alignment: .leading, spacing: 0){
                Text(music.name)
                    .font(.headline)
                    .foregroundStyle(.white)
                Text("\(music.artistName) - \(music.viewCount)")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            .frame(width: width ?? 280,alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ScrollableMusicRowView(music: danceAndEelectronicData[0])
}



