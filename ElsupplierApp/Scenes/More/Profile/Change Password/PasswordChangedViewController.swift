//
//  PasswordChangedViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class PasswordChangedViewController: BaseViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    // MARK: - Actions
    @IBAction func profileClicked(_ sender: UIButton) {
        navigationController?.popViewController(backIndex: 3)
    }
    
    @IBAction func homeClicked(_ sender: UIButton) {
        UIApplication.initWindow()
    }
}
