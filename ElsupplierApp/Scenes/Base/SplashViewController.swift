//
//  SplashViewController.swift
//  El-MOQAWEL
//
//  Created by Ahmed Madeh on 30/10/2021.
//

import UIKit

class SplashViewController: BaseViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        Cache.shouldShowSplash = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `3.0` to the desired number of seconds.
            UIApplication.initWindow()
        }
    }
    
    // MARK: - Actions

}
