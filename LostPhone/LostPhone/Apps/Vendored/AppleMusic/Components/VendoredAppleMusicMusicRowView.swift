//
//  VendoredAppleMusicMusicRowView.swift
//  Youtube_Apple_music_clone
//
//  Created by Sopheamen VAN on 24/12/24.
//

import SwiftUI
import Kingfisher

struct VendoredAppleMusicMusicRowView:View {
    var music:VendoredAppleMusicMusicResponse
    var width, height: CGFloat?
    var body: some View {
        VStack (alignment: .leading){
            // image
            KFImage(URL(string: music.coverUrl))
                .resizable()
                .scaledToFill()
                .frame(width: width ?? 160, height: height ?? 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            // name
            // artist name
            VStack (alignment: .leading, spacing: 0){
                Text(music.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                    .foregroundStyle(.black)
                Text(music.artistName)
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.6))
                    .lineLimit(1)
            }
            .frame(width: width ?? 160)
        }
        .frame(width: width ?? 160)
    }
}

#Preview {
    VendoredAppleMusicMusicRowView(music: playListData[0])
}
