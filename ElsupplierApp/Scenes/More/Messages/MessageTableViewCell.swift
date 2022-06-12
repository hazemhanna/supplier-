//
//  MessageTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/06/2022.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var supplierImageView: UIImageView!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
