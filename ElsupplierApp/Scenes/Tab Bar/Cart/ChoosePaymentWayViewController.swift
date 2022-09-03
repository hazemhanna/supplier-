//
//  ChoosePaymentWayViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 28/05/2022.
//

import UIKit

class ChoosePaymentWayViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let viewModel = CartViewModel()
    let cartModel: CartModel
    let addressModel: AddressModel
    var payments = [PaymentTypeModel]()
    
    // MARK: - Life Cycle
    init(cartModel: CartModel, addressModel: AddressModel) {
        self.cartModel = cartModel
        self.addressModel = addressModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_choose_payment_type".localized
        tableView.registerCell(ofType: PaymentTypeTableCell.self)
        viewModel.loadPaymentTypes()
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.paymentTypes.bind { [weak self] types in
            self?.payments = types
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.paymentTypeSelected.bind { [weak self] index in
            self?.payments.forEach({ $0.isSelected = false })
            self?.payments[index].isSelected = true
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func continueClicked(_ sender: UIButton) {
        if let selectedPayment = payments.first(where: { $0.isSelected }) {
            push(controller: OrderSummaryViewController(cartModel: cartModel,
                                                        paymentType: selectedPayment,
                                                        address: addressModel,
                                                        viewModel: viewModel))
        }
    }
    
}

extension ChoosePaymentWayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymentTypeTableCell = tableView.dequeueReusableCell()!
        cell.paymentType = payments[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectPaymentType(typeId: payments[indexPath.row].id,
                                    index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 70 }
    
}
