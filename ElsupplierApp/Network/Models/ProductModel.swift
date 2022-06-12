//
//  ProductModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/05/2022.
//

import ObjectMapper

class ProductModel: BaseObject {
    
    var name = ""
    var supplierName = ""
    var supplier = SupplierModel()
    var categoryName = ""
    var price = 0
    var isFav = false
    var inCart = false
    var groupPrice: [GroupPriceModel] = []
    var rank = 0
    var views = 0
    var measurmentUnit = ""
    var pageTitle = ""
    var video = ""
    var availability = false
    var visibility = false
    var desc = ""
    var keywords = ""
    var mainImage = ""
    var pdfFile = ""
    var productImages: [ProductImage] = []
    var specs: [[String: Any]] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        supplierName <- map["supplier_name"]
        supplier <- map["supplier"]
        categoryName <- map[Language.isArabic ? "subCategoryArName" : "subCategoryEnName"]
        price <- map["price"]
        isFav <- map["is_fav"]
        inCart <- map["in_cart"]
        groupPrice <- map["groups_prices"]
        rank <- map["rank"]
        views <- map["views"]
        measurmentUnit <- map["unit_measurement"]
        pageTitle <- map["page_title"]
        video <- map["video"]
        availability <- map["availability"]
        visibility <- map["visibility"]
        desc <- map["description"]
        keywords <- map["keywords"]
        mainImage <- map["mainImage"]
        pdfFile <- map["pdfFile"]
        productImages <- map["product_images"]
        specs <- map["product_specs"]
    }
    
}

class ProductImage: BaseObject {
    var image = ""
    var productName = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        image <- map["image"]
        productName <- map["product"]
    }
}
