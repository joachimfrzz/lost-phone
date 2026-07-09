//
//  AIService.swift
//  Youtube_Gemini_clone
//
//  Created by Sopheamen VAN on 3/2/25.
//
import SwiftUI
import Alamofire

// generate key from this offical google https://ai.google.dev/
let API_KEY = "AIzaSyCex-wJXzhSS70xcMahtxsl1cC-jp8nbqk" // can replace your own api key

// Service Manager for API requests
class AIService {
    static func fetchAIContent(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(API_KEY)"
        let parameters: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]  // Using the dynamic prompt
                    ]
                ]
            ]
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let jsonResponse = data as? [String: Any],
                       let candidates = jsonResponse["candidates"] as? [[String: Any]],
                       let content = candidates.first?["content"] as? [String: Any],
                       let parts = content["parts"] as? [[String: Any]],
                       let text = parts.first?["text"] as? String {
                        completion(.success(text)) // Return the fetched text on success
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])))
                    }
                case .failure(let error):
                    completion(.failure(error)) // Return the error if the request fails
                }
            }
    }
}
