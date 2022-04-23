//
//  CartViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class CartViewController: BaseTabBarViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
    }
    
    override func tabBarItemTitle() -> String? {
        "Cart".localized
    }
    override func tabBarItemImage() -> UIImage? {
        R.image.cart()
    }
    override func tabBarItemSelectedImage() -> UIImage? {
        R.image.cartActive()
    }
    
    // MARK: - Actions

}
