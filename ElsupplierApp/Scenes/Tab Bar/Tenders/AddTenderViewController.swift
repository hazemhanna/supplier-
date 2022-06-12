//
//  AddTenderViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/06/2022.
//

import UIKit

class AddTenderViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var selectedProductLabel: UILabel!
    @IBOutlet weak var tenderDetailsTV: UITextView!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    let searchFilterViewModel = SearchFilterViewModel()
    var selectedCategory: CategoryModel? = nil

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_new_tender".localized
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        searchFilterViewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.tenderAdded.bind { [weak self] _ in
            Alert.show(title: nil, message: "_tender_added", cancelTitle: "_ok", otherTitles: []) { _ in
                self?.pop()
            }
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        searchFilterViewModel.categories.bind { [weak self] in
            self?.showCategories($0)
        }.disposed(by: disposeBag)
        
        searchFilterViewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func showCategories(_ categories: [CategoryModel]) {
        ActionSheet.show(title: "_choose_category", cancelTitle: "Cancel", otherTitles: categories.map({ $0.name }), sender: view) { [weak self] index in
            guard let self = self, index != 0 else { return }
            self.selectedCategoryLabel.text = categories[index - 1].name
            self.selectedCategory = categories[index - 1]
            self.viewModel.selectedCategory.accept(categories[index - 1].id)
        }
    }
    
    // MARK: - Actions
    @IBAction func selectCategoryClicked(_ sender: UIButton) {
        searchFilterViewModel.listCategories()
    }
    
    @IBAction func selectProductClicked(_ sender: UIButton) {
        guard let products = selectedCategory?.products else { return }
        ActionSheet.show(title: "_choose_product", cancelTitle: "Cancel", otherTitles: products.map { $0.name }, sender: view) { [weak self] index in
            guard let self = self, index != 0 else { return }
            self.selectedProductLabel.text = products[index - 1].name
            self.viewModel.selectedProduct.accept(products[index - 1].id)
        }
    }
    
    @IBAction func sendClicked(_ sender: UIButton) {
        viewModel.storeTender()
    }
}
