//
//  CartViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import RxCocoa
import RxSwift

class CartViewModel: BaseViewModel {
    
    var cartModel = PublishRelay<CartModel>()
    var itemRemoved = PublishRelay<Bool>()
    var itemAdded = PublishRelay<Bool>()
    var itemUpdated = PublishRelay<Bool>()
    var requestCallBackSucceed = PublishRelay<Bool>()
    var paymentTypeSelected = PublishRelay<Int>()
    var paymentTypes = PublishRelay<[PaymentTypeModel]>()
    var orderCreationSucceed = PublishRelay<Bool>()
    var relatedProducts = PublishRelay<[ProductModel]>()

    let cartApis = CartAPIs()
    let supplierApis = SupplierAPIs()
    
    func loadCart() {
        isLoading.accept(true)
        cartApis.loadCart().subscribe { [weak self] cart in
            self?.isLoading.accept(false)
            self?.cartModel.accept(cart)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func removeFromCart(itemId: Int) {
        isLoading.accept(true)
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
        cartApis.addToCart(itemId: itemId, qty: qty).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.itemAdded.accept(true)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func requestPhoneCall(supplierId: Int) {
        isLoading.accept(true)
        supplierApis.requestCallBack(supplierId: supplierId).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.requestCallBackSucceed.accept(true)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func loadPaymentTypes() {
        isLoading.accept(true)
        cartApis.loadPaymentTypes().subscribe { [weak self] types in
            self?.isLoading.accept(false)
            self?.paymentTypes.accept(types)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func selectPaymentType(typeId: Int, index: Int) {
        isLoading.accept(true)
        cartApis.selectPaymentType(typeId: typeId).subscribe { [weak self] _ in
            self?.isLoading.accept(false)
            self?.paymentTypeSelected.accept(index)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func completeOrder() {
        isLoading.accept(true)
        cartApis.makeOrder().subscribe { [weak self] _ in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.orderCreationSucceed.accept(true)
        } onError: { [weak self] in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
    func loadProductDetails(productId: Int) {
        isLoading.accept(true)
        cartApis.loadRelatedProducts(productId: productId).subscribe { [weak self] in
            self?.isLoading.accept(false)
            self?.relatedProducts.accept($0)
        } onError: { [weak self] in
            self?.isLoading.accept(false)
            self?.error.accept($0)
        }.disposed(by: disposeBag)
    }
    
}
