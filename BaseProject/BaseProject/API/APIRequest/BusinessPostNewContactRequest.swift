//
//  BusinessPostNewContactRequest.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import ObjectMapper

class BusinessPostNewContactRequest: BaseModel {
    
    var business_id: String?
    var name: String?
    var email: String?
    var phone: String?
    var content: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        business_id <- map["business_id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        content <- map["content"]
    }
    
}
