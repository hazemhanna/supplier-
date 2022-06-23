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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = R.color.iceBlue()
        appearance.titleTextAttributes = [.font: UIFont.appFont(ofSize: 17, weight: .bold)!, .foregroundColor: UIColor.black]
        appearance.setBackIndicatorImage(R.image.arrowLeft(), transitionMaskImage: R.image.arrowLeft())
        let barAppearance = UIBarButtonItemAppearance(style: .plain)
        barAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.appFont(ofSize: 0.1, weight: .light)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = barAppearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.isTranslucent = true
        if Language.isArabic {
            view.semanticContentAttribute = .forceRightToLeft
            navigationBar.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    // MARK: - Functions
    
    // MARK: - Actions

}
