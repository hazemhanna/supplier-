//
//  AddressModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/05/2022.
//

import ObjectMapper

final class AddressModel: BaseObject {
    
    var route = ""
    var areaId = 0
    var cityId = 0
    var provinceId = 0
    var isSelected = false
    var address = ""
    var apartment = ""
    var street = ""
    var floor = ""
    var landmark = ""
    var govName = ""
    var cityName = ""
    var areaName = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        route <- map["route"]
        areaId <- map["area_id"]
        cityId <- map["city_id"]
        provinceId <- map["province_id"]
        isSelected <- map["isSelected"]
        address <- map["address"]
        areaName <- map[Language.isArabic ? "area_arabic_name" : "area_english_name"]
        apartment <- map["apartment"]
        street <- map["street"]
        floor <- map["floor"]
        landmark <- map["landmark"]
        
        govName <- map[""]
        cityName <- map[""]
    }
}
