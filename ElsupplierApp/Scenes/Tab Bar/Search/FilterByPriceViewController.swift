//
//  FilterByPriceViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 21/05/2022.
//

import UIKit

class FilterByPriceViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    // MARK: - Actions
    @IBAction func closeClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func applyClicked(_ sender: UIButton) {
    }
}
