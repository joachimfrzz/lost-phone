//
//  NotificationView.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 25/4/24.
//

import SwiftUI

struct NotificationView: View {
    
    let notificationDatas:[NotificationResponse] = notificationsData

    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 20){
                    ForEach(notificationDatas) { notification in
                        NotificationRowView(notification: notification)
                    }
                }
                .padding(.vertical, 10)
              
            }
           
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.notificationBackgroundColor)
            
        }
    }
}

#Preview {
    NotificationView()
}

struct NotificationRowView:View {
    let notification: NotificationResponse
    var body: some View {
        HStack (spacing: AppSetting.smallPadding){
            
            HStack(alignment: .top,spacing:12) {
                Circle()
                    .fill(Color.primaryColor)
                    .frame(width: 8, height: 8)
                    .offset(y: 25)
                
                if notification.user.type == 1{
                    ProfileImageView(profileImage: notification.user.profileImage, size: 55)
                }else {
                    ProfileImageRectangleView(profileImage: notification.user.profileImage, size: 55)
                }
                
                VStack (alignment: .leading,spacing: AppSetting.smallPadding){
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
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
                        }
                    } else if notification.buttonType == 2 {
                        Button {
                            
                        }label: {
                            Text("Message")
                                .font(.subheadline)
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.primaryColor))
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
