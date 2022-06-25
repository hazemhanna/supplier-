//
//  MockupsAPI.swift
//  ocRecruitingSystem
//
//  Created by Ahmed Madeh on 27/03/2022.
//

import ESNetworkManager
import RxSwift
import Alamofire

final class MockupsAPIs {
    func loadUserTypes() -> Single<[UserTypeModel]> {
        let request = ESNetworkRequest("user-types/get")
        request.selections = [.key("data"), .key("user_types")]
        return NetworkManager.execute(request: request)
    }
    
    func listGovernrates() -> Single<[PickerModel]> {
        let request = ESNetworkRequest("addresses/get/provinces")
        request.selections = [.key("data"), .key("provinces")]
        return NetworkManager.execute(request: request)
    }
    
    func listCities() -> Single<[PickerModel]> {
        let request = ESNetworkRequest("addresses/get/cities")
        request.selections = [.key("data"), .key("cities")]
        return NetworkManager.execute(request: request)
    }
    
    func listAreas() -> Single<[PickerModel]> {
        let request = ESNetworkRequest("addresses/get/areas")
        request.selections = [.key("data"), .key("areas")]
        return NetworkManager.execute(request: request)
    }
    
    func listCategories() -> Single<[CategoryModel]> {
        let request = ESNetworkRequest("sub-categories/products")
        request.selections = [.key("data"), .key("sub_categories")]
        return NetworkManager.execute(request: request)
    }
    
    func listMockCategories() -> Single<[PickerModel]> {
        let request = ESNetworkRequest("sub-categories/products")
        request.selections = [.key("data"), .key("sub_categories")]
        return NetworkManager.execute(request: request)
    }
    func listParentCategories() -> Single<[CategoryModel]> {
        let request = ESNetworkRequest("categories-list")
        request.selections = [.key("data"), .key("category_list")]
        return NetworkManager.execute(request: request)
    }
    
}
