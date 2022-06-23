//
//  SupplierDetailsModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 20/06/2022.
//

import ObjectMapper

final class SupplierDetailsModel: BaseObject {
    
    var supplier = SupplierModel()
    var isFav = false
    var categoriesProducts: [CategoryModel] = []
    var posts: [PostModel] = []
    var cart = CartModel()
    var promotions: [PromotionModel] = []
    var categoryProducts: [SupplierCategoryProductsModel] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        supplier <- map["supplier"]
        isFav <- map["is_fav"]
        categoriesProducts <- map["supplier_categories_products"]
        posts <- map["supplierPosts"]
        cart <- map["cart_details"]
        promotions <- map["promotions_list"]
        categoryProducts <- map["supplier_categories_products"]
    }
    
}

final class SupplierCategoryProductsModel: BaseObject {
    
    var name = ""
    var products: [ProductModel] = []
    var isSelected = false
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map[Language.isArabic ? "name_ar" : "name_en"]
        products <- map["products"]
    }
    
}
