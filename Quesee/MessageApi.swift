//
//  MessageApi.swift
//  Quesee
//
//  Created by Adbeel on 5/20/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import JSONJoy

struct MessageApi : JSONJoy {
    var messageId: String
    var occurred: Double
    var userId: String
    var type: Int!
    var content: String
    
    init(_ decoder: JSONDecoder) {
        messageId = decoder["messageId"].string!
        occurred = decoder["occurred"].double!
        userId = decoder["userId"].string!
        type = decoder["type"].integer
        content = decoder["content"].string!
    }
}