//
//  BaseTabBarController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

class BaseTabBarController: UITabBarController {

    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [CartViewController(),
                                AddTenderViewController(isFromTabbar: true),
                                NavigationController(rootViewController: HomeViewController()),
                                FavoritesViewController(),
                                MyPostsViewController()]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Cache.shouldSelectHomeTab {
            selectedIndex = 2
            Cache.shouldSelectHomeTab = false
        }
    }
    
    // MARK: - Functions
    private func styleTabBar() {
//        delegate = self
        let font = R.font.cairoMedium(size: 10)!
        let selectedFont = R.font.cairoBold(size: 10)!
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font],
                                                         for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: selectedFont], for: .selected)
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.tintColor = R.color.darkBlue()
        tabBar.unselectedItemTintColor = R.color.lightBlue()
    }
    
//    func checkLoggedInUser() -> Bool {
//        if UserModel.current == nil {
//            Alert.show(title: "You should login first", message: nil, cancelTitle: "Later", otherTitles: ["Login"]) { index in
//                if index == 1 {
//                    self.push(controller: LoginViewController())
//                }
//            }
//            return false
//        }
//        return true
//    }
        
    // MARK: - Actions

}

