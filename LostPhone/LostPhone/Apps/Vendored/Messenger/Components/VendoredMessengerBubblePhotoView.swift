//
//  VendoredMessengerBubblePhotoView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI
import Kingfisher

struct VendoredMessengerBubblePhotoView: View {
    var chatDetails:VendoredMessengerChatDetailResponse
    var body: some View {
        KFImage(URL(string: chatDetails.mediaUrl ?? ""))
            .resizable()
            .scaledToFill()
            .frame(width: 180, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VendoredMessengerBubblePhotoView(chatDetails:  chatDetailData[8])
}
