//
//  PriceRequestTableViewCell.swift
//  ElsupplierApp
//
//  Created by MAC on 03/07/2022.
//

import UIKit


protocol PriceRequestTableViewCellDelegate: AnyObject {
    func priceRequestTableViewCell(_ cell: PriceRequestTableViewCell)
    func priceRequestTableViewCell(_ cell: PriceRequestTableViewCell, didChangeModel at: Int, price: PriceRequeste)

}

class PriceRequestTableViewCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var selectedProductLabel: UILabel!
    @IBOutlet weak var ProductCount: UITextField!

    var price:PriceRequeste!{
        didSet{
            selectedProductLabel.text = price.productName
            ProductCount.text = "\(price.quantity)"
          
        }
    }
    
    var index = -1
    
    weak var delegate: PriceRequestTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func selectProductClicked(_ sender: UIButton) {
        delegate?.priceRequestTableViewCell(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        if textField == ProductCount &&  !ProductCount.isEmpty{
            price.quantity = Int(textField.text!) ?? 0
        }
        
      delegate?.priceRequestTableViewCell(self, didChangeModel: index, price: price)
    }
    
    override func didMoveToSuperview() {
        ProductCount.delegate = self
    }
}
