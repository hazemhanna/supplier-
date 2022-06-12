//
//  OrderTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
