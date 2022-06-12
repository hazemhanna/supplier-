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
    
    func SearchSuppliers(by keyword: String, page: Int) -> Single<PagedObject<SupplierModel>> {
        let request = ESNetworkRequest("search-by-keyword?searchType=\(SearchType.supplier.rawValue)&search=\(keyword)&page=\(page)")
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
    
    func SearchSuppliers(by departmentId: Int?, productId: Int?, page: Int) -> Single<PagedObject<SupplierModel>> {
        var path = "search-by-category?searchType=\(SearchType.supplier.rawValue)"
        if let departmentId = departmentId {
            path += "&parentCategoryId=\(departmentId)"
        }
        if let productId = productId {
            path += "&CategoryId=\(productId)"
        }
        path += "&page=\(page)"
        let request = ESNetworkRequest(path)
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
    
    func SearchProducts(by keyword: String, page: Int) -> Single<PagedObject<ProductModel>> {
        let request = ESNetworkRequest("search-by-keyword?searchType=\(SearchType.product.rawValue)&search=\(keyword)&page=\(page)")
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
    
    func SearchProducts(by departmentId: Int?, productId: Int?, page: Int) -> Single<PagedObject<ProductModel>> {
        var path = "search-by-category?searchType=\(SearchType.product.rawValue)"
        if let departmentId = departmentId {
            path += "&parentCategoryId=\(departmentId)"
        }
        if let productId = productId {
            path += "&CategoryId=\(productId)"
        }
        path += "&page=\(page)"
        let request = ESNetworkRequest(path)
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
}
