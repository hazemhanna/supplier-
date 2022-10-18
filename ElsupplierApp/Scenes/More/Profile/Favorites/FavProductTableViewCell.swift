//
//  FavProductTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

protocol FavProductTableViewCellDelegate: AnyObject {
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapAdd product: ProductModel)
    func favProductTableViewCell(_ cell: FavProductTableViewCell, didTapPriceRequest product: ProductModel)
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
    @IBOutlet weak var plusButton: UIButton!
     @IBOutlet weak var minusButton: UIButton!
    
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
            if product.price == 0 {
                priceLabel.isHidden = true
                priceTotalLabel.isHidden = true
                plusButton.isHidden = true
                minusButton.isHidden = true
                counterLbl.isHidden = true
                if product.rfqSend == 0{
                    addButton.setTitle("_request_price".localized, for: .normal)
                }else{
                    addButton.isEnabled = false
                    addButton.setTitle("_request_price_done".localized, for: .normal)
                    addButton.backgroundColor = UIColor(red: 0/255, green: 178/255, blue: 243/255, alpha: 1)
                }
             }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func addClicked(_ sender: UIButton) {
        if product.price == 0 {
            delegate?.favProductTableViewCell(self, didTapPriceRequest: product)
            return
         }
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
