//
//  VendoredLinkedInJobResponse.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 16/5/24.
//

import Foundation


struct VendoredLinkedInJobResponse: Hashable, Identifiable {
    var id: UUID
    var jobTitle: String
    var companyLogoUrl: String
    var companyName: String
    var location: String
    var salaryRange: String
    var subTitle: String
}
