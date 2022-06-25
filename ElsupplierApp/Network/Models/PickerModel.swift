//
//  PickerModel.swift
//  ocRecruitingSystem
//
//  Created by Ahmed Madeh on 27/03/2022.
//

import ObjectMapper

final class PickerModel: BaseObject {
    
    var name = ""
    var isSelected = false
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Language.isArabic ? "name_ar" : "name_en"]
    }
    
}


final class PaymentTypeModel: BaseObject {
    
    var name = ""
    var isSelected = false
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
    }
    
}
