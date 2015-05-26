//
//  ConversationApi.swift
//  Quesee
//
//  Created by Adbeel on 5/20/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import JSONJoy

struct ConversationApi : JSONJoy {
    var conversationId: String
    var userIds: Array<String>?
    var occurred: Double
    var lastMessage: MessageApi?
    
    init(_ decoder: JSONDecoder) {
        conversationId = decoder["conversationId"].string!
        decoder.getArray(&userIds)
        occurred = decoder["occurred"].double!
        lastMessage = MessageApi(decoder["lastMessage"])
    }
}