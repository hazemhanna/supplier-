//
//  PickerTableViewCell.swift
//  El-MOQAWEL
//
//  Created by Ahmed Madeh on 11/09/2021.
//

import UIKit

class PickerTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var pickingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
