//
//  ProfileViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import RxCocoa
import RxSwift
import Foundation

class ProfileViewModel: BaseViewModel {

    var selectedUserAddress = BehaviorRelay<Int>(value: -1)
    var selectedPaymentMethod = BehaviorRelay<Int>(value: -1)
    var image = BehaviorRelay<UIImage?>(value: nil)
    var doneAddressSelection = PublishRelay<Bool>()
    var donePaymentMethodSelection = PublishRelay<Bool>()
    
    // MARK: - Profile
    var user = PublishRelay<UserModel>()
    // MARK: - Edit profile
    var name = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    var mobileNo = BehaviorRelay<String>(value: "")
    var companyName = BehaviorRelay<String>(value: "")
    var companyType = BehaviorRelay<String>(value: "")
    var areaId = BehaviorRelay<Int>(value: -1)
    var activityTypeSelected = BehaviorRelay<Int>(value: -1)
    var areas = PublishRelay<[PickerModel]>()
    var activities = PublishRelay<[UserTypeModel]>()
    var updatedSuccessfully = PublishRelay<Bool>()
    // MARK: - Favorites
    var favorites = PublishRelay<[ProductModel]>()
    var favoriteSuppliers = PublishRelay<[SupplierModel]>()
    var favoriteToggledSucceeded = PublishRelay<Bool>()
    var itemRemoved = PublishRelay<Bool>()
    var itemAdded = PublishRelay<Bool>()
    
    // MARK: - Orders
    var orders = PublishRelay<PagedObject<OrderModel>>()
    // MARK: - Tenders
    var tenders = PublishRelay<[TenderModel]>()
    var tenderAdded = PublishRelay<Bool>()
    var selectedCategory = BehaviorRelay<Int?>(value: nil)
    var selectedProduct = BehaviorRelay<Int?>(value: nil)
    var tenderDetails = BehaviorRelay<String>(value: "")
    var messages = PublishRelay<[MessagesModel]>()

    // MARK: - Variables
    let profileApis = ProfileAPIs()

    // MARK: - Functions
    func logout() {
        profileApis.logout().subscribe {_ in
        } onError: {_ in
        }.disposed(by: disposeBag)
    }
    
    func showProfile() {
        isLoading.accept(true)
        profileApis.showProfile().subscribe { [weak self] user in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.user.accept(user)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func validate() -> Bool {
        if name.value.isEmpty {
            error.accept(NSError.init(error: "Please enter your name", code: 0))
            return false
        }
        if email.value.isEmpty {
            error.accept(NSError.init(error: "Please enter your email", code: 0))
            return false
        }
        if !mobileNo.value.isPhoneNumber {
            error.accept(NSError.init(error: "Please enter valid mobile no", code: 0))
            return false
        }
        if companyName.value.isEmpty {
            error.accept(NSError.init(error: "Please enter company name", code: 0))
            return false
        }
        if companyType.value.isEmpty {
            error.accept(NSError.init(error: "Please select company type", code: 0))
            return false
        }
        return true
    }
    
    func updateProfile() {
        if !validate() { return }
        isLoading.accept(true)
        profileApis.updateProfile(name: name.value,
                                  email: email.value,
                                  phone: mobileNo.value,
                                  companyName: companyName.value,
                                  companyType: companyType.value,
                                  areaId: areaId.value,
                                  image: image.value).subscribe { [weak self] in
            guard let self = self else { return }
            $0.token = UserModel.current?.token ?? ""
            $0.store()
            self.isLoading.accept(false)
            self.updatedSuccessfully.accept(true)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func loadAreas() {
        isLoading.accept(true)
        profileApis.loadAreas().subscribe { [weak self] areas in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.areas.accept(areas)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func selectUserAddress() {
        isLoading.accept(true)
        profileApis.selectUserAddress(addressId: selectedUserAddress.value).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.doneAddressSelection.accept(true)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func selectPaymentMethod() {
        isLoading.accept(true)
        profileApis.selectPaymentMethod(paymentId: selectedUserAddress.value).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.donePaymentMethodSelection.accept(true)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func loadActivityTypes() {
        let mockupApi = MockupsAPIs()
        isLoading.accept(true)
        mockupApi.loadUserTypes().subscribe { [weak self] types in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.activities.accept(types)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listFavorites() {
        isLoading.accept(true)
        profileApis.listFavorites().subscribe { [weak self] favs in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.favorites.accept(favs)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func favToggle(productId: Int) {
        isLoading.accept(true)
        profileApis.toggleFavorite(productId: productId).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.favoriteToggledSucceeded.accept(true)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listFavoriteSuppliers() {
        isLoading.accept(true)
        profileApis.listFavoriteSuppliers().subscribe { [weak self] favs in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.favoriteSuppliers.accept(favs)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func favToggle(supplierId: Int) {
        isLoading.accept(true)
        profileApis.toggleFavoriteSupplier(supplierId: supplierId).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.favoriteToggledSucceeded.accept(true)
        } onError: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listOrders(page: Int) {
        isLoading.accept(true)
        profileApis.listOrders(page: page).subscribe { [weak self] in
            self?.isLoading.accept(false)
            self?.orders.accept($0)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func listTenders() {
        isLoading.accept(true)
        profileApis.listTenders().subscribe { [weak self] in
            self?.isLoading.accept(false)
            self?.tenders.accept($0)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func storeTender() {
        if !validateTender() { return }
        isLoading.accept(true)
        profileApis.storeTender(categoryId: selectedCategory.value ?? 0,
                                productId: selectedProduct.value ?? 0,
                                message: tenderDetails.value).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.tenderAdded.accept(true)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func validateTender() -> Bool {
        if selectedCategory.value == nil {
            error.accept(NSError.init(error: "_select_category", code: -1))
            return false
        }
        if selectedProduct.value == nil {
            error.accept(NSError.init(error: "_select_product", code: -1))
            return false
        }
        if tenderDetails.value.isEmpty {
            error.accept(NSError.init(error: "_enter_details", code: -1))
            return false
        }
        return true
    }
    
    
    func listMessages() {
        isLoading.accept(true)
        profileApis.listMessages().subscribe { [weak self] message in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.messages.accept(message)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }

    func listChats(supplierId : Int) {
        isLoading.accept(true)
        profileApis.showChat(supplierId: supplierId).subscribe { [weak self] message in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.messages.accept(message)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    
    func removeFromCart(itemId: Int) {
        isLoading.accept(true)
        let cartApis = CartAPIs()
        cartApis.removeFromCart(itemId: itemId).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.itemRemoved.accept(true)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func addToCart(itemId: Int, qty: Int) {
        isLoading.accept(true)
        let cartApis = CartAPIs()
        cartApis.addToCart(itemId: itemId, qty: qty).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.itemAdded.accept(true)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    
}
