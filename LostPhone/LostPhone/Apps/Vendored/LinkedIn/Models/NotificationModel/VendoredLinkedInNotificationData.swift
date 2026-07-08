//
//  NotificationData.swift
//  LinkedIn Clone
//  Created by Sopheamen VAN on 24/4/24.

import Foundation

let notificationsData: [VendoredLinkedInNotificationResponse] = [
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[1],
        title: "Alice Johnson has just posted a new blog on iOS Development",
        buttonType: 2,
        timeAgo: "16h"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[2],
        title: "Your connection Bob Smith has started a new job",
        buttonType: 1,
        timeAgo: "1d"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[3],
        title: "Check out the latest iOS updates today",
        buttonType: 0,
        timeAgo: "2d"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[0],
        title: "Don't miss our upcoming webinar on SwiftUI",
        buttonType: 0,
        timeAgo: "3d"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[4],
        title: "A message from your group 'Swift Developers'",
        buttonType: 2,
        timeAgo: "1w"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[0],
        title: "Explore new features in the latest Android update",
        buttonType: 0,
        timeAgo: "20h"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[2],
        title: "Fiona Chen shared a new article on data science trends",
        buttonType: 2,
        timeAgo: "1d"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[3],
        title: "Join Henry Wade in a live coding session this Friday",
        buttonType: 1,
        timeAgo: "12h"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[4],
        title: "Reminder: Your yearly subscription is about to renew",
        buttonType: 0,
        timeAgo: "2d"
    ),
    VendoredLinkedInNotificationResponse(
        id: UUID(),
        user: userLinkedInData[6],
        title: "Last chance to sign up for our exclusive webinar on UX design",
        buttonType: 1,
        timeAgo: "3d"
    )
]
