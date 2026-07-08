//
//  VendoredSpotifyUserStore.swift
//  SwiftUIClones
//
//  Created by ladans on 17/08/25.
//

import Foundation
import Combine

class VendoredSpotifyUserStore: ObservableObject {
    @Published var currentUser: VendoredSpotifyUser?
    
    init() {
        Task {
            await getUser()
        }
    }
    
    private func getUser() async {
        let (error, result) = await VendoredSpotifyService().getUsers()
        
        if let error = error {
            print("Failed to fetch users: \(error.message)")
        } else if let data = result {
            currentUser = data.users[3]
        }
    }
}
