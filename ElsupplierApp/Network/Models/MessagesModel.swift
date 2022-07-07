//
//  MessagesModel.swift
//  ElsupplierApp
//
//  Created by MAC on 07/07/2022.
//

import ObjectMapper

final class MessagesModel: BaseObject {
    
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

final class ChatModel: BaseObject {
    
    var supplier = SupplierModel()
    var body = ""
    var from = ""
    var date = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        supplier <- map["supplier"]
        body <- map["body"]
        from <- map["from"]
        date <- map["date"]
    }
    
}
