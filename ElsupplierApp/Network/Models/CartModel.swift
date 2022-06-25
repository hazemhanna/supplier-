//
//  CartModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import ObjectMapper

final class CartModel: BaseObject {
    
    var supplierName = ""
    var minAmount = 0
    var count = 0
    var totals = 0
    var address = AddressModel()
    var paymentType = ""
    var items = [CartItem]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        supplierName <- map["supplier_name"]
        minAmount <- map["min_group_amount"]
        count <- map["count"]
        totals <- map["totals"]
        address <- map["address"]
        paymentType <- map["paymentType"]
        items <- map["items"]
    }
    
}

final class CartItem: BaseObject {
    
    var quantity = ""
    var productId = 0
    var price = 0
    var promotion_price = 0
    var productName = ""
    var image = ""
    var total = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        quantity <- map["quantity"]
        productId <- map["productId"]
        price <- map["price"]
        promotion_price <- map["promotion_price"]
        productName <- map["productName", "product_name"]
        image <- map["image"]
        total <- map["total"]
    }
    
}
