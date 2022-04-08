//
//  LoginAlertViewController.swift
//  MoFortis
//
//  Created by MAC on 08/02/2022.
//

import UIKit

class LoginAlertViewController: PresentingViewController {
   
    @IBOutlet weak var loginView : UIView!

    var login : (() ->Void)? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.layer.cornerRadius = 25
        loginView.layer.masksToBounds = false
        loginView.clipsToBounds = false
    }
    
    // MARK: - Actions
   @IBAction func loginClicked(_ sender: UIButton) {
       dismiss(animated: true)
       login?()
    }
    
    
}
