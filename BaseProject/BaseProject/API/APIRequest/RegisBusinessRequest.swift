//
//  RegisBusinessRequest.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class RegisBusinessRequest: BaseModel {
    
    var username: String?
    var email: String?
    var password: String?
    var password_confirmation: String?
    var name: String?
    var branch: String?
    var province: String?
    var address: String?
    var phone: String?
    var website: String?
    var avatar: Any?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        username <- map["username"]
        email <- map["email"]
        password <- map["password"]
        password_confirmation <- map["password_confirmation"]
        name <- map["name"]
        branch <- map["branch"]
        province <- map["province"]
        address <- map["address"]
        phone <- map["phone"]
        website <- map["website"]
        avatar <- map["avatar"]
    }
    
}
