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
    var supplierDetails = PublishRelay<SupplierDetailsModel>()

    func loadHome() {
        isLoading.accept(true)
        homeApis.loadHome().subscribe { [weak self] homeModel in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.homeModel.accept(homeModel)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func getSupplierDetails(with supplierId: Int) {
        isLoading.accept(true)
        homeApis.showSupplier(with: supplierId).subscribe { [weak self] supplier in
            self?.isLoading.accept(false)
            self?.supplierDetails.accept(supplier)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
}
