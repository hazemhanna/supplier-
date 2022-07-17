//
//  MyOrdersViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 04/06/2022.
//

import UIKit

class MyOrdersViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectedFilter: UILabel!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    var model = PagedObject<OrderModel>()
    var isFromOrderCreated = false
    
    // MARK: - Life Cycle
    convenience init(isFromOrderCreated: Bool) {
        self.init()
        self.isFromOrderCreated = isFromOrderCreated
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_my_orders".localized
        tableView.registerCell(ofType: OrderTableViewCell.self)
        viewModel.listOrders(page: model.nextPage, status: nil)
        navigationItem.leftBarButtonItem = .init(image: R.image.arrowLeft()?.imageFlippedForRightToLeftLayoutDirection(), style: .plain, target: self, action: #selector(customBack))
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
        viewModel.orders.bind { [weak self] in
            guard let self = self else { return }
            self.model.items.append(contentsOf: $0.items)
            self.model.totalCount = $0.totalCount
            self.model.pageSize = $0.pageSize
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    @objc
    func customBack() {
        if isFromOrderCreated {
            navigationController?.popToRootViewController(animated: true)
        } else {
            pop()
        }
    }
    
    // MARK: - Actions
    @IBAction func filterClicked(_ sender: UIButton) {
        let array = ["_all_orders",
                     "_pending_orders",
                     "_preparing_orders",
                     "_onRoute_orders",
                     "_delivered_orders",
                     "_cancelled_orders"]
        
        ActionSheet.show(title: nil,
                         cancelTitle: "Cancel",
                         otherTitles: array,
                         sender: sender) { [weak self] index in
            guard let self = self, index != 0 else { return }
            switch index {
            case 2 :
                self.viewModel.listOrders(page: self.model.nextPage, status: 1)
            case 3 :
                self.viewModel.listOrders(page: self.model.nextPage, status: 2)
            case 4 :
                self.viewModel.listOrders(page: self.model.nextPage, status: 3)
            case 5 :
                self.viewModel.listOrders(page: self.model.nextPage, status: 4)
            case 6 :
                self.viewModel.listOrders(page: self.model.nextPage, status: 0)
            default:
                self.viewModel.listOrders(page: self.model.nextPage, status: nil)

            }
            self.selectedFilter.text = array[index - 1]
        }
    }
    
}

extension MyOrdersViewController: UITableViewDelegate, TableViewDataSource {
    
    func viewForPlaceholder(in tableView: UITableView) -> UIView { Bundle.main.loadNibNamed("EmptyOrdersView", owner: self, options: [:])?.first as? UIView ?? UIView() }
    
    func shouldShowPlaceholder(in tableView: UITableView) -> Bool { model.items.isEmpty }
    
    func frameForPlaceholder(in tableView: UITableView) -> CGRect { tableView.bounds }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { model.items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderTableViewCell = tableView.dequeueReusableCell()!
        let order = model.items[indexPath.row]
        cell.orderNo.text = "order_no:".localized + order.id.string()
        cell.dateLabel.text = order.datePlaced
        cell.stateLabel.text = order.orderStatus
        cell.supplierName.text = "_supplier:".localized + order.supplierName
        cell.totalLabel.text = "total:".localized + order.totalAmount.string() + " LE".localized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: OrderDetailsViewController(order: model.items[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 120 }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            viewModel.listOrders(page: model.nextPage, status: nil)
        }
    }
    
}
