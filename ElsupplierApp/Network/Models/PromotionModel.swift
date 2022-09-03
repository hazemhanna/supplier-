//
//  PromotionModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ObjectMapper

final class PromotionModel: BaseObject {
    var route = ""
    var name = ""
    var supplierName = ""
    var price = 0
    var isFav = 0
    var inCart: InCart? = nil
    var groupsPrices: [GroupPriceModel] = []
    var rank = 0
    var views = 0
    var unitMeasurement = ""
    var pageTitle = ""
    var video = ""
    var availability = 0
    var visibility = 0
    var desc = ""
    var keywords = ""
    var mainImage = ""
    var pdfFile = ""
    var productImages: [String] = []
    var productSpecs: [[String: String]] = []
    var subCategoryName = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        route <- map["route"]
        name <- map["name"]
        supplierName <- map["supplier_name"]
        price <- map["price"]
        isFav <- map["is_fav"]
        inCart <- map["in_cart"]
        groupsPrices <- map["groups_prices"]
        rank <- map["rank"]
        views <- map["views"]
        unitMeasurement <- map["unit_measurement"]
        pageTitle <- map["page_title"]
        video <- map["video"]
        availability <- map["availability"]
        visibility <- map["visibility"]
        desc <- map["description"]
        keywords <- map["keywords"]
        mainImage <- map["mainImage"]
        pdfFile <- map["pdfFile"]
        productImages <- map["product_images"]
        productSpecs <- map["product_specs"]
        subCategoryName <- map[Language.isArabic ? "subCategoryArName" : "subCategoryEnName"]
    }
}

class InCart: BaseObject {
    var quantity = "0"
    var productId = 0
    var price = 0
    var productName = ""
    var image = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        quantity <- map["quantity"]
        productId <- map["productId"]
        price <- map["price"]
        productName <- map["productName"]
        image <- map["image"]
    }
}
