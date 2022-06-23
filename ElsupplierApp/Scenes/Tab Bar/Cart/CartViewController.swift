//
//  CartViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class CartViewController: BaseTabBarViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var purchaseView: UIView!
    
    // MARK: - Variables
    let viewModel = CartViewModel()
    var cartModel = CartModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCart()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_shopping_cart".localized
        tableView.registerCell(ofType: CartTableCell.self)
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.cartModel.bind { [weak self] in
            self?.cartModel = $0
            self?.totalLabel.text = $0.totals.string() + " LE"
            self?.purchaseView.isHidden = $0.items.isEmpty
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.itemRemoved.bind { [weak self] _ in
            self?.viewModel.loadCart()
        }.disposed(by: disposeBag)
    }
    
    override func tabBarItemTitle() -> String? {
        "Cart".localized
    }
    override func tabBarItemImage() -> UIImage? {
        R.image.cart()
    }
    override func tabBarItemSelectedImage() -> UIImage? {
        R.image.cartActive()
    }
    override func shouldShowTabBar() -> Bool {
        true
    }
    
    // MARK: - Actions
    @IBAction func continueClicked(_ sender: UIButton) {
        if cartModel.items.isEmpty { return }
        push(controller: ChooseAddressViewController(cartModel: cartModel))
    }
    
}

extension CartViewController: UITableViewDelegate, TableViewDataSource, CartTableCellDelegate {
    func viewForPlaceholder(in tableView: UITableView) -> UIView {
        return Bundle.main.loadNibNamed("EmptyCartView", owner: self, options: [:])?.first as? UIView ?? UIView()
    }
    
    func shouldShowPlaceholder(in tableView: UITableView) -> Bool {
        cartModel.items.isEmpty
    }
    
    func frameForPlaceholder(in tableView: UITableView) -> CGRect {
        tableView.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTableCell = tableView.dequeueReusableCell()!
        cell.supplierName.text = "_supplier_name".localized + cartModel.supplierName
        cell.delegate = self
        cell.item = cartModel.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    
    func cartTableCell(_ cell: CartTableCell, didRemove item: CartItem) {
        viewModel.removeFromCart(itemId: item.id)
    }
    
}
