//
//  MessageDetailData.swift
//  LinkedIn Clone
//
//  Created by Sopheamen VAN on 2/5/24.
//

import Foundation

let messagesDetailData: [VendoredLinkedInMessageDetailResponse] = [
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Hey, how are you doing?",
        isMe: true,
        time: "09:45 AM"  // Example time format
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "I'm good, thanks for asking!",
        isMe: false,
        time: "09:46 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Have you completed the project?",
        isMe: true,
        time: "10:15 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Yes, I sent it to your email.",
        isMe: false,
        time: "10:16 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Awesome, I'll check it out.",
        isMe: true,
        time: "10:20 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
            id: UUID(),
            text: "I reviewed it, great job on the details!",
            isMe: false,
            time: "10:25 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Thanks for the feedback! I'm thinking of adding a section that elaborates on the environmental impact. It would involve a deeper analysis but could provide substantial value to our argument. What do you think?",
        isMe: true,
        time: "10:30 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "That sounds like a great idea! Ensuring our report addresses the environmental aspects thoroughly could set it apart. Let's definitely include that. Do you need any specific data or references for this?",
        isMe: false,
        time: "10:35 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Yes, if you could send over the latest data from the environmental studies we had last quarter, that would help. I'll integrate those findings into the draft.",
        isMe: true,
        time: "10:40 AM"
    ),
    VendoredLinkedInMessageDetailResponse(
        id: UUID(),
        text: "Perfect, I'll compile the data and send it your way shortly. Let's discuss more over a call later to finalize the details and next steps.",
        isMe: false,
        time: "10:45 AM"
    )
]
