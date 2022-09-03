//
//  FavProductTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

protocol FavProductTableViewCellDelegate: AnyObject {
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapAdd product: ProductModel)
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapFav product: ProductModel)
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapMin product: ProductModel)
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapPlus product: ProductModel)

}

class FavProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var piecesNo: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var counterLbl : UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTotalLabel: UILabel!
    
    
    weak var delegate: FavProductTableViewCellDelegate?
    var product: ProductModel! {
        didSet {
            productImageView.setImageWith(stringUrl: product.mainImage)
            productTitle.text = product.name
            piecesNo.text = "-"
            favButton.isSelected = product.isFav == 1
            piecesNo.text = product.measurmentUnit
            addButton.setTitle(product.inCart != nil ? "_remove".localized : "Add".localized, for: .normal)
            priceLabel.text = product.price.string()
            priceTotalLabel.text = product.price.string()

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
    
    @IBAction func minClicked(_ sender: UIButton) {
        delegate?.favProductTableViewCell(self, didTapMin: product)
    }
    @IBAction func plusClicked(_ sender: UIButton) {
        delegate?.favProductTableViewCell(self, didTapPlus: product)
    }
    
}
