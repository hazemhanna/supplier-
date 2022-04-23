//
//  MockupsAPI.swift
//  ocRecruitingSystem
//
//  Created by Ahmed Madeh on 27/03/2022.
//

import ESNetworkManager
import RxSwift
import Alamofire

protocol MockupsAPIsProtocol: AnyObject {
    func loadUserTypes() -> Single<[UserTypeModel]>
}

final class MockupsAPIs: MockupsAPIsProtocol {
    func loadUserTypes() -> Single<[UserTypeModel]> {
        let request = ESNetworkRequest("user-types/get")
        request.selections = [.key("data"), .key("user_types")]
        return NetworkManager.execute(request: request)
    }
    
}
