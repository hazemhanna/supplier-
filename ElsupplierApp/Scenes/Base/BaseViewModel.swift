//
//  BaseViewModel.swift
//  MoFortis
//
//  Created by Ahmed Madeh on 07/11/2021.
//

import RxSwift
import RxRelay

class BaseViewModel {

    // MARK: - Variables
    let disposeBag = DisposeBag()
    let error = PublishRelay<Error>()
    let isLoading = PublishRelay<Bool>()
    
    required init() {}
}
