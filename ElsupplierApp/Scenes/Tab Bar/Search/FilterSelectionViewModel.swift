//
//  FilterSelectionViewModel.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 21/05/2022.
//

import RxSwift
import RxCocoa

class FilterSelectionViewModel: BaseViewModel {
    
    let mockupsApis = MockupsAPIs()

    var filterItems = PublishRelay<[PickerModel]>()
    
    func listAreas() {
        isLoading.accept(true)
        mockupsApis.listAreas().subscribe {[weak self] areas in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.filterItems.accept(areas)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    func listCategories() {
        isLoading.accept(true)
        mockupsApis.listMockCategories().subscribe {[weak self] areas in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.filterItems.accept(areas)
        } onError: {[weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
}
