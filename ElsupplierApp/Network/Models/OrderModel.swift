//
//  OrderModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import ObjectMapper

final class OrderModel: BaseObject {

    var userName = ""
    var userPhone = ""
    var supplierName = ""
    var subtotal = 0
    var deliveryFees = 0
    var items: [CartItem] = []
    var totalAmount = 0
    var orderStatus = ""
    var datePlaced = ""
    var address = ""
    var paymentType = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userName <- map["user_name"]
        userPhone <- map["user_phone"]
        supplierName <- map["supplier_name"]
        subtotal <- map["subtotal"]
        deliveryFees <- map["delivery_fees"]
        items <- map["items"]
        totalAmount <- map["total_amount"]
        orderStatus <- map["order_status"]
        datePlaced <- map["date_placed"]
        address <- map["address"]
        paymentType <- map["payment_type"]
    }
    
}
