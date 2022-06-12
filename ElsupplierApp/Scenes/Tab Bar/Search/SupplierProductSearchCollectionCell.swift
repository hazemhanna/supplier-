//
//  SupplierProductSearchCollectionCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 17/05/2022.
//

import UIKit

class SupplierProductSearchCollectionCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    var product: ProductModel! {
        didSet {
            productImageView.setImageWith(stringUrl: product.mainImage)
            productName.text = product.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
