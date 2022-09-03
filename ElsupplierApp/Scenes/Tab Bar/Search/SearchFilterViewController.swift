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
    var selectedCategoryProducts: [CategoryChildModel] = []
    
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
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.categories.bind { [weak self] in
            self?.showCategories(categories: $0)
        }.disposed(by: disposeBag)
        
        viewModel.selectedCategory.bind { [weak self] in
            self?.selectedCategoryProducts = $0?.childs ?? []
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
            } else {
                self?.viewModel.selectedCategory.accept(nil)
                self?.deptLabel.text = "_choose_dept"
            }
        }
    }
    
    func showProducts() {
        ActionSheet.show(title: "_choose_sub_cat", cancelTitle: "Cancel", otherTitles: selectedCategoryProducts.map { $0.name }, sender: deptLabel) {[weak self] index in
            if index != 0 {
                self?.viewModel.selectedProduct.accept(self?.selectedCategoryProducts[index - 1])
                self?.productLabel.text = self?.selectedCategoryProducts[index - 1].name
            } else {
                self?.viewModel.selectedProduct.accept(nil)
                self?.productLabel.text = "_choose_sub_cat"
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func chooseDeptClicked(_ sender: UIButton) {
        viewModel.listParentCategories()
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
        if viewModel.selectedCategory.value == nil {
            return Alert.show(message: "_choose_dept")
        }
        if viewModel.selectedProduct.value == nil {
            return Alert.show(message: "_choose_sub_cat")
        }
        
        viewModel.isFilter.accept(true)
        if filterSupplierButton.isSelected {
            push(
                controller: SupplierSearchResultsViewController(
                    keyword: searchKeyTF.text,
                    selectedCategory: viewModel.selectedProduct.value?.name,
                    selectedParentCategory: viewModel.selectedCategory.value?.name
                )
            )
        } else {
            push(
                controller: ProductsSearchResultsViewController(
                    keyword: searchKeyTF.text,
                    selectedCategory: viewModel.selectedProduct.value?.name,
                    selectedParentCategory: viewModel.selectedCategory.value?.name
                )
            )
        }
    }
    
    @IBAction func searchProductClicked(_ sender: UIButton) {
        searchProductButton.isSelected = true
        searchSupplierButton.isSelected = false
        searchKeyTF.placeholder = "_search_for_product".localized
        viewModel.selectedSearchType.accept(.product)
    }
    
    @IBAction func searchSupplierClicked(_ sender: UIButton) {
        searchSupplierButton.isSelected = true
        searchProductButton.isSelected = false
        searchKeyTF.placeholder = "_search_for_supplier".localized
        viewModel.selectedSearchType.accept(.supplier)
    }
    
    @IBAction func searchWithKeyClicked(_ sender: UIButton) {
        viewModel.isFilter.accept(false)
        if searchSupplierButton.isSelected {
            push(
                controller: SupplierSearchResultsViewController(
                    keyword: searchKeyTF.text,
                    selectedCategory: viewModel.selectedProduct.value?.name,
                    selectedParentCategory: viewModel.selectedCategory.value?.name
                )
            )
        } else {
            push(
                controller: ProductsSearchResultsViewController(
                    keyword: searchKeyTF.text,
                    selectedCategory: viewModel.selectedProduct.value?.name,
                    selectedParentCategory: viewModel.selectedCategory.value?.name
                )
            )
        }
    }
}
