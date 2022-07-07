//
//  SupplierSearchResultTableCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/05/2022.
//

import UIKit
import Cosmos

protocol SupplierSearchResultTableCellDelegate: AnyObject {
    func supplierSearchResultTableCell(_ cell: SupplierSearchResultTableCell, didSelect product: ProductModel)
}

class SupplierSearchResultTableCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var supplierLogo: UIImageView!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var orderMinLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variables
    var supplier: SupplierModel! {
        didSet {
            supplierLogo.setImageWith(stringUrl: supplier.logo)
            supplierName.text = supplier.name
//            orderMinLabel.text = supplier.
            ratingView.rating = Double(supplier.overAllRank)
            ratingLabel.text = "\(supplier.overAllRank)/5"
            collectionView.reloadData()
        }
    }
    
    weak var delegate: SupplierSearchResultTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        collectionView.registerCell(ofType: SupplierProductSearchCollectionCell.self)
    }
    
}

extension SupplierSearchResultTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        supplier.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SupplierProductSearchCollectionCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)!
        cell.product = supplier.products[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.supplierSearchResultTableCell(self, didSelect: supplier.products[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 180)
    }
    
}
