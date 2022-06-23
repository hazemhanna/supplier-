//
//  CategoryModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 20/05/2022.
//

import ObjectMapper

final class CategoryModel: BaseObject {
    
    var name = ""
    var rank = 0
    var order = 0
    var visibility = false
    var desc = ""
    var keywords = ""
    var image = ""
    var parent = ""
    var childs: [CategoryChildModel] = []
    var products: [ProductModel] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Language.isArabic ? "name_ar" : "name_en"]
        rank <- map["rank"]
        order <- map["order"]
        visibility <- map["visibility"]
        desc <- map["description"]
        keywords <- map["keywords"]
        image <- map["image"]
        parent <- map["parent"]
        childs <- map["childs"]
        products <- map["products"]
    }
}

final class CategoryChildModel: BaseObject {
    
    var name = ""
    var image = ""
    var parentId = 0
    var rank = 0
    var desc = ""
    var keywords = ""
    var createdAt = ""
    var updatedAt = ""
    var trend = false
    var visibility = false
    var order = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Language.isArabic ? "name_ar" : "name_en"]
        image <- map["image"]
        parentId <- map["parent_id"]
        rank <- map["rank"]
        desc <- map["description"]
        keywords <- map["keywords"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        trend <- map["trend"]
        visibility <- map["visibility"]
        order <- map["order"]
    }
    
}
