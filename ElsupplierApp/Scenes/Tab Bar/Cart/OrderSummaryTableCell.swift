//
//  OrderSummaryTableCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

class OrderSummaryTableCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var piecesNo: UILabel!
    
    var product: CartItem! {
        didSet {
            productImageView.setImageWith(stringUrl: product.product.mainImage)
            productName.text = product.product.name
            priceLabel.text = product.product.price.string() + " LE".localized
            piecesNo.text = "_pieces: ".localized + product.quantity.string()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
