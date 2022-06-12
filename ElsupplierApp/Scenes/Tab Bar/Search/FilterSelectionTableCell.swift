//
//  FilterSelectionTableCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 21/05/2022.
//

import UIKit

class FilterSelectionTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
