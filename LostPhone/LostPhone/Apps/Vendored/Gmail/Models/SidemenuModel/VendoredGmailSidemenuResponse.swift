//
//  VendoredGmailSidemenuResponse.swift
//  Youtube_Gmail
//
//  Created by Sopheamen VAN on 7/10/24.
//

import Foundation
import SwiftUI

struct VendoredGmailSidemenuResponse: Identifiable {
    var id = UUID()
    var title: String
    var titleColor: Color?
    var icon: String
    var badge: String?
    var badgeColor: Color?
    var backgroundColor: Color?
}
