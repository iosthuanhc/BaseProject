//
//  APIConstant.swift
//  BaseProject
//
//  Created by Ha Cong Thuan on 5/28/18.
//  Copyright © 2018 Ha Cong Thuan. All rights reserved.
//

import Foundation
let apiDomain = "http://vietnamexport.com/api/v1/vi"

enum ApiUrl: String {
    
    case getListCatsView               = "/listcatnews.json"
    case businessRegister              = "/business/register"
    case addProducts                   = "/business/add_product"
    case businessAddContact            = "/contact/add"
    
    var url: String {
        return apiDomain + rawValue
    }
    
}

class ApiCommon: NSObject {
    
}
