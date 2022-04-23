//
//  GroupPriceModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ObjectMapper

final class GroupPriceModel: BaseObject {
    
    var route = ""
    var groupName = ""
    var groupPrice = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        route <- map["route"]
        groupName <- map["group_name"]
        groupPrice <- map["group_price"]
    }
    
}
