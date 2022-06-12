//
//  SearchFilterViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 14/05/2022.
//

import RxSwift
import RxCocoa

class SearchFilterViewModel: BaseViewModel {
    
    var selectedCategory = BehaviorRelay<CategoryModel?>(value: nil)
    var selectedProduct = BehaviorRelay<ProductModel?>(value: nil)
    var selectedFilterType = BehaviorRelay<SearchType>(value: .product)
    var selectedSearchType = BehaviorRelay<SearchType>(value: .product)
    var searchKey = BehaviorRelay<String>(value: "")
    var isFilter = BehaviorRelay<Bool>(value: false)

    var categories = PublishRelay<[CategoryModel]>()
    var productsSearchModel = PublishRelay<PagedObject<ProductModel>>()
    var suppliersSearchModel = PublishRelay<PagedObject<SupplierModel>>()
    
    let mockApis = MockupsAPIs()
    let homeApis = HomeAPIs()
    
    func listCategories() {
        isLoading.accept(true)
        mockApis.listCategories().subscribe {[weak self] categories in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.categories.accept(categories)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    private func Filter(page: Int) {
        isLoading.accept(true)
        if selectedFilterType.value == .product {
            homeApis.SearchProducts(by: selectedCategory.value?.id, productId: selectedProduct.value?.id, page: page).subscribe { [weak self] response in
                self?.isLoading.accept(false)
                self?.productsSearchModel.accept(response)
            } onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.error.accept(error)
            }.disposed(by: disposeBag)
        } else {
            homeApis.SearchSuppliers(by: selectedCategory.value?.id,productId: selectedProduct.value?.id, page: page).subscribe {[weak self] response in
                self?.isLoading.accept(false)
                self?.suppliersSearchModel.accept(response)
            } onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.error.accept(error)
            }.disposed(by: disposeBag)
        }
    }
    
    private func search(page: Int) {
        isLoading.accept(true)
        if selectedSearchType.value == .product {
            homeApis.SearchProducts(by: searchKey.value, page: page)
                .subscribe { [weak self] response in
                self?.isLoading.accept(false)
                self?.productsSearchModel.accept(response)
            } onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.error.accept(error)
            }.disposed(by: disposeBag)
        } else {
            homeApis.SearchSuppliers(by: searchKey.value, page: page)
                .subscribe { [weak self] response in
                self?.isLoading.accept(false)
                self?.suppliersSearchModel.accept(response)
            } onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.error.accept(error)
            }.disposed(by: disposeBag)
        }
    }
    
    func filterAndSearch(page: Int) {
        if isFilter.value {
            Filter(page: page)
        } else {
            search(page: page)
        }
    }
    
}
