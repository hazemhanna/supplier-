//
//  AuthAPIs.swift
//  ocRecruitingSystem
//
//  Created by Ahmed Madeh on 27/03/2022.
//

import ESNetworkManager
import RxSwift
import Alamofire
import ObjectMapper

protocol AuthAPIsProtocol: AnyObject {
    func login(phone: String) -> Single<UserModel>
    func register(name: String,
                  phone: String,
                  companyName: String,
                  userTypeId: Int,
                  company_type : String) -> Single<UserModel>
}

final class AuthAPIs: AuthAPIsProtocol {
    
    func login(phone: String) -> Single<UserModel> {
        let request = ESNetworkRequest("login")
        request.method = .post
        request.parameters = ["phone": phone]
        return NetworkManager.execute(request: request)
    }
    
    func register
    (
        name: String,
        phone: String,
        companyName: String,
        userTypeId: Int,
        company_type : String) -> Single<UserModel> {
        let request = ESNetworkRequest("register")
        request.method = .post
        request.parameters = [
            "name": name,
            "phone": phone,
            "company_name": companyName,
            "userTypeId": userTypeId//,
//            "company_type": company_type
        ]
        return NetworkManager.execute(request: request)
    }
    
}
