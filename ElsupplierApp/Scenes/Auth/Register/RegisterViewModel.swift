//
//  RegisterViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 09/04/2022.
//

import RxSwift
import RxCocoa

class RegisterViewModel: BaseViewModel {
    
    var name = BehaviorRelay<String>(value: "")
    var mobileNo = BehaviorRelay<String>(value: "")
    var email = BehaviorRelay<String>(value: "")
    var activityType = BehaviorRelay<Int>(value: 0)
    var companyName = BehaviorRelay<String>(value: "")

    var user = PublishRelay<UserModel>()
    var activities = PublishRelay<[UserTypeModel]>()
    let authApi = AuthAPIs()
    let mockupApi = MockupsAPIs()

    func validate() -> Bool {
        if name.value.isEmpty {
            error.accept(NSError.init(error: "Please enter your name", code: 0))
            return false
        }
        if !mobileNo.value.isPhoneNumber {
            error.accept(NSError.init(error: "Please enter valid mobile no", code: 0))
            return false
        }
//        if !email.value.isValidEmail {
//            error.accept(NSError.init(error: "Please enter valid email", code: 0))
//            return false
//        }
        if companyName.value.isEmpty {
            error.accept(NSError.init(error: "Please enter company name", code: 0))
            return false
        }
        return true
    }
    
    func register() {
        if !validate() { return }
        isLoading.accept(true)
        authApi.register(name: name.value,
                         phone: mobileNo.value,
                         companyName: companyName.value,
                         userTypeId: activityType.value).subscribe {[weak self] user in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.user.accept(user)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func loadActivityTypes() {
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

}
