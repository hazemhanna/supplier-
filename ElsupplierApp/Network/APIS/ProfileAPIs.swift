//
//  ProfileAPIs.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 23/04/2022.
//

import RxSwift
import RxCocoa
import ESNetworkManager

final class ProfileAPIs {
    
    func logout() -> Single<Any> {
        let request = ESNetworkRequest("logout")
        return NetworkManager.execute(request: request)
    }
    
    func loadAreas() -> Single<[PickerModel]> {
        let request = ESNetworkRequest("profile/list/areas")
        request.selections = [.key("data"), .key("areas")]
        return NetworkManager.execute(request: request)
    }
    
    func showProfile() -> Single<UserModel> {
        let request = ESNetworkRequest("profile/show")
        request.selections = [.key("data"), .key("user_profile")]
        return NetworkManager.execute(request: request)
    }
    
    func updateProfile(name: String,
                       email: String,
                       phone: String,
                       companyName: String,
                       companyType: String,
                       areaId: Int) -> Single<Any> {
        let request = ESNetworkRequest("profile/update")
        request.method = .post
        request.parameters = ["name": name,
                              "email": email,
                              "phone": phone,
                              "company_name": companyName,
                              "company_type": companyType,
                              "area_id": areaId]
        return NetworkManager.execute(request: request)
    }
    
    func changePassword(password: String, newPassword: String) -> Single<Any> {
        let request = ESNetworkRequest("profile/update")
        request.method = .post
        request.parameters = ["": password, "": newPassword]
        return NetworkManager.execute(request: request)
    }
    
    func selectUserAddress(addressId: Int) -> Single<Any> {
        let request = ESNetworkRequest("profile/select/address")
        request.method = .post
        request.parameters = ["userAddressId": addressId]
        return NetworkManager.execute(request: request)
    }
    
    func selectPaymentMethod(paymentId: Int) -> Single<Any> {
        let request = ESNetworkRequest("profile/select/paymentMethod")
        request.method = .post
        request.parameters = ["paymentMethodId": paymentId]
        return NetworkManager.execute(request: request)
    }
    
    func listFavorites() -> Single<[TrendingProductModel]> {
        let request = ESNetworkRequest("products/get/favourite")
        request.selections = [.key("data"), .key("favourite_products")]
        return NetworkManager.execute(request: request)
    }
    
    func toggleFavorite(productId: Int) -> Single<Any> {
        let request = ESNetworkRequest("products/favourite")
        request.method = .post
        request.parameters = ["productId": productId]
        return NetworkManager.execute(request: request)
    }
    
}
