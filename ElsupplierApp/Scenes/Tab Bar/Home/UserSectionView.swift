//
//  UserSectionView.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 12/04/2022.
//

import UIKit

protocol UserSectionViewDelegate: AnyObject {
    func didTapNotifications()
    func didTapProfile()
    func didTapSearch()
}

class UserSectionView: ReusableView {

    // MARK: - Outlets
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var userPic: UIImageView!
    
    // MARK: - Variables
    weak var delegate: UserSectionViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTF.delegate = self
    }
    
    @IBAction func profileClicked(_ sender: UIButton) {
        delegate?.didTapProfile()
    }
    
    @IBAction func notificationsClicked(_ sender: UIButton) {
        delegate?.didTapNotifications()
    }
}

extension UserSectionView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.didTapSearch()
        return false
    }
}
