//
//  ImageCollectionViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var imageNumber : UILabel!
    @IBOutlet weak var playImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
