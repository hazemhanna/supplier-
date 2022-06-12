//
//  SearchFilterViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 14/05/2022.
//

import UIKit
import RxSwift

class SearchFilterViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var filterProductButton: UIButton!
    @IBOutlet weak var filterSupplierButton: UIButton!
    @IBOutlet weak var searchKeyTF: UITextField!
    @IBOutlet weak var searchProductButton: UIButton!
    @IBOutlet weak var searchSupplierButton: UIButton!
    
    // MARK: - Variables
    let viewModel = SearchFilterViewModel()
    var selectedCategoryProducts: [ProductModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_search".localized
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.categories.bind { [weak self] in
            self?.showCategories(categories: $0)
        }.disposed(by: disposeBag)
        
        viewModel.selectedCategory.bind { [weak self] in
            self?.selectedCategoryProducts = $0?.products ?? []
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func showCategories(categories: [CategoryModel]) {
        ActionSheet.show(title: "_select_category", cancelTitle: "Cancel", otherTitles: categories.map { $0.name }, sender: deptLabel) {[weak self] index in
            if index != 0 {
                self?.viewModel.selectedCategory.accept(categories[index - 1])
                self?.deptLabel.text = categories[index - 1].name
            }
        }
    }
    
    func showProducts() {
        ActionSheet.show(title: "_select_category", cancelTitle: "Cancel", otherTitles: selectedCategoryProducts.map { $0.name }, sender: deptLabel) {[weak self] index in
            if index != 0 {
                self?.viewModel.selectedProduct.accept(self?.selectedCategoryProducts[index - 1])
                self?.productLabel.text = self?.selectedCategoryProducts[index - 1].name
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func chooseDeptClicked(_ sender: UIButton) {
        viewModel.listCategories()
    }
    
    @IBAction func chooseProductClicked(_ sender: UIButton) {
        if viewModel.selectedCategory.value != nil {
            showProducts()
        }
    }
    
    @IBAction func filterProductClicked(_ sender: UIButton) {
        filterProductButton.isSelected = true
        filterSupplierButton.isSelected = false
        viewModel.selectedFilterType.accept(.product)
    }
    
    @IBAction func filterSupplierClicked(_ sender: UIButton) {
        filterSupplierButton.isSelected = true
        filterProductButton.isSelected = false
        viewModel.selectedFilterType.accept(.supplier)
    }
    
    @IBAction func filterSearchClicked(_ sender: UIButton) {
        viewModel.isFilter.accept(true)
        if filterSupplierButton.isSelected {
            push(controller: SupplierSearchResultsViewController(viewModel: viewModel))
        }
    }
    
    @IBAction func searchProductClicked(_ sender: UIButton) {
        searchProductButton.isSelected = true
        searchSupplierButton.isSelected = false
        viewModel.selectedSearchType.accept(.product)
    }
    
    @IBAction func searchSupplierClicked(_ sender: UIButton) {
        searchSupplierButton.isSelected = true
        searchProductButton.isSelected = false
        viewModel.selectedSearchType.accept(.supplier)
    }
    
    @IBAction func searchWithKeyClicked(_ sender: UIButton) {
        viewModel.isFilter.accept(false)
        if searchSupplierButton.isSelected {
            push(controller: SupplierSearchResultsViewController(viewModel: viewModel))
        }
    }
}
