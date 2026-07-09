//
//  MessageData.swift
//  LinkedIn Clone
//  Created by Sopheamen VAN on 24/4/24.
//

import Foundation


let messagesData: [MessageResponse] = [
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[0],
        text: "Hey, just saw your new post on SwiftUI! Amazing work!",
        badgeNumber: 3,
        dateAgo: "8:35 am"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[1],
        text: "Can we meet tomorrow to discuss the UI/UX updates?",
        badgeNumber: 1,
        dateAgo: "9:00 am"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[2],
        text: "Reminder: Your subscription to our newsletter is expiring soon.",
        badgeNumber: 0,
        dateAgo: "Mon"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[3],
        text: "Are you attending the webinar on digital marketing this Friday?",
        badgeNumber: 2,
        dateAgo: "Tue"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[4],
        text: "New project alert: Let's brainstorm the initial concepts next week.",
        badgeNumber: 5,
        dateAgo: "Apr 12"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[5],
        text: "Great job on the presentation today, really insightful!",
        badgeNumber: 4,
        dateAgo: "5:10 pm"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[6],
        text: "Could you send over the files for the last project? Thanks!",
        badgeNumber: 2,
        dateAgo: "Yesterday"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[7],
        text: "Please review the draft I sent you before the meeting.",
        badgeNumber: 0,
        dateAgo: "8:45 am"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[8],
        text: "Reminder: Your appointment is scheduled for tomorrow at 3:00 pm.",
        badgeNumber: 1,
        dateAgo: "Last week"
    ),
    MessageResponse(
        id: UUID(),
        user: userLinkedInData[9],
        text: "We need to update our strategy based on the recent market trends.",
        badgeNumber: 3,
        dateAgo: "Apr 10"
    )
]
