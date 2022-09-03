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
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Variables
    var tender: TenderModel! {
        didSet {
            categoryName.text = tender.subCategory
            productName.text = tender.product + "\n" + tender.message
            dateLabel.text = tender.date
            statusLabel.text = tender.status.rawValue
            statusView.backgroundColor = tender.color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
