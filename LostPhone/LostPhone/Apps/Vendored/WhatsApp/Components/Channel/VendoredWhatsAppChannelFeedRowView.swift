//
//  ChannelRowView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 10/4/24.
//

import SwiftUI
import Kingfisher

struct VendoredWhatsAppChannelFeedRowView: View {
    var channelFeedResponse: VendoredWhatsAppChannelFeedResponse
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            HStack (spacing: 14){
                Image(channelFeedResponse.channel.profileUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.gray.opacity(0.4)))
                Text(channelFeedResponse.channel.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack (spacing: 6){
                Text(channelFeedResponse.caption)
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(3)
               Spacer()
               KFImage(URL(string: channelFeedResponse.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80,height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }
            Text(channelFeedResponse.timeAgo)
                .font(.footnote)
                .foregroundStyle(.black.opacity(0.5))
                .lineLimit(3)
                .padding(.top,-12)
            
        }
    }
}

#Preview {
    VendoredWhatsAppChannelFeedRowView(channelFeedResponse: channelFeedData[1])
}
