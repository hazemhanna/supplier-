//
//  SupplierDetailsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 11/06/2022.
//

import UIKit
import Cosmos

class SupplierDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var supplierImageView: UIImageView!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Variables
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
    }
    
    // MARK: - Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
    
}
