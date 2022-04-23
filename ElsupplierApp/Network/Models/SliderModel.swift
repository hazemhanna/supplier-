//
//  SliderModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 23/04/2022.
//

import ObjectMapper

final class SliderModel: BaseObject {
    
    var image = ""
    var route = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        image <- map["image"]
        route <- map["route"]
    }
    
}
