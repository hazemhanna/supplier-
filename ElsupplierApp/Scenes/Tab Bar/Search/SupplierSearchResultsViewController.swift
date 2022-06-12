//
//  SupplierSearchResultsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 17/05/2022.
//

import UIKit

class SupplierSearchResultsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var areasLabel: UILabel!
    @IBOutlet weak var deptsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var model = PagedObject<SupplierModel>()
    let viewModel: SearchFilterViewModel
    
    // MARK: - Life Cycle
    init(viewModel: SearchFilterViewModel) {
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
        title = "_search_results".localized
        tableView.registerCell(ofType: SupplierSearchResultTableCell.self)
        viewModel.filterAndSearch(page: model.nextPage)
    }
    
    override func setupCallbacks() {
        viewModel.suppliersSearchModel.bind {[weak self] in
            self?.model = $0
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func areasClicked(_ sender: UIButton) {
        present(FilterSelectionViewController(type: .areas), animated: true)
    }
    
    @IBAction func deptsClicked(_ sender: UIButton) {
        present(FilterSelectionViewController(type: .departments), animated: true)
    }
    
    @IBAction func priceClicked(_ sender: UIButton) {
        present(FilterByPriceViewController(), animated: true)
    }
}

extension SupplierSearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SupplierSearchResultTableCell = tableView.dequeueReusableCell()!
        cell.supplier = model.items[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        #warning("push supplier details")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            viewModel.filterAndSearch(page: model.nextPage)
        }
    }
    
}

extension SupplierSearchResultsViewController: SupplierSearchResultTableCellDelegate {
    func supplierSearchResultTableCell(_ cell: SupplierSearchResultTableCell, didSelect product: ProductModel) {
        push(controller: ProductDetailsViewController(product: product))
    }
}
