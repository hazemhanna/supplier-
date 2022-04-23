//
//  ProfileViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import RxCocoa
import RxSwift
import Foundation

final class ProfileViewModel: BaseViewModel {

    var selectedUserAddress = BehaviorRelay<Int>(value: -1)
    var selectedPaymentMethod = BehaviorRelay<Int>(value: -1)
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

    // MARK: - Change Password
    var oldPassword = BehaviorRelay<String>(value: "")
    var newPassword = BehaviorRelay<String>(value: "")
    var passwordChanged = PublishRelay<Bool>()

    // MARK: - Favorites
    var favorites = PublishRelay<[TrendingProductModel]>()
    var favoriteToggledSucceeded = PublishRelay<Bool>()
    
    // MARK: - Variables
    let profileApis = ProfileAPIs()

    // MARK: - Functions
    func logout() {
        profileApis.logout().subscribe { _ in } onError: { _ in }.disposed(by: disposeBag)
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
                                  areaId: areaId.value).subscribe { [weak self] _ in
            guard let self = self else { return }
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
        mockupApi.loadUserTypes().subscribe {[weak self] types in
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
        profileApis.listFavorites().subscribe {[weak self] favs in
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
    
}
