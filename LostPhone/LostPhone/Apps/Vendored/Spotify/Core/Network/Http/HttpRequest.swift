//
//  VendoredSpotifyHttpRequest.swift
//  SpotifySwiftUI
//
//  Created by ladans on 27/08/25.
//

import Foundation

struct VendoredSpotifyHttpRequest: Sendable {
    let baseURL: String
    
    var request: URLRequest {
        URLRequest(url: URL(string: baseURL)!)
    }
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}

extension VendoredSpotifyHttpRequest {
    func path(_ path: String) -> URLRequest {
        var req = request
        req.url = req.url!.appendingPathComponent(path)
        return req
    }
}

extension URLRequest {
    func method(_ method: VendoredSpotifyHttpMethod) -> URLRequest {
        var req = self
        req.httpMethod = method.method
        return req
    }
    
    func body(_ body: Data?) -> URLRequest {
        var req = self
        req.httpBody = body
        return req
    }
    
    func headers(_ headers: Dictionary<String, String>) -> URLRequest {
        var req = self
        for (key, value) in headers {
            req.setValue(value, forHTTPHeaderField: key)
        }
        return req
    }
}
