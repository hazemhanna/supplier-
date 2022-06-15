//
//  MessagesReceverTableViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit

class MessagesReceverTableViewCell: UITableViewCell {

    @IBOutlet weak var MessageContentView: UIView!
    @IBOutlet weak var MessageContentTV: UITextView!
    @IBOutlet weak var UserContentView: UIStackView!
    @IBOutlet weak var dateLabel : UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        MessageContentTV.textContainerInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        MessageContentTV.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(date: String, Message: String, ReceiverFlag: Bool) {
        if ReceiverFlag {
            self.MessageContentView.semanticContentAttribute = .forceLeftToRight
            self.UserContentView.alignment = .trailing
            MessageContentTV.textAlignment = .left
            self.dateLabel.semanticContentAttribute = .forceLeftToRight
            dateLabel.textAlignment = .left
            self.MessageContentTV.backgroundColor = #colorLiteral(red: 0.7058823529, green: 0.9176470588, blue: 0.9960784314, alpha: 0.3)
        } else {
            self.MessageContentView.semanticContentAttribute = .forceRightToLeft
            self.UserContentView.alignment = .leading
            MessageContentTV.textAlignment = .right
            self.dateLabel.semanticContentAttribute = .forceRightToLeft
            dateLabel.textAlignment = .right
            self.MessageContentTV.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        }
        
        self.MessageContentTV.text = Message
        self.dateLabel.text = date
        self.MessageContentTV.sizeToFit()
        self.MessageContentTV.layoutIfNeeded()
    }
}
