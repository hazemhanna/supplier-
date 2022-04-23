//
//  HomeAPIs.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 22/04/2022.
//

import ESNetworkManager
import RxSwift

class HomeAPIs {
    func loadHome() -> Single<HomeModel> {
        let request = ESNetworkRequest("home")
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
}
