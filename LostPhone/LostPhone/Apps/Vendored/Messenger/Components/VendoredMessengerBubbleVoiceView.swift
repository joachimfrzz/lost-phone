//
//  VendoredMessengerBubbleVoiceView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI

struct VendoredMessengerBubbleVoiceView:View {
    var chatDetails:VendoredMessengerChatDetailResponse
    var textColor: Color?
    var backgroundColor: Color?
    var body: some View {
        HStack {
            // Play button
            Button(action: {
                // Play action
            }) {
                Image(systemName: "play.fill")
                    .foregroundColor(textColor ?? .white)
                    .padding(10)
            }
            
            // Waveform representation (simulated with rounded rectangles)
            HStack(spacing: 2) {
                ForEach(0..<20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 1)
                        .fill(textColor ?? Color.white)
                        .frame(width: CGFloat.random(in: 2...4), height: CGFloat.random(in: 10...20))
                }
            }
            
            // Duration label
            Text(chatDetails.duration ?? "0:00")
                .font(.subheadline)
                .foregroundColor(textColor ?? .white)
                .padding(.trailing, 10)
        }
        .padding(.vertical,8)
        .padding(.horizontal,12)
        .background(backgroundColor ?? Color.vendoredMessengerBuubleBlueColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VendoredMessengerBubbleVoiceView(chatDetails: chatDetailData[5])
}
