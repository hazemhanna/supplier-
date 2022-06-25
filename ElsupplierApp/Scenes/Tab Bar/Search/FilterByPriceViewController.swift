//
//  FilterByPriceViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 21/05/2022.
//

import UIKit

protocol FilterByPriceViewControllerDelegate: AnyObject {
    func didSelectPrice(priceFrom: Int?, priceTo: Int?)
}

class FilterByPriceViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    
    // MARK: - Variables
    var fromPrice: Int?
    var toPrice: Int?
    weak var delegate: FilterByPriceViewControllerDelegate?
    
    // MARK: - Life Cycle
    init(delegate: FilterByPriceViewControllerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    
    // MARK: - Actions
    @IBAction func closeClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func applyClicked(_ sender: UIButton) {
        if fromTF.isEmpty && toTF.isEmpty {
            dismiss(animated: true)
            return
        }
        if !fromTF.isEmpty {
            fromPrice = fromTF.text?.intValue
        }
        if !toTF.isEmpty {
            toPrice = toTF.text?.intValue
        }
        delegate?.didSelectPrice(priceFrom: fromPrice, priceTo: toPrice)
        dismiss(animated: true)
    }
}
