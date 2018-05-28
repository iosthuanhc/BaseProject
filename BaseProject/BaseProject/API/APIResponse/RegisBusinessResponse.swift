//
//  RegisBusinessResponse.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class RegisBusinessResponse: BaseModel {
    
    var code : Int?
    var data : RegisBusinessResponseData?
    var status : Int?
    var message: String?
    
    override func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
        status <- map["status"]
        message <- map["message"]
    }
    
}

class RegisBusinessResponseData: BaseModel {
    
    var address : String?
    var avatar : String?
    var branch : String?
    var businessId : String?
    var email : String?
    var id : String?
    var name : String?
    var phone : String?
    var province : String?
    var token : String?
    var username : String?
    var website : String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        address <- map["address"]
        avatar <- map["avatar"]
        branch <- map["branch"]
        businessId <- map["business_id"]
        email <- map["email"]
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        province <- map["province"]
        token <- map["token"]
        username <- map["username"]
        website <- map["website"]
        
    }
    
}
