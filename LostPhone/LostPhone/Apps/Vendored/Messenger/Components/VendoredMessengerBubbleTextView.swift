//
//  VendoredMessengerBubbleTextView.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 17/9/24.
//

import SwiftUI

struct VendoredMessengerBubbleTextView:View {
    var chatDetails:VendoredMessengerChatDetailResponse
    var textColor: Color?
    var backgroundColor: Color?
    var body: some View {
        Text(chatDetails.text)
            .font(.subheadline)
            .padding(.vertical,8)
            .padding(.horizontal,12)
            .foregroundStyle(textColor ?? .white)
            .background(backgroundColor ?? Color.vendoredMessengerBuubleBlueColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    VendoredMessengerBubbleTextView(chatDetails: chatDetailData[0], textColor: .black, backgroundColor: Color.vendoredMessengerBubbleGrayColor)
}
