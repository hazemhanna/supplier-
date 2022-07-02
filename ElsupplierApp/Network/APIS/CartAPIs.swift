//
//  CartAPIs.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import RxSwift
import RxCocoa
import ESNetworkManager

final class CartAPIs {
    
    func loadCart() -> Single<CartModel> {
        let request = ESNetworkRequest("cart/view")
        request.selections = [.key("data"), .key("cart")]
        return NetworkManager.execute(request: request)
    }
    
    func removeFromCart(itemId: Int) -> Single<Any> {
        let request = ESNetworkRequest("cart/delete")
        request.method = .post
        request.parameters = ["itemId": itemId]
        return NetworkManager.execute(request: request)
    }
    
    func addToCart(itemId: Int, qty: Int) -> Single<Any> {
        let request = ESNetworkRequest("cart/add")
        request.method = .post
        request.parameters = ["productId": itemId, "quantity": qty]
        return NetworkManager.execute(request: request)
    }
    
    func updateCart(itemId: Int, qty: Int) -> Single<Any> {
        let request = ESNetworkRequest("cart/update")
        request.method = .post
        request.parameters = ["itemId": itemId, "quantity": qty]
        return NetworkManager.execute(request: request)
    }
    
    func loadPaymentTypes() -> Single<[PaymentTypeModel]> {
        let request = ESNetworkRequest("payment/types")
        request.selections = [.key("data"), .key("types")]
        return NetworkManager.execute(request: request)
    }
    
    func selectPaymentType(typeId: Int) -> Single<Any> {
        let request = ESNetworkRequest("cart/payment/update")
        request.method = .post
        request.parameters = ["paymentTypeId": typeId]
        return NetworkManager.execute(request: request)
    }
    
    func selectShippingAddress(addressId: Int) -> Single<Any> {
        let request = ESNetworkRequest("cart/user/address/update")
        request.method = .post
        request.parameters = ["userAddressId": addressId]
        return NetworkManager.execute(request: request)
    }
    
    func makeOrder() -> Single<Any> {
        let request = ESNetworkRequest("cart/order")
        request.method = .post
        return NetworkManager.execute(request: request)
    }
    
    func loadRelatedProducts(productId: Int) -> Single<[ProductModel]> {
        let request = ESNetworkRequest("products/show?productId=\(productId)")
        request.selections = [.key("data"), .key("related-products")]
        return NetworkManager.execute(request: request)
    }
    
}
