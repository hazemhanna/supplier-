//
//  LoginViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/04/2022.
//

import RxSwift
import RxCocoa

final class LoginViewModel: BaseViewModel {

    var mobileNo = BehaviorRelay<String>(value: "")
    var user = PublishRelay<UserModel>()
    let auth = AuthAPIs()

    func validate() -> Bool {
        return mobileNo.value.isPhoneNumber
    }
    
    func login() {
        if !validate() { return }
        isLoading.accept(true)
        auth.login(phone: mobileNo.value).subscribe {[weak self] user in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.user.accept(user)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
}
