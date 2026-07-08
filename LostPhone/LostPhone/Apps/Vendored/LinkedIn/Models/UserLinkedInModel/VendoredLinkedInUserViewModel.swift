//
//  RecommendedForYouData.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 23/4/24.
//

import Foundation

class VendoredLinkedInUserViewModel: ObservableObject {
    @Published var recommendedUsers: [VendoredLinkedInUserLinkedInResponse] = []
    @Published var peopleSkilledUsers:[VendoredLinkedInUserLinkedInResponse] = []
    @Published var groupInterestedIn:[VendoredLinkedInUserLinkedInResponse] = []
    @Published var suggestionUsers:[VendoredLinkedInUserLinkedInResponse] = []
    
    init() {
        loadRecommendedUsers()
        loadPeopleSkilledUsers()
        loadGroupInterestedIn()
        loadSuggestionUsers()
    }
    
    func loadRecommendedUsers() {
        if userLinkedInData.count >= 3 {
            recommendedUsers = Array(userLinkedInData.shuffled().prefix(3))
        } else {
            recommendedUsers = userLinkedInData
        }
    }
    
    func loadPeopleSkilledUsers(){
        let filteredUsers = userLinkedInData.filter {$0.type == 1}
        if filteredUsers.count >= 2 {
            peopleSkilledUsers = Array(filteredUsers.shuffled().prefix(2))
        } else {
            peopleSkilledUsers = filteredUsers
        }
    }
    
    func loadGroupInterestedIn(){
        let filteredUsers = userLinkedInData.filter {$0.type == 2}
        
        if filteredUsers.count >= 4 {
            groupInterestedIn = Array(filteredUsers.shuffled().prefix(4))
        } else {
            groupInterestedIn = filteredUsers
        }
    }
    
    func loadSuggestionUsers(){
        let filteredUsers = userLinkedInData.filter {$0.type == 1}
        
        if filteredUsers.count >= 6 {
            suggestionUsers = Array(filteredUsers.shuffled().prefix(6))
        }else {
            suggestionUsers = filteredUsers
        }
        
    }
}
