//
//  BaseTabBarViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class BaseTabBarViewController: BaseViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = tabBarItemTitle()?.localized
        tabBarItem.image = tabBarItemImage()
        tabBarItem.selectedImage = tabBarItemSelectedImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.title = title
    }
    
    // MARK: - Functions
    func tabBarItemTitle() -> String? {
        return nil
    }
    
    func tabBarItemImage() -> UIImage? {
        return nil
    }
    
    func tabBarItemSelectedImage() -> UIImage? {
        return nil
    }
    
    // MARK: - Actions

}
