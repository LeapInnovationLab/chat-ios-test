//
//  ConversationListApi.swift
//  Chats
//
//  Created by Adbeel on 5/20/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import JSONJoy

struct ConversationListApi : JSONJoy {
    var conversations: Array<ConversationApi>?
    init() {
    }
    init(_ decoder: JSONDecoder) {
        if let convs = decoder["conversations"].array {
            conversations = Array<ConversationApi>()
            for addrDecoder in convs {
                conversations?.append(ConversationApi(addrDecoder))
            }
        }
    }
    
    func toChats() -> [Chat] {
        var chats = [Chat]()
        if let conversationList = conversations {
            for conversation in conversationList {
                var content = ""
                var occurredDate = NSDate()
                if let lastMessage = conversation.lastMessage {
                    content = lastMessage.content
                    occurredDate = NSDate(timeIntervalSince1970: lastMessage.occurred)
                }
                //let chat = Chat(user: User.get(userID: ), lastMessageText: content, lastMessageSentDate: occurredDate)
                //chats.append(chat)
            }
        }
        return chats
    }
}