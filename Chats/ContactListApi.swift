//
//  ContactListApi.swift
//  Chats
//
//  Created by Adbeel on 5/21/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import JSONJoy

struct ContactListApi : JSONJoy {
    var contacts: Array<ContactApi>
    
    init(_ decoder: JSONDecoder) {
        contacts = Array<ContactApi>()
        if let conts = decoder["contacts"].array {
            contacts = Array<ContactApi>()
            for contDecoder in conts {
                contacts.append(ContactApi(contDecoder))
            }
        }
    }
    
    func synchLocal() -> Void {
        for contact in contacts {
            let c = dataContext.contacts.firstOrCreated(whereAttribute: "contactId", isEqualTo: contact.contactId)
            c.userId = contact.userId
            c.label = Int16(contact.label)
            c.enabled = Int16(contact.enabled)
            UserApi.get(c.userId, completionBlock: {(user) -> () in
                // Do something
                println("# User, Now: \(dataContext.users.count())")
            })
        }
        dataContext.save()
    }
}
