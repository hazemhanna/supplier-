//
//  ChooseAddressViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import UIKit

class ChooseAddressViewController: AddressesListViewController {

    // MARK: - Outlets
    
    // MARK: - Variables
    let cartModel: CartModel
    
    // MARK: - Life Cycle
    init(cartModel: CartModel) {
        self.cartModel = cartModel
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
        title = "_choose_address".localized
    }
    
    override func setupCallbacks() {
        super.setupCallbacks()
        viewModel.shippingAddressSelected.bind { [weak self] index in
            self?.addresses.forEach({ $0.isSelected = false })
            self?.addresses[index].isSelected = true
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    override func setSelectedAddress() {
        guard let selectedAddress = addresses.enumerated().first(where: { $0.element.isSelected }) else { return }
        viewModel.selectCartAddress(
            addressId: selectedAddress.element.id,
            index: selectedAddress.offset
        )
    }
    
    // MARK: - Actions
    @IBAction func continueClicked(_ sender: UIButton) {
        if let selectedAddress = addresses.first(where: { $0.isSelected }) {
            push(
                controller: ChoosePaymentWayViewController(
                    cartModel: cartModel,
                    addressModel: selectedAddress
                )
            )
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCartAddress(addressId: addresses[indexPath.row].id, index: indexPath.row)
    }
}
