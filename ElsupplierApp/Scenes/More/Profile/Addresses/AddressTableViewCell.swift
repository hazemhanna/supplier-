//
//  AddressTableViewCell.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 10/05/2022.
//

import UIKit

protocol AddressTableViewCellDelegate: AnyObject {
    func addressTableViewCell(_ cell: AddressTableViewCell, didPressDelete address: AddressModel)
    func addressTableViewCell(_ cell: AddressTableViewCell, didPressEdit address: AddressModel)
}

class AddressTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var mainAddressLabel: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var addressTitleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    // MARK: - Variables
    weak var delegate: AddressTableViewCellDelegate?
    var address: AddressModel! {
        didSet {
            mainAddressLabel.isHidden = !address.isSelected
            selectionButton.isSelected = address.isSelected
            addressTitleLabel.text = address.address
            mainView.borderColor = address.isSelected ? R.color.darkBlue()! : R.color.lightBlue()!
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Actions
    @IBAction func deleteClicked(_ sender: UIButton) {
        delegate?.addressTableViewCell(self, didPressDelete: address)
    }
    
    @IBAction func editClicked(_ sender: UIButton) {
        delegate?.addressTableViewCell(self, didPressEdit: address)
    }
}
