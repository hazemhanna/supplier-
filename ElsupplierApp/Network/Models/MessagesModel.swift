//
//  MessagesModel.swift
//  ElsupplierApp
//
//  Created by MAC on 07/07/2022.
//

import ObjectMapper

final class MessagesModel : BaseObject {
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
