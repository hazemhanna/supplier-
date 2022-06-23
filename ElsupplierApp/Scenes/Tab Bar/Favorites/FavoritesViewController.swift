//
//  FavoritesViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class FavoritesViewController: BaseTabBarViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
    }
    
    override func tabBarItemTitle() -> String? {
        "Favorites".localized
    }
    
    override func tabBarItemImage() -> UIImage? {
        R.image.fav()
    }
    
    override func tabBarItemSelectedImage() -> UIImage? {
        R.image.favActive()
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    // MARK: - Actions

}
