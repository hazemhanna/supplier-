//
//  TenderTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/06/2022.
//

import UIKit

class TenderTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Variables
    var tender: TenderModel! {
        didSet {
            categoryName.text = tender.category
            productName.text = tender.product
            dateLabel.text = tender.date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
