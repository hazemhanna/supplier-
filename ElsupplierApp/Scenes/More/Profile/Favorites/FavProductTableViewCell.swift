//
//  FavProductTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

protocol FavProductTableViewCellDelegate: AnyObject {
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapAdd product: TrendingProductModel)
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapFav product: TrendingProductModel)
}

class FavProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var piecesNo: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    weak var delegate: FavProductTableViewCellDelegate?
    
    var product: TrendingProductModel! {
        didSet {
            productImageView.setImageWith(stringUrl: product.mainImage)
            productTitle.text = product.name
            piecesNo.text = "-"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        delegate?.favProductTableViewCell(self, didTapAdd: product)
    }
    
    @IBAction func favClicked(_ sender: UIButton) {
        delegate?.favProductTableViewCell(self, didTapFav: product)
    }
}
