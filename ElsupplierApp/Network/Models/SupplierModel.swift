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
    var socialLinks = ""
    var longitude = ""
    var latitude = ""
    var products: [ProductModel] = []
    
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
        socialLinks <- map["socialLinks"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        products <- map["products"]
    }
    
}
