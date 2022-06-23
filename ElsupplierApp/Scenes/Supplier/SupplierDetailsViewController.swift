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
    var viewController: UIViewController? = nil
    let supplier: SupplierDetailsModel
    
    // MARK: - Life Cycle
    init(supplier: SupplierDetailsModel) {
        self.supplier = supplier
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        addToContrainer(SupplierProductsViewController(supplier: supplier))
    }
    
    func addToContrainer(_ controller: UIViewController) {
        viewController?.removeFromParent()
        viewController = controller
        guard let _viewController = viewController else { return }
        addChild(_viewController)
        containerView.addSubIntrinsicView(_viewController.view, replace: true)
    }
    
    // MARK: - Actions
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            addToContrainer(SupplierProductsViewController(supplier: supplier))
            break
        case 1:
            addToContrainer(SupplierPostsViewController(posts: supplier.posts))
            break
        case 2:
            addToContrainer(SupplierInfoViewController(supplier: supplier))
            break
        default:
            break
        }
    }
    
}
