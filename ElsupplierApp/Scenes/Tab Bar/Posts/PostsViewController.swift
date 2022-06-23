//
//  PostsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class PostsViewController: BaseTabBarViewController {

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
        "Posts".localized
    }
    override func tabBarItemImage() -> UIImage? {
        R.image.posts()
    }
    override func tabBarItemSelectedImage() -> UIImage? {
        R.image.postsActive()
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    // MARK: - Actions

}
