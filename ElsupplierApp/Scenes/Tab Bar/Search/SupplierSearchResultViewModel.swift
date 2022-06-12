//
//  SupplierSearchResultViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 17/05/2022.
//

import RxSwift
import RxCocoa

class SupplierSearchResultViewModel: BaseViewModel {

    var departmentId = BehaviorRelay<Int?>(value: nil)
    var productId = BehaviorRelay<Int?>(value: nil)
    var searchKeyword = BehaviorRelay<String?>(value: nil)
    
    var searchResults = PublishRelay<[SupplierModel]>()
    
    func getSearchResults() {
        
    }
    
}
