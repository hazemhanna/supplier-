//
//  PaymentTypeTableCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import UIKit

class PaymentTypeTableCell: UITableViewCell {

    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var typeName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var paymentType: PaymentTypeModel! {
        didSet {
            selectionButton.isSelected = paymentType.isSelected
            typeName.text = paymentType.name
            containerView.borderColor = paymentType.isSelected ? R.color.darkBlue()! : R.color.lightBlue()!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
