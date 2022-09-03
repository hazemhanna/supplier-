//
//  SupplierViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 02/07/2022.
//

import RxSwift
import RxCocoa

final class SupplierViewModel: BaseViewModel {
    
    let supplierApis = SupplierAPIs()
    var callbackRequested = PublishRelay<String>()
    var messageSent = PublishRelay<Bool>()
    var priceRequested = PublishRelay<Bool>()
    
    func requestCallBack(supplierId: Int) {
        isLoading.accept(true)
        supplierApis.requestCallBack(supplierId: supplierId).subscribe { [weak self] in
            self?.isLoading.accept(false)
            self?.callbackRequested.accept($0)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func requestProductPrice(
        supplierId: Int,
        productId: Int,
        quantity: Int
    ) {
        isLoading.accept(true)
        supplierApis.productRFQ(supplierId: supplierId,
                                productId: productId,
                                quantity: quantity).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.priceRequested.accept(true)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func requestSupplierPrice(supplierId: Int, products: [PriceRequestModel]) {
        isLoading.accept(true)
        supplierApis.generalRFQ(supplierId: supplierId, products: products).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.priceRequested.accept(true)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func sendMessage(supplierId: Int, message: String) {
         isLoading.accept(true)
        supplierApis.messageRequest(supplierId: supplierId, message: message).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.messageSent.accept(true)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
}
