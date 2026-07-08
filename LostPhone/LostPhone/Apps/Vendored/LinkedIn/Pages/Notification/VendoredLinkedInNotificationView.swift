//
//  VendoredLinkedInNotificationView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 25/4/24.
//

import SwiftUI

struct VendoredLinkedInNotificationView: View {
    
    let notificationDatas:[VendoredLinkedInNotificationResponse] = notificationsData

    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 20){
                    ForEach(notificationDatas) { notification in
                        VendoredLinkedInNotificationRowView(notification: notification)
                    }
                }
                .padding(.vertical, 10)
              
            }
           
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.vendoredLinkedInNotificationBackgroundColor)
            
        }
    }
}

#Preview {
    VendoredLinkedInNotificationView()
}

struct VendoredLinkedInNotificationRowView:View {
    let notification: VendoredLinkedInNotificationResponse
    var body: some View {
        HStack (spacing: VendoredLinkedInAppSetting.smallPadding){
            
            HStack(alignment: .top,spacing:12) {
                Circle()
                    .fill(Color.vendoredLinkedInVendoredLinkedInPrimary)
                    .frame(width: 8, height: 8)
                    .offset(y: 25)
                
                if notification.user.type == 1{
                    VendoredLinkedInProfileImageView(profileImage: notification.user.profileImage, size: 55)
                }else {
                    VendoredLinkedInProfileImageRectangleView(profileImage: notification.user.profileImage, size: 55)
                }
                
                VStack (alignment: .leading,spacing: VendoredLinkedInAppSetting.smallPadding){
                    Text(notification.title)
                        .font(.subheadline)
                        .lineLimit(2)
                    if notification.buttonType == 1{
                        Button {
                            
                        }label: {
                            Text("View 30+ Jobs")
                                .font(.subheadline)
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                        }
                    } else if notification.buttonType == 2 {
                        Button {
                            
                        }label: {
                            Text("Message")
                                .font(.subheadline)
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.vendoredLinkedInVendoredLinkedInPrimary))
                        }
                    }
                }
            }
            Spacer()
            VStack (spacing:10){
                Text(notification.timeAgo)
                    .font(.footnote)
                    .foregroundStyle(.black.opacity(0.7))
                Image(systemName: "ellipsis")
                    .foregroundStyle(.black.opacity(0.7))
            }
        }
        .padding(.horizontal)
        
    }
}
