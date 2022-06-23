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
    }
    
    // MARK: - Actions

}

extension SupplierProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supplier.categoryProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SupplierProductCategoryCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.categoryName.text = supplier.categoryProducts[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let textWidth = supplier.categoryProducts[indexPath.row].name.widthOfString (usingFont: .appFont(ofSize: 14, weight: .bold)!) + 40
        return CGSize(width: textWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension SupplierProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplier.categoryProducts[selectedIndex].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavProductTableViewCell = tableView.dequeueReusableCell()!
        cell.supplierProduct = supplier.categoryProducts[selectedIndex].products[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: ProductDetailsViewController(product: supplier.categoryProducts[selectedIndex].products[indexPath.row]))
    }
    
}
