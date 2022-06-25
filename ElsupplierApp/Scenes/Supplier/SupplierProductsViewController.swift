//
//  SupplierProductsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/06/2022.
//

import UIKit

class SupplierProductsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let supplier: SupplierDetailsModel
    var selectedIndex = 0
    
    // MARK: - Life Cycle
    init(supplier: SupplierDetailsModel) {
        self.supplier = supplier
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
        tableView.registerCell(ofType: FavProductTableViewCell.self)
        collectionView.registerCell(ofType: SupplierProductCategoryCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.semanticContentAttribute = .forceLeftToRight
        if Language.isArabic {
            collectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        supplier.categoryProducts.first?.isSelected = true
    }
    
    // MARK: - Actions

}

extension SupplierProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        supplier.categoryProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SupplierProductCategoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        if Language.isArabic {
            cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        cell.categoryName.text = supplier.categoryProducts[indexPath.row].name
        cell.bgView.backgroundColor = supplier.categoryProducts[indexPath.row].isSelected ? R.color.lightBlue() : .white
        cell.bgView.borderWidth = supplier.categoryProducts[indexPath.row].isSelected ? 0 : 1
        cell.bgView.borderColor = R.color.lightBlue()!
        cell.categoryName.textColor = supplier.categoryProducts[indexPath.row].isSelected ? UIColor.white : R.color.lightBlue()
        cell.bgView.cornerRadius = cell.bgView.frame.height / 2
        cell.bgView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textWidth = supplier.categoryProducts[indexPath.row].name.widthOfString (usingFont: .appFont(ofSize: 14, weight: .bold)!) + 40
        return CGSize(width: textWidth, height: collectionView.frame.height - 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        supplier.categoryProducts.forEach { item in
            item.isSelected = false
        }
        supplier.categoryProducts[indexPath.row].isSelected = true
        collectionView.reloadData()
        tableView.reloadData()
    }
    
}

extension SupplierProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        supplier.categoryProducts.isEmpty ? 0 : supplier.categoryProducts[selectedIndex].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavProductTableViewCell = tableView.dequeueReusableCell()!
        cell.product = supplier.categoryProducts[selectedIndex].products[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: ProductDetailsViewController(product: supplier.categoryProducts[selectedIndex].products[indexPath.row]))
    }
    
}

extension SupplierProductsViewController: FavProductTableViewCellDelegate {
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapAdd product: ProductModel) {
        
    }
    
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapFav product: ProductModel) {
        
    }
}
