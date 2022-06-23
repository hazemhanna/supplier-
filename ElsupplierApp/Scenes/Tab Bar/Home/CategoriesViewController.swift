//
//  CategoriesViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

final class CategoriesViewController: HomeViewController {

    // MARK: - Outlets
    @IBOutlet weak var categoryOffersLabel: UILabel!
    
    // MARK: - Variables
    let categoryModel: CategoryModel
    
    // MARK: - Life Cycle
    init(categoryModel: CategoryModel) {
        self.categoryModel = categoryModel
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
        categoryOffersLabel.text = "offers ".localized + categoryModel.name
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    
    override func setupCallbacks() {
        viewModel.supplierDetails.bind { [weak self] in
            self?.push(controller: SupplierDetailsViewController(supplier: $0))
        }.disposed(by: disposeBag)
    }
    // MARK: - Actions

}

extension CategoriesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryModel.childs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeDeptCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        let child = categoryModel.childs[indexPath.row]
        cell.deptImageView.setImageWith(stringUrl: child.image)
        cell.deptName.text = child.name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getSupplierDetails(with: categoryModel.childs[indexPath.row].id)
    }
}
