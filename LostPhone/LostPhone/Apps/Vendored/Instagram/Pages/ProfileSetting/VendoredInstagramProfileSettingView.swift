//
//  VendoredInstagramProfileSettingView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 19/3/24.
//

import SwiftUI

struct VendoredInstagramProfileSettingView: View {
   
    var body: some View {
        ScrollView {
            VStack (spacing: 14){
                VendoredInstagramListileSetting(icon: "setting_icon", title: "Settings and privacy", isNewBadgeIcon: false)
                VendoredInstagramListileSetting(icon: "comment_icon", title: "Threads" , isNewBadgeIcon: true)
                VendoredInstagramListileSetting(icon: "activity_icon", title: "Your activity", isNewBadgeIcon: false )
                VendoredInstagramListileSetting(icon: "archive_icon", title: "Archive", isNewBadgeIcon: false )
                VendoredInstagramListileSetting(icon: "qrcode_icon", title: "QR code", isNewBadgeIcon: false )
                VendoredInstagramListileSetting(icon: "save_icon", title: "Saved", isNewBadgeIcon: false )

                VendoredInstagramListileSetting(icon: "close_friends_icon", title: "Close Friends", isNewBadgeIcon: false )
            }
        }
        .padding(.top,40)
        .padding(.horizontal)
    }
}

#Preview {
    VendoredInstagramProfileSettingView()
}
