//
//  ErrorApi.swift
//  Quesee
//
//  Created by Adbeel on 5/19/15.
//  Copyright (c) 2015 Acani Inc. All rights reserved.
//

import Foundation
import JSONJoy

struct ErrorApi : JSONJoy {
    var errorCode: Int?
    var errorMessage: String?
    
    init() {
    }
    
    init(_ decoder: JSONDecoder) {
        errorCode = decoder["errorCode"].integer
        errorMessage = decoder["errorMessage"].string
    }
}
