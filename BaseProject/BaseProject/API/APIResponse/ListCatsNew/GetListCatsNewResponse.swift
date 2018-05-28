//
//  GetListCatsNewResponse.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import UIKit
import ObjectMapper

class GetListCatsNewResponse: BaseModel {
    
    var status: Int?
    var data: [GetListCatsNewData]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
        status <- map["status"]
    }
    
}

class GetListCatsNewData: BaseModel {
    
    var descriptionField : String?
    var id : String?
    var name : String?
    var parentId : String?
    var url : String?
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        descriptionField <- map["description"]
        id <- map["id"]
        name <- map["name"]
        parentId <- map["parent_id"]
        url <- map["url"]
        
    }
    
}

