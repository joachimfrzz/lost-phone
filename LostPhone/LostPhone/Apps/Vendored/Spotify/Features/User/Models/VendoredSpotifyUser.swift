//
//  VendoredSpotifyUser.swift
//  SwiftUIPractice
//
//  Created by Developer on 02/07/25.
//

import Foundation

struct VendoredSpotifyUserArray: Codable {
    let users: [VendoredSpotifyUser]
    let total, skip, limit: Int
}

struct VendoredSpotifyUser: Codable, Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender: VendoredSpotifyGender
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height, weight: Double
    let eyeColor: String
    let hair: VendoredSpotifyHair
    let ip: String
    let address: VendoredSpotifyAddress
    let macAddress, university: String
    let bank: VendoredSpotifyBank
    let company: VendoredSpotifyCompany
    let ein, ssn, userAgent: String
    let crypto: VendoredSpotifyCrypto
    let role: VendoredSpotifyRole
}




















