//
//  VendoredGeminiAIService.swift
//

import Foundation

/// Réponses simulées hors-ligne pour LPSP (Notion : Gemini doit répondre).
class VendoredGeminiAIService {
    static func fetchAIContent(prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let trimmed = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
            let reply: String
            switch trimmed.lowercased() {
            case let p where p.contains("mail") || p.contains("message"):
                reply = "Check the **Messages** and **Mail** apps — look for threads from the last 48 hours and any unsent drafts."
            case let p where p.contains("photo") || p.contains("image"):
                reply = "Open **Photos** and sort by **Recents**. Deleted items may still appear in **Recently Deleted** for 30 days."
            case let p where p.contains("uber") || p.contains("trajet"):
                reply = "In **Uber**, open **Activity** for ride history. Note pickup/drop-off addresses and timestamps."
            default:
                reply = """
                Here's what I found for "\(trimmed)":

                1. Cross-check **Contacts** and recent **calls**.
                2. Search **Safari** history for related URLs.
                3. Review **Calendar** events around the same date.

                Want me to narrow this down to a specific person or date?
                """
            }
            completion(.success(reply))
        }
    }
}
