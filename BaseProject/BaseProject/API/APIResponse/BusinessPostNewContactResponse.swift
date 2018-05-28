//
//  BusinessPostNewContactResponse.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
import ObjectMapper

class BusinessPostNewContactResponse: BaseModel{
    
    var code : Int?
    var data : BusinessPostNewContactData?
    var errors : AnyObject?
    var message : String?
    var paging : AnyObject?
    var status : Int?
    
    override func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]
        errors <- map["errors"]
        message <- map["message"]
        paging <- map["paging"]
        status <- map["status"]
    }
    
}

class BusinessPostNewContactData: BaseModel{
    
    var businessId : String?
    var content : String?
    var email : String?
    var id : String?
    var name : String?
    var phone : String?
    
    override func mapping(map: Map) {
        businessId <- map["businessId"]
        content <- map["content"]
        email <- map["email"]
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
    }
}
