//
//  OptionsData.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 13/3/25.
//

import Foundation

let optionsData: [OptionsResponse] = [
    OptionsResponse(title: "Receive", icon: "qrcode"), // Using SF Symbol for QR code
    OptionsResponse(title: "Send", icon: "paperplane.fill"),
    OptionsResponse(title: "Swap", icon: "arrow.left.arrow.right"),
    OptionsResponse(title: "Buy", icon: "dollarsign.circle")
]

let optionsDetailData: [OptionsResponse] = [
    OptionsResponse( title: "Receive",icon: "qrcode", size: 22),
    OptionsResponse(title: "Buy",icon: "dollarsign", size: 16),
    OptionsResponse(title: "Share",icon: "square.and.arrow.up", size: 22),
    OptionsResponse(title: "More",icon: "ellipsis", size: 5)
]
