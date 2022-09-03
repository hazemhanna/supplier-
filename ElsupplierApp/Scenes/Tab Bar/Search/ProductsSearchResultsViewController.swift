//
//  ProductsSearchResultsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 29/06/2022.
//

import UIKit

class ProductsSearchResultsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var areasLabel: UILabel!
    @IBOutlet weak var deptsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var keywordForSearch: UILabel!
    
    // MARK: - Variables
    let viewModel = SearchFilterViewModel()
    var model = PagedObject<ProductModel>()
    var keyword: String?
    var selectedCategory: String?
    var selectedParentCategory: String?
    var priceFrom: Int?
    var priceTo: Int?
    var areaId: Int?
    @IBOutlet weak var noProductsLabel: UILabel!
    
    // MARK: - Life Cycle
    init(
        keyword: String?,
        selectedCategory: String?,
        selectedParentCategory: String?
    ) {
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
        keywordForSearch.text = keyword ?? ""
        collectionView.registerCell(ofType: OfferCollectionViewCell.self)
        
        viewModel.filterProducts(
            isPromotion: 0,
            page: model.nextPage,
            keyword: keyword,
            parentCategoryId: selectedParentCategory,
            categoryId: selectedCategory,
            areaId: areaId,
            priceFrom: priceFrom,
            priceTo: priceTo
        )
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.productsSearchModel.bind {[weak self] in
            self?.model.append($0)
            self?.collectionView.reloadData()
            self?.noProductsLabel.isHidden = !(self?.model.items.isEmpty ?? true)
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
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

extension ProductsSearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OfferCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.product = model.items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        push(controller: ProductDetailsViewController(product: model.items[indexPath.row]))
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            viewModel.filterProducts(
                isPromotion: 0,
                page: model.nextPage,
                keyword: keyword,
                parentCategoryId: selectedParentCategory,
                categoryId: selectedCategory,
                areaId: areaId,
                priceFrom: priceFrom,
                priceTo: priceTo
            )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat((collectionView.frame.width - 10) / 2)
        let height = 460.0
        return CGSize(width: width, height: height)
    }
}

extension ProductsSearchResultsViewController: SupplierSearchResultTableCellDelegate {
    func supplierSearchResultTableCell(_ cell: SupplierSearchResultTableCell, didSelect product: ProductModel) {
        push(controller: ProductDetailsViewController(product: product))
    }
}

extension ProductsSearchResultsViewController: FilterSelectionViewControllerDelegate {
    func didSelectArea(area: PickerModel) {
        areaId = area.id
        areasLabel.text = area.name
        model.items.removeAll()
        collectionView.reloadData()
        
        viewModel.filterProducts(
            isPromotion: 0,
            page: model.nextPage,
            keyword: keyword,
            parentCategoryId: selectedParentCategory,
            categoryId: selectedCategory,
            areaId: areaId,
            priceFrom: priceFrom,
            priceTo: priceTo
        )
    }
    
    func didSelectDipartment(dept: PickerModel) {
        selectedCategory = dept.name
        deptsLabel.text = dept.name
        model.items.removeAll()
        collectionView.reloadData()
        
        viewModel.filterProducts(
            isPromotion: 0,
            page: model.nextPage,
            keyword: keyword,
            parentCategoryId: selectedParentCategory,
            categoryId: selectedCategory,
            areaId: areaId,
            priceFrom: priceFrom,
            priceTo: priceTo
        )
    }
}

extension ProductsSearchResultsViewController: FilterByPriceViewControllerDelegate {
    func didSelectPrice(priceFrom: Int?, priceTo: Int?) {
        self.priceFrom = priceFrom
        self.priceTo = priceTo
        model.items.removeAll()
        collectionView.reloadData()
        
        viewModel.filterProducts(
            isPromotion: 0,
            page: model.nextPage,
            keyword: keyword,
            parentCategoryId: selectedParentCategory,
            categoryId: selectedCategory,
            areaId: areaId,
            priceFrom: priceFrom,
            priceTo: priceTo
        )
    }
}
