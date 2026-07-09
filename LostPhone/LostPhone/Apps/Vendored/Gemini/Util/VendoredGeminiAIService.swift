//
//  VendoredGeminiAIService.swift
//  Youtube_Gemini_clone
//
//  Created by Sopheamen VAN on 3/2/25.
//
import Foundation

// generate key from this offical google https://ai.google.dev/
let API_KEY = "AIzaSyCex-wJXzhSS70xcMahtxsl1cC-jp8nbqk" // can replace your own api key

// Service Manager for API requests
class VendoredGeminiAIService {
    static func fetchAIContent(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(API_KEY)")!
        let parameters: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard
                let data,
                let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let candidates = jsonResponse["candidates"] as? [[String: Any]],
                let content = candidates.first?["content"] as? [String: Any],
                let parts = content["parts"] as? [[String: Any]],
                let text = parts.first?["text"] as? String
            else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])))
                return
            }
            completion(.success(text))
        }.resume()
        return
    }
}
