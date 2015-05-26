//
//  DataContext.swift
//  Quesee
//
//  Created by Adbeel on 5/21/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import AlecrimCoreData

let dataContext = DataContext()!

final class DataContext: AlecrimCoreData.Context {
    var users:    AlecrimCoreData.Table<User>    { return AlecrimCoreData.Table<User>(context: self) }
    var contacts: AlecrimCoreData.Table<Contact> { return AlecrimCoreData.Table<Contact>(context: self) }
}