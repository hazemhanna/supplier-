//
//  HomeOfferCollectionViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class HomeOfferCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var offerImageView: UIImageView!
    
    // MARK: - Variables
    var slider: SliderModel! {
        didSet {
            offerImageView.setImageWith(stringUrl: slider.image)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
