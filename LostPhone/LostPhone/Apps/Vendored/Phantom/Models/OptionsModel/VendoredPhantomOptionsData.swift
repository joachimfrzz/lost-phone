//
//  OptionsData.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 13/3/25.
//

import Foundation

let optionsData: [VendoredPhantomOptionsResponse] = [
    VendoredPhantomOptionsResponse(title: "Receive", icon: "qrcode"), // Using SF Symbol for QR code
    VendoredPhantomOptionsResponse(title: "Send", icon: "paperplane.fill"),
    VendoredPhantomOptionsResponse(title: "Swap", icon: "arrow.left.arrow.right"),
    VendoredPhantomOptionsResponse(title: "Buy", icon: "dollarsign.circle")
]

let optionsDetailData: [VendoredPhantomOptionsResponse] = [
    VendoredPhantomOptionsResponse( title: "Receive",icon: "qrcode", size: 22),
    VendoredPhantomOptionsResponse(title: "Buy",icon: "dollarsign", size: 16),
    VendoredPhantomOptionsResponse(title: "Share",icon: "square.and.arrow.up", size: 22),
    VendoredPhantomOptionsResponse(title: "More",icon: "ellipsis", size: 5)
]
