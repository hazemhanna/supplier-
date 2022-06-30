//
//  OfferCollectionViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 14/06/2022.
//

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var measurmentView: UIView!
    @IBOutlet weak var measurmentLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var offerEndDate: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var noOfferTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var hasOfferTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var minimumAmount: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    
    var product: ProductModel! {
        didSet {
            measurmentLabel.text = product.measurmentUnit
            productImage.setImageWith(stringUrl: product.mainImage, placeholder: R.image.appLogo())
            categoryLabel.text = product.categoryName
            offersView.isHidden = true
//            offerEndDate.text = product.end
            noOfferTopConstraint.priority = UILayoutPriority(rawValue: 900)
            hasOfferTopConstraint.priority = UILayoutPriority(rawValue: 750)
            productName.text = product.name
            productPrice.text = product.price.string()
            oldPrice.isHidden = true
            minimumAmount.text = "_min_amount".localized + product.orderMinAmount.string()
            supplierName.text = product.supplierName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        measurmentView.layer.maskedCorners = [.layerMaxXMaxYCorner]
        measurmentView.cornerRadius = 10
        measurmentView.layer.masksToBounds = true
        categoryView.layer.maskedCorners = [.layerMaxXMinYCorner]
        categoryView.cornerRadius = 10
        categoryView.layer.masksToBounds = true
    }

}
