//
//  DatabaseHelper.swift
//  SwiftUIPractice
//
//  Created by Developer on 02/07/25.
//

import Foundation

struct VendoredSpotifyService {
    let httpClient: VendoredSpotifyHttpClient = VendoredSpotifyHttpClient()
    var request: VendoredSpotifyHttpRequest = VendoredSpotifyHttpRequest(baseURL: "https://dummyjson.com/")
    
    func getProdcuts() async -> Either<VendoredSpotifyProductArray> {
        return await httpClient.send(
            request
                .path("products")
                .method(.GET),
            responseType: VendoredSpotifyProductArray.self
        )
    }
    
    func getUsers() async -> Either<VendoredSpotifyUserArray> {
        return await httpClient.send(
            request
                .path("users")
                .method(.GET),
            responseType: VendoredSpotifyUserArray.self
        )
    }
}
