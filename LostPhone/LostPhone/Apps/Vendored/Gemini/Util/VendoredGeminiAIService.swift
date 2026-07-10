//
//  VendoredGeminiAIService.swift
//

import Foundation

/// Réponses simulées hors-ligne pour LPSP (Notion : Gemini doit répondre).
class VendoredGeminiAIService {
    static func fetchAIContent(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let trimmed = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let reply: String
            switch trimmed.lowercased() {
            case let p where p.contains("mail") || p.contains("message"):
                reply = "Check the **Messages** and **Mail** apps — look for threads from the last 48 hours."
            case let p where p.contains("photo") || p.contains("image"):
                reply = "Open **Photos** and sort by **Recents**. Deleted items may still appear in **Recently Deleted**."
            default:
                reply = """
                Here’s what I found for “\(trimmed)”:

                1. Cross-check **Contacts** and recent **calls**.
                2. Search **Safari** history for related URLs.
                3. Review **Calendar** events around the same date.
                """
            }
            completion(.success(reply))
        }
    }
}
