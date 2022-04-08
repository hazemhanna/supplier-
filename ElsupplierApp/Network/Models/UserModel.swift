//
//  UserModel.swift
//  ocRecruitingSystem
//
//  Created by Ahmed Madeh on 27/03/2022.
//

import ObjectMapper

class UserModel: BaseObject, Storable {

    var token = ""
    var status = ""
    var name = ""
    var phone = ""
    var email = ""
    var companyType = ""
    var companyName = ""
    var jobTitle = ""
    var image = ""
    var route = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["data.user.id"]
        name <- map["data.user.name"]
        phone <- map["data.user.phone"]
        email <- map["data.user.email"]
        image <- map["data.user.image"]
        route <- map["data.user.route"]
        companyName <- map["data.user.company_name"]
        companyType <- map["data.user.company_type"]
        jobTitle <- map["data.user.job_title"]
        token <- map["message"]
    }
    
}
