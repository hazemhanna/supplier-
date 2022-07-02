//
//  SupplierModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/05/2022.
//

import ObjectMapper

final class SupplierModel: BaseObject {
    
    var logo = ""
    var name = ""
    var email = ""
    var phone = ""
    var supplierName = ""
    var supplierPhone = ""
    var supplierEmail = ""
    var address = ""
    var website = ""
    var desc = ""
    var keywords = ""
    var facebook = ""
    var linkedin = ""
    var instagram = ""
    var longitude = ""
    var latitude = ""
    var products: [ProductModel] = []
    var overAllRank = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        logo <- map["logo"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        supplierName <- map["supplierName"]
        supplierPhone <- map["supplierPhone"]
        supplierEmail <- map["supplierEmail"]
        address <- map["address"]
        website <- map["website"]
        desc <- map["description"]
        keywords <- map["keywords"]
        facebook <- map["socialLinks.facebook"]
        linkedin <- map["socialLinks.linkedin"]
        instagram <- map["socialLinks.instagram"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        products <- map["products"]
        overAllRank <- map["overAllRank"]
    }
    
}

final class PriceRequestModel: BaseObject {
    
    var productId = "0"
    var quantity = "0"
    
    override func mapping(map: Map) {
        productId <- map["productId"]
        quantity <- map["quantity"]
    }
    
}
