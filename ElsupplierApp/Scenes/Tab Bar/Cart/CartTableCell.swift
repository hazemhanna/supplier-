//
//  CartTableCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import UIKit

protocol CartTableCellDelegate: AnyObject {
    func cartTableCell(_ cell: CartTableCell, didRemove item: CartItem)
}

class CartTableCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var piecesCount: UILabel!
    
    weak var delegate: CartTableCellDelegate?
    var item: CartItem! {
        didSet {
            productImageView.setImageWith(stringUrl: item.image)
            productName.text = item.productName
            productPrice.text = item.price.string() + " LE"
            piecesCount.text = "_pieces_count".localized + item.quantity.string()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func removeFromCartClicked(_ sender: UIButton) {
        delegate?.cartTableCell(self, didRemove: item)
    }
    
}
