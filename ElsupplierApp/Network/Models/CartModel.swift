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
    var userPhone = ""
    var total = 0
    var subTotal = 0
    var delivery = 0
    var commissionRate = 0
    var commissionAmount = 0
    var commissionStatus = ""
    var supplierId = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        supplierName <- map["supplier_name"]
        minAmount <- map["min_group_amount"]
        count <- map["count"]
        totals <- map["totals"]
        address <- map["address"]
        paymentType <- map["paymentType"]
        items <- map["items"]
        userPhone <- map["user_phone"]
        total <- map["total.total"]
        subTotal <- map["total.subtotal"]
        delivery <- map["total.deliveryFees"]
        commissionRate <- map["total.commissionRate"]
        commissionAmount <- map["total.commissionAmount"]
        commissionStatus <- map["total.commissionStatus"]
        supplierId <- map["total.supplierId"]
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
