//
//  OrderSummaryViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

class OrderSummaryViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var paymentType: UILabel!
    @IBOutlet weak var mobileNo: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var shippingFeesLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // MARK: - Variables
    let cartModel: CartModel
    let paymentModel: PaymentTypeModel
    let address: AddressModel
    let viewModel: CartViewModel
    
    // MARK: - Life Cycle
    init(cartModel: CartModel,
         paymentType: PaymentTypeModel,
         address: AddressModel,
         viewModel: CartViewModel) {
        self.cartModel = cartModel
        self.paymentModel = paymentType
        self.address = address
        self.viewModel = viewModel
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
        title = "_order_summary".localized
        tableView.registerCell(ofType: OrderSummaryTableCell.self)
        tableViewHeight.constant = CGFloat(cartModel.items.count * 90)
        addressLabel.text = address.address
        paymentType.text = paymentModel.name
        mobileNo.text = UserModel.current?.phone ?? "-"
        subTotalLabel.text = cartModel.subTotal.string() + " LE".localized
        totalLabel.text = cartModel.total.string() + " LE".localized
        shippingFeesLabel.text = cartModel.delivery.string() + " LE".localized
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
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.orderCreationSucceed.bind { [weak self] _ in
            self?.push(controller: OrderCompletedViewController())
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func sendClicked(_ sender: UIButton) {
        viewModel.completeOrder()
    }
    
}

extension OrderSummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderSummaryTableCell = tableView.dequeueReusableCell()!
        cell.product = cartModel.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 90 }
    
}
