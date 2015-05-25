//
//  Contact.swift
//  Chats
//
//  Created by Adbeel on 5/21/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import CoreData

@objc(Contact)
class Contact: NSManagedObject {
    @NSManaged var contactId: String
    @NSManaged var userId: String
    @NSManaged var label: Int16
    @NSManaged var enabled: Int16
    
    func getUser() -> User! {
        return dataContext.users.filterBy(attribute: "userId", value: self.userId).first()
    }
}
