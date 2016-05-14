//
//  DataContext.swift
//  Quesee
//
//  Created by Adbeel on 5/21/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import AlecrimCoreData

let dataContext = DataContext()

extension DataContext {
    var users:      Table<User>     { return Table<User>(dataContext: self) }
    var contacts: Table<Contact> { return Table<Contact>(dataContext: self) }
}