//
//  PriceRequestTableViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 03/07/2022.
//

import UIKit


protocol PriceRequestTableViewCellDelegate: AnyObject {
    func priceRequestTableViewCell(_ cell: PriceRequestTableViewCell)
}

class PriceRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var selectedProductLabel: UILabel!
    @IBOutlet weak var ProductCount: UITextField!

    weak var delegate: PriceRequestTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func selectProductClicked(_ sender: UIButton) {
        delegate?.priceRequestTableViewCell(self)
    }
}
