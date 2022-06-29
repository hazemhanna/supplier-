//
//  AddressesListViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 10/05/2022.
//

import UIKit

class AddressesListViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var viewModel = AddressesViewModel()
    var addresses: [AddressModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_my_addresses".localized
        let newAddressButton = UIBarButtonItem(title: "_new_address".localized, style: .plain, target: self, action: #selector(newAddressClicked))
        newAddressButton.tintColor = R.color.lightBlue()
        newAddressButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.cairoBold(size: 13)!], for: .normal)
        navigationItem.rightBarButtonItem = newAddressButton
        tableView.registerCell(ofType: AddressTableViewCell.self)
        tableView.isRefreshControlEnabled = true
        viewModel.listAddresses()
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
        viewModel.addresses.bind {
            self.addresses = $0
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.addressDeleted.bind { _ in
            self.viewModel.listAddresses()
        }.disposed(by: disposeBag)
        
        viewModel.addressSelected.bind { _ in
            self.viewModel.listAddresses()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    // MARK: - Actions
    @objc func newAddressClicked() {
        push(controller: AddAddressViewController())
    }

}

extension AddressesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressTableViewCell = tableView.dequeueReusableCell()!
        cell.address = addresses[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectAddress(addressId: addresses[indexPath.row].id)
    }
    
}

extension AddressesListViewController: AddressTableViewCellDelegate {
    
    func addressTableViewCell(_ cell: AddressTableViewCell, didPressEdit address: AddressModel) {
        push(controller: EditAddressViewController(address: address))
    }
    
    func addressTableViewCell(_ cell: AddressTableViewCell, didPressDelete address: AddressModel) {
        Alert.show(title: nil, message: "_delete_address?",
                   cancelTitle: "Cancel", otherTitles: ["_delete"]) {[weak self] index in
            if index == 1 {
                self?.viewModel.deleteAddress(addressId: address.id)
            }
        }
    }
}

extension AddressesListViewController: UIRefreshControlDelegate {
    func didRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        viewModel.listAddresses()
    }
}
