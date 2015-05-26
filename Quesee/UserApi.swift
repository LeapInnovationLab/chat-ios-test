//
//  UserApi.swift
//  Quesee
//
//  Created by Adbeel on 5/19/15.
//  Copyright (c) 2015 Quesee Inc. All rights reserved.
//

import Foundation
import JSONJoy
import Alamofire

struct UserApi : JSONJoy {
    var userId: String!
    var firstName: String!
    var lastName: String!
    var avatar: String!
    var conversationCount: Int?
    var contactCount: Int?
    var paymentCount: Int?
    //var billingAddress: Address?
    
    init() {
    }
    
    init(_ decoder: JSONDecoder) {
        userId = decoder["userId"].string
        firstName = decoder["firstName"].string
        lastName = decoder["lastName"].string
        avatar = decoder["avatar"].string
        conversationCount = decoder["conversationCount"].integer
        contactCount = decoder["contactCount"].integer
        paymentCount = decoder["paymentCount"].integer
    }
    
    func toUser() -> User {
        // Save or update loggedin user locally
        let user = dataContext.users.firstOrCreated(whereAttribute: "userId", isEqualTo: self.userId)
        user.firstName = firstName
        user.lastName = lastName
        user.avatar = avatar
        dataContext.save()
        return user
    }
    
    static func get(userId: String, completionBlock: (User?) -> ()) {
        Alamofire.request(.GET, "https://dev.quesee.co/v1/users/\(userId)")
            .response { (request, response, data, error) in
                if response?.statusCode == 200 {
                    let datax = data as! NSData
                    let user = UserApi(JSONDecoder(datax)).toUser()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionBlock(user)
                    })
                } else if response?.statusCode == 400 {
                    account.accessToken = nil
                } else {
                    // manage other errors (500)
                }
                
        }
    }
}