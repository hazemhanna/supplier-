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
    var selectedProduct = BehaviorRelay<CategoryChildModel?>(value: nil)
    var selectedFilterType = BehaviorRelay<SearchType>(value: .product)
    var selectedSearchType = BehaviorRelay<SearchType>(value: .product)
    var searchKey = BehaviorRelay<String>(value: "")
    var isFilter = BehaviorRelay<Bool>(value: false)

    var categories = PublishRelay<[CategoryModel]>()
    var categoryProducts = PublishRelay<[ProductModel]>()
    var productsSearchModel = PublishRelay<PagedObject<ProductModel>>()
    var suppliersSearchModel = PublishRelay<PagedObject<SupplierModel>>()
    
    let mockApis = MockupsAPIs()
    let homeApis = HomeAPIs()
    
    func listParentCategories() {
        isLoading.accept(true)
        mockApis.listParentCategories().subscribe { [weak self] categories in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.categories.accept(categories)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listCategories() {
        isLoading.accept(true)
        mockApis.listCategories().subscribe { [weak self] categories in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.categories.accept(categories)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listCategoryProducts(categoryId: Int) {
        isLoading.accept(true)
        mockApis.listCategoryProducts(categoryId: categoryId).subscribe { [weak self] products in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.categoryProducts.accept(products)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func filterSuppliers
    (
        isPromotion: Int,
        page: Int,
        keyword: String? = nil,
        parentCategoryId: String? = nil,
        categoryId: String? = nil,
        areaId: Int?,
        priceFrom: Int? = nil,
        priceTo: Int? = nil
    ) {
        isLoading.accept(true)
        homeApis.filterSuppliers(isPromotion: isPromotion, page: page, keyword: keyword, parentCategoryId: parentCategoryId, categoryId: categoryId, areaId: areaId, priceFrom: priceFrom, priceTo: priceTo).subscribe { [weak self] response in
            self?.isLoading.accept(false)
            self?.suppliersSearchModel.accept(response)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func filterProducts
    (
        isPromotion: Int,
        page: Int,
        keyword: String? = nil,
        parentCategoryId: String? = nil,
        categoryId: String? = nil,
        areaId: Int?,
        priceFrom: Int? = nil,
        priceTo: Int? = nil
    ) {
        isLoading.accept(true)
        homeApis.filterProducts(
            isPromotion: isPromotion,
            page: page,
            keyword: keyword,
            parentCategoryId: parentCategoryId,
            categoryId: categoryId,
            areaId: areaId,
            priceFrom: priceFrom,
            priceTo: priceTo
        ).subscribe { [weak self] response in
            self?.isLoading.accept(false)
            self?.productsSearchModel.accept(response)
        } onError: { [weak self] error in
            self?.isLoading.accept(false)
            self?.error.accept(error)
        }.disposed(by: disposeBag)
    }
}
