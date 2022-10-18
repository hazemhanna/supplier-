//
//  OrderDetailsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

class OrderDetailsViewController: BaseViewController {

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
    let order: OrderModel
    
    // MARK: - Life Cycle
    init(order: OrderModel) {
        self.order = order
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
        tableViewHeight.constant = CGFloat(order.items.count * 90)
        addressLabel.text = order.address
        paymentType.text = order.paymentType
        mobileNo.text = order.userPhone
        subTotalLabel.text = order.subtotal.string() + " LE".localized
        shippingFeesLabel.text = order.deliveryFees.string() + " LE".localized
        totalLabel.text = order.totalAmount.string() + " LE".localized
    }
    // MARK: - Actions
}

extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderSummaryTableCell = tableView.dequeueReusableCell()!
        cell.product = order.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 90 }
    
}
