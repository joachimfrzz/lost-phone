//
//  VendoredMessengerBubbleVideoView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI
import Kingfisher
struct VendoredMessengerBubbleVideoView: View {
    var chatDetails:VendoredMessengerChatDetailResponse
    var body: some View {
        ZStack {
            KFImage(URL(string: chatDetails.mediaUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            // play
            Button {
                
            }label: {
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.1))
                        .frame(width: 45, height: 45)
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                    
                }
            }
        }
    }
}

#Preview {
    VendoredMessengerBubbleVideoView(chatDetails: chatDetailData[15])
}
