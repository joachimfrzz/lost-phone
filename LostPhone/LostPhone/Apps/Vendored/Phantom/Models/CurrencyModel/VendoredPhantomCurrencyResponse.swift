//
//  VendoredPhantomCurrencyResponse.swift
//  Youtube_Phantom_clone
//
//  Created by Sopheamen VAN on 13/3/25.
//

import Foundation

struct VendoredPhantomCurrencyResponse: Identifiable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var symbol: String
    var network: String
    var rate: String
    var amount: String
    var subAmount: String
    var type: Int // 1 for positive change, 0 for negative change
    var totalBalance: String
    var totalChange: String
    var totalChangeType: Int // 1 for positive change, 0 for negative change
    var percentageChange: String
    var marketCap: String
    var totalSupply: String
    var circulatingSupply: String
    var maxSupply: String
    var about: String 
}

