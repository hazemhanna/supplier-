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
    let sliders: [SliderModel]
    
    override var isHome: Bool { false }
    
    // MARK: - Life Cycle
    init(categoryModel: CategoryModel, sliders: [SliderModel]) {
        self.categoryModel = categoryModel
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
        categoryOffersLabel.text = "offers ".localized + categoryModel.name
        deptCollectionViewHeight.constant = ((Double(categoryModel.childs.count) / 3.0).rounded(.up) * 180.0)
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    
    // MARK: - Actions

}

extension CategoriesViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == offersCollectionView ? sliders.count : categoryModel.childs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case offersCollectionView:
            let cell: HomeOfferCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            cell.slider = sliders[indexPath.row]
            return cell
        default:
            let cell: HomeDeptCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
            let child = categoryModel.childs[indexPath.row]
            cell.deptImageView.setImageWith(stringUrl: child.image, placeholder: R.image.appLogo())
            print(#function, child.image)
            cell.deptName.text = child.name
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case offersCollectionView:
            break
        default:
            push(controller: CategorySuppliersViewController(category: categoryModel.childs[indexPath.row], sliders: sliders))
        }
    }
}
