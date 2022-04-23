//
//  HomeViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 23/04/2022.
//

import RxSwift
import RxCocoa

final class HomeViewModel: BaseViewModel {
    
    var homeModel = PublishRelay<HomeModel>()
    let homeApis = HomeAPIs()

    func loadHome() {
        isLoading.accept(true)
        homeApis.loadHome().subscribe {[weak self] homeModel in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.homeModel.accept(homeModel)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
}
