//
//  ProfileSettingView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 19/3/24.
//

import SwiftUI

struct ProfileSettingView: View {
   
    var body: some View {
        ScrollView {
            VStack (spacing: 14){
                ListileSetting(icon: "setting_icon", title: "Settings and privacy", isNewBadgeIcon: false)
                ListileSetting(icon: "comment_icon", title: "Threads" , isNewBadgeIcon: true)
                ListileSetting(icon: "activity_icon", title: "Your activity", isNewBadgeIcon: false )
                ListileSetting(icon: "archive_icon", title: "Archive", isNewBadgeIcon: false )
                ListileSetting(icon: "qrcode_icon", title: "QR code", isNewBadgeIcon: false )
                ListileSetting(icon: "save_icon", title: "Saved", isNewBadgeIcon: false )

                ListileSetting(icon: "close_friends_icon", title: "Close Friends", isNewBadgeIcon: false )
            }
        }
        .padding(.top,40)
        .padding(.horizontal)
    }
}

#Preview {
    ProfileSettingView()
}
