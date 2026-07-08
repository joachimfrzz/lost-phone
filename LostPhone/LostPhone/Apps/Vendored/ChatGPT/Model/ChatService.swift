//
//  VendoredChatGPTChatService.swift
//  chatGPT
//
//  Created by Adolfo Calderon on 1/12/24.
//

import Foundation

class VendoredChatGPTChatService {
    // Define any dependencies, like URLSession
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchAPIData(_ prompt: String) async throws -> VendoredChatGPTChatGPTResponse {
        // Build the URL and Request
        let request = try buildRequest(for: prompt)
        return try await performRequest(request)
    }

    private func buildRequest(for prompt: String) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Prepare the header
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "API_KEY not found"])
        }
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Prepare the request body
        let chatRequest = VendoredChatGPTChatGPTRequest(model: "gpt-3.5-turbo", messages: [VendoredChatGPTChatGPTRequest.VendoredChatGPTMessage(role: "system", content: prompt)], maxTokens: 500)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(chatRequest)

        return request
    }


    private func performRequest(_ request: URLRequest) async throws -> VendoredChatGPTChatGPTResponse {
        let (data, response) = try await URLSession.shared.data(for: request)

        // Check for valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        // Decode the JSON response
        return try JSONDecoder().decode(VendoredChatGPTChatGPTResponse.self, from: data)
    }

}

// Structure to define the request format
struct VendoredChatGPTChatGPTRequest: Encodable {
    let model: String
    let messages: [VendoredChatGPTMessage]
    let maxTokens: Int

    struct VendoredChatGPTMessage: Encodable {
        let role: String
        let content: String
    }

    enum VendoredChatGPTCodingKeys: String, CodingKey {
        case model, messages
        case maxTokens = "max_tokens"
    }
}

// Structure to decode the response
struct VendoredChatGPTChatGPTResponse: Decodable {
    let id: String
    let choices: [VendoredChatGPTChoice]
    
    struct VendoredChatGPTChoice: Decodable {
        let message: VendoredChatGPTMessage
    }

    struct VendoredChatGPTMessage: Decodable {
        let role: String
        let content: String
    }
}
