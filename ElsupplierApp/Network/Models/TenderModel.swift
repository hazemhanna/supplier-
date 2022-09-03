//
//  TenderModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/06/2022.
//

import ObjectMapper

final class TenderModel: BaseObject {
    
    var userName = ""
    var category = ""
    var subCategoryAr = ""
    var subCategoryEn = ""
    var product = ""
    var message = ""
    var status: TenderStatus = .pending
    var date = ""
    
    var color: UIColor {
        switch status {
        case .pending: return R.color.pendingStatus()!
            
        case .rejected: return R.color.rejectedStatus()!
            
        case .accepted: return R.color.acceptedStatus()!
        }
    }
    
    var subCategory: String {
        subCategoryAr + " - " + subCategoryEn
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userName <- map["user_name"]
        category <- map["category"]
        subCategoryAr <- map["sub_category_ar"]
        subCategoryEn <- map["sub_category_en"]
        product <- map["product"]
        message <- map["message"]
        status <- map["status"]
        date <- map["date"]
    }
    
}

enum TenderStatus: String {
    case pending = "Pending"
    case rejected = "Rejected"
    case accepted = "Approved"
}
