//
//  Exception.swift
//  SpotifySwiftUI
//
//  Created by ladans on 27/08/25.
//

import Foundation

extension VendoredSpotifyFailure: LocalizedError {
    var errorDescription: String? {
        self.message
    }
}

enum VendoredSpotifyFailure: Error {
    case server(code: Int? = nil, error: Error? = nil),
         cache(message: String)
    
    var message: String {
        switch self {
        case .server(code: let code, error: let error):
            if error == nil {
                switch code {
                case 400:
                    return "Bad Request"
                case 403:
                    return "Forbidden"
                case 404:
                    return "Not Found"
                case 0:
                    return "Unknown Error"
                default:
                    return "Server Error"
                }
            }
            
            return error!.localizedDescription
            
        case .cache(message: let message):
            return message
        }
    }
}
