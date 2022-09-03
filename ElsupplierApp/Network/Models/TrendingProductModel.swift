//
//  TrendingProductModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ObjectMapper


final class TrendingProductModel: BaseObject {
    
    var route = ""
    var name = ""
    var supplierName = ""
    var subCategoryName = ""
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
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        route <- map["route"]
        name <- map["name"]
        supplierName <- map["supplierName"]
        subCategoryName <- map[Language.isArabic ? "subCategoryArName" : "subCategoryEnName"]
        price <- map["price"]
        isFav <- map["isFav"]
        inCart <- map["inCart"]
        groupsPrices <- map["groupsPrices"]
        rank <- map["rank"]
        views <- map["views"]
        unitMeasurement <- map["unitMeasurement"]
        pageTitle <- map["pageTitle"]
        video <- map["video"]
        availability <- map["availability"]
        visibility <- map["visibility"]
        desc <- map["desc"]
        keywords <- map["keywords"]
        mainImage <- map["mainImage"]
        pdfFile <- map["pdfFile"]
        productImages <- map["product_images"]
        productSpecs <- map["product_specs"]
    }
    
}
