//
//  CallData.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 6/4/24.
//

import Foundation

// Generate call responses
let callData: [CallResponse] = [
    CallResponse(id: UUID(), user: userData[0], type: 1, callType: 2, time: "9:05 AM"),
    CallResponse(id: UUID(), user: userData[1], type: 2, callType: 1, time: "10:15 AM"),
    CallResponse(id: UUID(), user: userData[2], type: 3, callType: 2, time: "12:30 PM"),
    CallResponse(id: UUID(), user: userData[3], type: 1, callType: 1, time: "2:45 PM"),
    CallResponse(id: UUID(), user: userData[4], type: 2, callType: 2, time: "3:00 PM"),
    CallResponse(id: UUID(), user: userData[0], type: 3, callType: 1, time: "4:08 PM"),
    CallResponse(id: UUID(), user: userData[1], type: 1, callType: 2, time: "5:20 PM"),
    CallResponse(id: UUID(), user: userData[2], type: 2, callType: 1, time: "6:00 PM"),
    CallResponse(id: UUID(), user: userData[3], type: 3, callType: 2, time: "7:30 PM"),
    CallResponse(id: UUID(), user: userData[4], type: 1, callType: 1, time: "8:15 PM"),
    CallResponse(id: UUID(), user: userData[2], type: 2, callType: 1, time: "9:45 PM")
]

