//
//  ContactApi.swift
//  Quesee
//
//  Created by Adbeel on 5/21/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import JSONJoy

struct ContactApi : JSONJoy {
    var contactId: String
    var userId: String
    var label: Int
    var enabled: Int
    
    init(_ decoder: JSONDecoder) {
        contactId = decoder["contactId"].string!
        userId = decoder["userId"].string!
        label = decoder["label"].integer!
        enabled = decoder["enabled"].integer!
    }
}
