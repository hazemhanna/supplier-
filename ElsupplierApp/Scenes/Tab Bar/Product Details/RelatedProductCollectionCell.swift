//
//  RelatedProductCollectionCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 27/05/2022.
//

import UIKit

class RelatedProductCollectionCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var piecesView: UIView!
    @IBOutlet weak var piecesNo: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var requestPriceButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    
    var product: ProductModel! {
        didSet {
            piecesNo.text = product.measurmentUnit
            productImage.setImageWith(stringUrl: product.mainImage, placeholder: R.image.appLogo())
            categoryLabel.text = product.categoryName
            productName.text = product.name
            priceLabel.text = product.price.string()
            descLabel.text = product.desc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        piecesView.layer.maskedCorners = Language.isArabic ? [.layerMinXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        piecesView.cornerRadius = 5
        categoryView.layer.maskedCorners = Language.isArabic ? [.layerMinXMinYCorner, .layerMaxXMaxYCorner] : [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        categoryView.cornerRadius = 5
    }

    // MARK: - Actions
    @IBAction func requestPriceClicked(_ sender: UIButton) {
    }
}
