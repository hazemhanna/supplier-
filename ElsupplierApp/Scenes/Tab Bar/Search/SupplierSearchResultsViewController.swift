//
//  SupplierSearchResultsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 17/05/2022.
//

import UIKit

class SupplierSearchResultsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var areasLabel: UILabel!
    @IBOutlet weak var deptsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let viewModel = SearchFilterViewModel()
    let viewModel2 = HomeViewModel()
    var model = PagedObject<SupplierModel>()
    var keyword: String?
    var selectedCategory: Int?
    var selectedParentCategory: Int?
    var priceFrom: Int?
    var priceTo: Int?
    var areaId: Int?
    
    // MARK: - Life Cycle
    init(keyword: String?, selectedCategory: Int?, selectedParentCategory: Int?) {
        self.keyword = keyword
        self.selectedCategory = selectedCategory
        self.selectedParentCategory = selectedParentCategory
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_search_results".localized
        tableView.registerCell(ofType: SupplierSearchResultTableCell.self)
        viewModel.filterSuppliers(isPromotion: 0,
                                  page: model.nextPage,
                                  keyword: keyword,
                                  parentCategoryId: selectedParentCategory,
                                  categoryId: selectedCategory,
                                  areaId: areaId,
                                  priceFrom: priceFrom,
                                  priceTo: priceTo)
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        
        viewModel2.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.suppliersSearchModel.bind {[weak self] in
            self?.model.append($0)
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel2.supplierDetails.bind { [weak self] in
            self?.push(controller: SupplierDetailsViewController(supplier: $0))
        }.disposed(by: disposeBag)
        viewModel2.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func areasClicked(_ sender: UIButton) {
        present(FilterSelectionViewController(type: .areas, delegate: self), animated: true)
    }
    
    @IBAction func deptsClicked(_ sender: UIButton) {
        present(FilterSelectionViewController(type: .departments, delegate: self), animated: true)
    }
    
    @IBAction func priceClicked(_ sender: UIButton) {
        present(FilterByPriceViewController(delegate: self), animated: true)
    }
}

extension SupplierSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SupplierSearchResultTableCell = tableView.dequeueReusableCell()!
        cell.supplier = model.items[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel2.getSupplierDetails(with: model.items[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            viewModel.filterSuppliers(isPromotion: 0, page: model.nextPage, keyword: keyword, parentCategoryId: selectedParentCategory, categoryId: selectedCategory, areaId: areaId, priceFrom: priceFrom, priceTo: priceTo)
        }
    }
    
}

extension SupplierSearchResultsViewController: SupplierSearchResultTableCellDelegate {
    func supplierSearchResultTableCell(_ cell: SupplierSearchResultTableCell, didSelect product: ProductModel) {
        push(controller: ProductDetailsViewController(product: product))
    }
}

extension SupplierSearchResultsViewController: FilterSelectionViewControllerDelegate {
    func didSelectArea(area: PickerModel) {
        areaId = area.id
        areasLabel.text = area.name
        model.items.removeAll()
        viewModel.filterSuppliers(isPromotion: 0, page: model.nextPage, keyword: keyword, parentCategoryId: selectedParentCategory, categoryId: selectedCategory, areaId: areaId, priceFrom: priceFrom, priceTo: priceTo)
    }
    func didSelectDipartment(dept: PickerModel) {
        selectedCategory = dept.id
        deptsLabel.text = dept.name
        model.items.removeAll()
        viewModel.filterSuppliers(isPromotion: 0, page: model.nextPage, keyword: keyword, parentCategoryId: selectedParentCategory, categoryId: selectedCategory, areaId: areaId, priceFrom: priceFrom, priceTo: priceTo)
    }
}

extension SupplierSearchResultsViewController: FilterByPriceViewControllerDelegate {
    func didSelectPrice(priceFrom: Int?, priceTo: Int?) {
        self.priceFrom = priceFrom
        self.priceTo = priceTo
        model.items.removeAll()
        viewModel.filterSuppliers(isPromotion: 0, page: model.nextPage, keyword: keyword, parentCategoryId: selectedParentCategory, categoryId: selectedCategory, areaId: areaId, priceFrom: priceFrom, priceTo: priceTo)
    }
}
