//
//  ProductModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/05/2022.
//

import ObjectMapper

final class ProductModel: BaseObject {
    var name = ""
    var supplierName = ""
    var supplier = SupplierModel()
    var categoryName = ""
    var price = 0
    var isFav = 0
    var inCart = 0
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
    var addToCart = 0
    var orderMinAmount = 0
    var promotions: [ProductPromotionModel] = []
    var rfqSend = false
    var productSpecs: [[String: String]] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        supplierName <- map["supplier_name", "supplierName"]
        supplier <- map["supplier"]
        categoryName <- map["subCategoryName", Language.isArabic ? "subCategoryArName" : "subCategoryEnName"]
        price <- map["price"]
        isFav <- map["is_fav"]
        inCart <- map["in_cart"]
        groupPrice <- map["groups_prices"]
        rank <- map["rank"]
        views <- map["views"]
        measurmentUnit <- map["unit_measurement", "unitMeasurement"]
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
        addToCart <- map["addToCart"]
        orderMinAmount <- map["order_minimum_amount"]
        rfqSend <- map["rfq_send"]
        productSpecs <- map["product_specs"]
    }
    
}

final class ProductImage: BaseObject {
    var image = ""
    var productName = ""
    override func mapping(map: Map) {
        super.mapping(map: map)
        image <- map["image"]
        productName <- map["product"]
    }
}

final class ProductPromotionModel: BaseObject {
    
    var promotionId = ""
    var promotionPrice = ""
    var minimumQuantity = ""
    var expirationDate = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        promotionId <- map["promotionId"]
        promotionPrice <- map["promotion_price"]
        minimumQuantity <- map["minimum_quantity"]
        expirationDate <- map["expiration_date"]
    }
    
}
