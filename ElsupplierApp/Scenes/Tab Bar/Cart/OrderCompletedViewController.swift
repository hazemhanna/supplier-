//
//  OrderCompletedViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

class OrderCompletedViewController: BaseViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func shouldShowTopView() -> Bool {
        false
    }
    
    override func shouldShowNavigation() -> Bool {
        false
    }
    
    override func shouldShowDismissButon() -> Bool {
        false
    }
    
    // MARK: - Actions
    @IBAction func ordersClicked(_ sender: UIButton) {
    }
    
    @IBAction func homeClicked(_ sender: UIButton) {
        Cache.shouldSelectHomeTab = true
        UIApplication.initWindow()
    }
}