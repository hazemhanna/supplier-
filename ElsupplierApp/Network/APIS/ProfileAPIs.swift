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
    
    func updateProfile
    (
        name: String,
        email: String,
        phone: String,
        companyName: String,
        companyType: String,
        areaId: Int,
        image: UIImage?
    ) -> Single<UserModel> {
        let request = ESNetworkRequest("profile/update")
        request.method = .post
        request.parameters = [
            "name": name,
            "email": email,
            "phone": phone,
            "company_name": companyName,
            "company_type": companyType,
            "area_id": areaId
        ]
        request.selections = [.key("data"), .key("user_profile")]
        if let image = image,
           let data = image.jpegData(compressionQuality: 0.5) {
            return NetworkManager.upload(data: .multipart(
                [.init(data: data, key: "image", name: "image", memType: "Jpeg")]
            ), request: request) { progress in
                debugPrint("ProfilePicUpload progress: \(progress)")
            }
        }
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
    
    func listFavorites() -> Single<[ProductModel]> {
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
    
    func listFavoriteSuppliers() -> Single<[SupplierModel]> {
        let request = ESNetworkRequest("suppliers/get/favourite")
        request.selections = [.key("data"), .key("favourite_suppliers")]
        return NetworkManager.execute(request: request)
    }
    
    func toggleFavoriteSupplier(supplierId: Int) -> Single<Any> {
        let request = ESNetworkRequest("suppliers/favourite")
        request.method = .post
        request.parameters = ["supplierId": supplierId]
        return NetworkManager.execute(request: request)
    }
    
    func listAddresses() -> Single<[AddressModel]> {
        let request = ESNetworkRequest("addresses/get")
        request.selections = [.key("data"), .key("addresses")]
        return NetworkManager.execute(request: request)
    }
    
    func deleteAddress(addressId: Int) -> Single<Any> {
        let request = ESNetworkRequest("addresses/delete")
        request.method = .post
        request.parameters = ["addressId": addressId]
        return NetworkManager.execute(request: request)
    }
    
    func addAddress
    (
        areaId: Int,
        street: String,
        floor: String,
        apartment: String,
        landmark: String,
        cityId: Int,
        provinceId: Int
    ) -> Single<Any> {
        let request = ESNetworkRequest("addresses/store")
        request.method = .post
        request.parameters = [
            "areaId": areaId,
            "street": street,
            "floor": floor,
            "apartment": apartment,
            "landmark": landmark,
            "cityId": cityId,
            "provinceId": provinceId
        ]
        return NetworkManager.execute(request: request)
    }
    
    func updateAddress
    (
        addressId: Int,
        areaId: Int,
        street: String,
        floor: String,
        apartment: String,
        landmark: String,
        cityId: Int,
        provinceId: Int
    ) -> Single<Any> {
        let request = ESNetworkRequest("addresses/update")
        request.method = .post
        request.parameters = [
            "addressId": addressId,
            "areaId": areaId,
            "street": street,
            "floor": floor,
            "apartment": apartment,
            "landmark": landmark,
            "cityId": cityId,
            "provinceId": provinceId
        ]
        return NetworkManager.execute(request: request)
    }
    
    func selectAddress(addressId: Int) -> Single<Any> {
        let request = ESNetworkRequest("profile/select/address")
        request.method = .post
        request.parameters = ["userAddressId": addressId]
        return NetworkManager.execute(request: request)
    }
    
    func listOrders(page: Int) -> Single<PagedObject<OrderModel>> {
        let request = ESNetworkRequest("orders?page=\(page)")
        request.selections = [.key("data")]
        return NetworkManager.execute(request: request)
    }
    
    func listTenders() -> Single<[TenderModel]> {
        let request = ESNetworkRequest("tenders/get")
        request.selections = [.key("data"), .key("my_tenders")]
        return NetworkManager.execute(request: request)
    }
    
    func storeTender(categoryId: Int, productId: Int, message: String) -> Single<String> {
        let request = ESNetworkRequest("tenders/store")
        request.method = .post
        request.parameters = [
            "categoryId": categoryId,
            "productId":productId,
            "message":message
        ]
        request.selections = [.key("message")]
        return NetworkManager.execute(request: request)
    }
    
}
