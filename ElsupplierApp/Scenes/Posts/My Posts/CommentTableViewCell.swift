//
//  CommentTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 03/09/2022.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var suerImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // MARK: - Variables
    var comment: CommentModel! {
        didSet {
            suerImageView.setImageWith(stringUrl: comment.userImage, placeholder: R.image.appLogo())
            usernameLabel.text = comment.userName
            dateLabel.text = comment.createdAt
            commentLabel.text = comment.comment
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
