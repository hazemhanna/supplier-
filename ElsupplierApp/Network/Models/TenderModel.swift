//
//  TenderModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/06/2022.
//

import ObjectMapper

final class TenderModel: BaseObject {
    
    var userName = ""
    var category = ""
    var subCategory = ""
    var product = ""
    var message = ""
    var status = ""
    var date = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userName <- map["user_name"]
        category <- map["category"]
        subCategory <- map["sub_category"]
        product <- map["product"]
        message <- map["message"]
        status <- map["status"]
        date <- map["date"]
    }
    
}
