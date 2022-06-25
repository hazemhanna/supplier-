//
//  CategorySuppliersViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 25/06/2022.
//

import UIKit

class CategorySuppliersViewController: HomeViewController {

    // MARK: - Outlets
    @IBOutlet weak var categoryOffersLabel: UILabel!
    @IBOutlet weak var CategorySuppliers: UILabel!
    
    // MARK: - Variables
    let category: CategoryChildModel
    let sliders: [SliderModel]
    var suppliers = PagedObject<SupplierModel>()
    
    // MARK: - Life Cycle
    init(category: CategoryChildModel, sliders: [SliderModel]) {
        self.category = category
        self.sliders = sliders
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
        viewModel.loadCategorySuppliers(categoryId: category.id, page: suppliers.nextPage)
        categoryOffersLabel.text = "offers ".localized + category.name
        CategorySuppliers.text = "suppliers ".localized + category.name
    }
    
    override func setupCallbacks() {
        super.setupCallbacks()
        viewModel.suppliers.bind { [weak self] in
            guard let self = self else { return }
            self.suppliers.append($0)
            self.deptCollectionViewHeight.constant = CGFloat((self.suppliers.items.count / 3) * 180)
            self.deptCollectionView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.supplierDetails.bind { [weak self] in
            self?.push(controller: SupplierDetailsViewController(supplier: $0))
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions

}

extension CategorySuppliersViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == offersCollectionView ? sliders.count : suppliers.items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case offersCollectionView:
            let cell: HomeOfferCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            cell.slider = sliders[indexPath.row]
            return cell
        default:
            let cell: HomeDeptCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            let child = suppliers.items[indexPath.row]
            cell.deptImageView.setImageWith(stringUrl: child.logo, placeholder: R.image.appLogo())
            cell.deptName.text = child.name
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case offersCollectionView:
            break
        default:
            viewModel.getSupplierDetails(with: suppliers.items[indexPath.row].id)
        }
    }
}
