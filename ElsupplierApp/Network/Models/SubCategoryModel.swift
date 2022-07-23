//
//  SubCategoryModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 20/07/2022.
//

import ObjectMapper

final class SubCategoryModel: BaseObject {
    
    var name = ""
    var rank = ""
    var desc = ""
    var keywords = ""
    var image = ""
    var parent = ""
    var products: [ProductModel] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Language.isArabic ? "name_ar" : "name_en"]
        rank <- map["rank"]
        desc <- map["description"]
        keywords <- map["keywords"]
        image <- map["image"]
        parent <- map["parent"]
        products <- map["products"]
    }
}
