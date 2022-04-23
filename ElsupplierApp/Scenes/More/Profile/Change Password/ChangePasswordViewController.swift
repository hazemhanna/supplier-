//
//  ChangePasswordViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var currentPassTF: UITextField!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var confirmNewPassTF: UIView!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_change_password".localized
    }
    
    // MARK: - Actions
    @IBAction func cofirmClicked(_ sender: UIButton) {
        push(controller: PasswordChangedViewController())
    }
    
}
