//
//  VendoredSpotifyProductStore.swift
//  SwiftUIClones
//
//  Created by ladans on 15/08/25.
//

import Foundation
import Combine

class VendoredSpotifyProductStore: ObservableObject {
    @Published var products: [VendoredSpotifyProduct] = []
    
    init()  {
        Task {
            await getProducts()
        }
    }
    
    private func getProducts() async {
        let (error, result) = await VendoredSpotifyService().getProdcuts()
        if let productsArray = result {
            products = Array(productsArray.products.prefix(8))
        } else if let error = error {
            print("Failed to fetch products: \(error.message)")
        }
    }
}
