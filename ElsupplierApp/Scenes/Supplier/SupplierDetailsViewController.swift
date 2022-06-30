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
    @IBOutlet weak var favButton: UIButton!
    
    // MARK: - Variables
    var viewController: UIViewController? = nil
    let supplier: SupplierDetailsModel
    let profileViewModel = ProfileViewModel()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        supplierImageView.setImageWith(stringUrl: supplier.supplier.logo)
        supplierName.text = supplier.supplier.name
//        rateView.rating = supplier.supplier.
        addToContrainer(SupplierProductsViewController(supplier: supplier))
        favButton.isSelected = supplier.isFav
    
    }
    
    override func bindViewModelToViews() {

        profileViewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    
    override func setupCallbacks() {
        
        profileViewModel.favoriteToggledSucceeded.bind { [weak self] _ in
            guard let self = self else { return }
            self.supplier.isFav = self.supplier.isFav == true ? false : true
            self.favButton.isSelected = self.supplier.isFav == true
        }.disposed(by: disposeBag)
        
    }
    
    func addToContrainer(_ controller: UIViewController) {
        viewController?.removeFromParent()
        viewController = controller
        guard let _viewController = viewController else { return }
        addChild(_viewController)
        containerView.addSubIntrinsicView(_viewController.view, replace: true)
    }

    override func shouldShowNavigation() -> Bool { false }
    
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
    
    @IBAction func backClicked(_ sender: UIButton) {
        pop()
    }
    
    @IBAction func favoriteClicked(_ sender: UIButton) {
        profileViewModel.favToggle(supplierId: supplier.supplier.id)
    }
}
