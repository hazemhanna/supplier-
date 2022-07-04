//
//  SupplierAPIs.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 02/07/2022.
//

import Alamofire
import ESNetworkManager
import RxCocoa
import RxSwift

final class SupplierAPIs {
    
    func showSupplier(with supplierId: Int) -> Single<SupplierDetailsModel> {
        let request = ESNetworkRequest("suppliers/show?supplierId=\(supplierId)")
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
    
    func categorySuppliers(with categoryId: Int) -> Single<PagedObject<SupplierModel>> {
        let request = ESNetworkRequest("suppliers/sub-category")
        request.method = .post
        request.parameters = ["categoryId": categoryId]
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
    
    func requestCallBack(supplierId: Int) -> Single<Any> {
        let request = ESNetworkRequest("actions/callBack/request")
        request.method = .post
        request.parameters = ["supplierId": supplierId]
        return NetworkManager.execute(request: request)
    }
    
    func viewInfoRequest(supplierId: Int) -> Single<Any> {
        let request = ESNetworkRequest("actions/viewInfo/request")
        request.method = .post
        request.parameters = ["supplierId": supplierId]
        return NetworkManager.execute(request: request)
    }
    
    func generalRFQ(supplierId: Int, products: [PriceRequestModel]) -> Single<Any> {
        let request = ESNetworkRequest("actions/general/rfq/request")
        request.method = .post
        request.parameters = [
            "supplierId": supplierId,
            "productQuantity": products.toJSON()
        ]
        return NetworkManager.execute(request: request)
    }
    
    func productRFQ(supplierId: Int, productId: Int, quantity: Int) -> Single<Any> {
        let request = ESNetworkRequest("actions/product/rfq/request")
        request.method = .post
        request.parameters = [
            "supplierId": supplierId,
            "productId": productId,
            "quantity": quantity
        ]
        return NetworkManager.execute(request: request)
    }
    
    func messageRequest(supplierId: Int, message: String) -> Single<Any> {
        let request = ESNetworkRequest("actions/message/request")
        request.method = .post
        request.parameters = [
            "supplierId": supplierId,                      
            "message": message
        ]
        return NetworkManager.execute(request: request)
    }
}
