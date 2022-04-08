//
//  CityModel.swift
//  ocRecruitingSystem
//
//  Created by Ahmed Madeh on 27/03/2022.
//

import ObjectMapper

class UserTypeModel: BaseObject {

    var name = ""
    var route = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Language.isArabic ? "name_ar" : "name_en"]
        route <- map["route"]
    }
    
}
