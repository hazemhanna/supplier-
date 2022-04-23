//
//  NotificationTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationType: UILabel!
    @IBOutlet weak var notificationDate: UILabel!
    @IBOutlet weak var notificationDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
