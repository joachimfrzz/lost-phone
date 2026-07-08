//
//  VendoredNetflixAPIError.swift
//  Notflix
//
//  Created by Quentin Eude on 26/01/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//
protocol LocalizedError: Error {
    var localizedDescription: String { get }
}
enum VendoredNetflixAPIError: LocalizedError {
    case encoding
    case decoding
    case server(message: String)
    case invalidUrl
    case statusCode
    case invalidResponse

    var localizedDescription: String {
        switch self {
        case .encoding: return "VendoredNetflixAPIError while encoding"
        case .decoding: return "VendoredNetflixAPIError while decoding"
        case .server(let message): return "VendoredNetflixAPIError due to the server with message: \(message)"
        case .invalidUrl: return "VendoredNetflixAPIError invalidUrl"
        case .statusCode: return "VendoredNetflixAPIError status code error"
        case .invalidResponse: return "VendoredNetflixAPIError invalid response"
        }
    }
}
