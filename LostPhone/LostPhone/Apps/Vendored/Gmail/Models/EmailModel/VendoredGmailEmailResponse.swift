//
//  VendoredGmailEmailResponse.swift
//  Youtube_Gmail
//
//  Created by Sopheamen VAN on 7/10/24.
//

import Foundation

struct VendoredGmailEmailResponse: Identifiable {
    let id = UUID()
    let profileUrl: String // can be user or company profile
    let toAndCC: String // for eg Jiho, me, Marina, Jian Jie Liau or company name
    let subject: String
    let dateAgo: String // for eg 1:27 PM, Oct 26
    let isStarred: Bool // default is false
    let attachments: [String] // for pdfs or images or empty
    let description: String 
}
