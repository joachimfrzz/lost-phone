//
//  ChatDetailData.swift
//  Youtube_FacebookMessenger
//
//  Created by Sopheamen VAN on 14/9/24.
//

import Foundation

let chatDetailData: [ChatDetailResponse] = [
    ChatDetailResponse(isMe: true, chatType: 1, text: "Hey, how are you?", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 1, text: "I'm doing well, thanks!", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: true, chatType: 1, text: "What are you up to today?", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 1, text: "Just relaxing at home.", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: true, chatType: 1, text: "Sounds nice!", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 2, text: "", duration: "0:10", mediaUrl: nil), // Voice message 1
    ChatDetailResponse(isMe: true, chatType: 1, text: "Want to meet up later?", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 1, text: "Sure!", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: true, chatType: 3, text: "", duration: nil, mediaUrl: "https://images.unsplash.com/photo-1726338363658-82554516b959?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxM3x8fGVufDB8fHx8fA%3D%3D"), // Photo 1
    ChatDetailResponse(isMe: false, chatType: 1, text: "That looks great!", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: true, chatType: 1, text: "Thanks!", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 1, text: "What time are you free?", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: true, chatType: 1, text: "How about 3 PM?", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 2, text: "", duration: "0:12", mediaUrl: nil), // Voice message 2
    ChatDetailResponse(isMe: true, chatType: 1, text: "Let me know when you're on your way.", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 4, text: "", duration: nil, mediaUrl: "https://images.unsplash.com/photo-1726180839154-cc98e2df7f9b?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyN3x8fGVufDB8fHx8fA%3D%3D"), // Video 1
    ChatDetailResponse(isMe: true, chatType: 4, text: "", duration: nil, mediaUrl: "https://images.unsplash.com/photo-1717397488983-3f1ccd584c22?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxMDR8fHxlbnwwfHx8fHw%3D"), // Video 2
    ChatDetailResponse(isMe: true, chatType: 2, text: "", duration: "0:15", mediaUrl: nil), // Voice message 3
    ChatDetailResponse(isMe: false, chatType: 1, text: "On my way now.", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: true, chatType: 1, text: "Great, I'll be there in a bit.", duration: nil, mediaUrl: nil),
    ChatDetailResponse(isMe: false, chatType: 3, text: "", duration: nil, mediaUrl: "https://images.unsplash.com/photo-1726152781977-9b85df0111e9?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwzMHx8fGVufDB8fHx8fA%3D%3D")  // Photo 2
]

