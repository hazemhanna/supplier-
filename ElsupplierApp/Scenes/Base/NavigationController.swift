//
//  NavigationController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: - Outlets
    
    // MARK: - Variables    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .black
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = R.color.darkBlue()
        if Language.isArabic {
            view.semanticContentAttribute = .forceRightToLeft
            navigationBar.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Actions

}
