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
    @IBOutlet weak var datLbl : UILabel!

    var list : MessagesModel!{
        didSet{
            supplierName.text = list.supplier.name
            supplierImageView.setImageWith(stringUrl: list.supplier.logo)
            messageContent.text = list.body
            datLbl.text = list.date

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
