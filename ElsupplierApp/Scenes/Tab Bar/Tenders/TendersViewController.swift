//
//  TendersViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 16/04/2022.
//

import UIKit

class TendersViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    var tenders: [TenderModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_my_tenders".localized
        tableView.registerCell(ofType: TenderTableViewCell.self)
        let newTenderButton = UIBarButtonItem(title: "_new_tender".localized, style: .plain, target: self, action: #selector(newTenderClicked))
        newTenderButton.tintColor = R.color.lightBlue()
        newTenderButton.setTitleTextAttributes([NSAttributedString.Key.font: R.font.cairoBold(size: 13)!], for: .normal)
        navigationItem.rightBarButtonItem = newTenderButton
        tableView.registerCell(ofType: AddressTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.listTenders()
    }
    
    @objc
    func newTenderClicked() {
        push(controller: AddTenderViewController())
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
        viewModel.tenders.bind { [weak self] in
            self?.tenders = $0
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    override func shouldShowTabBar() -> Bool {
        true
    }
    
    // MARK: - Actions
}

extension TendersViewController: UITableViewDelegate, TableViewDataSource {
    
    func viewForPlaceholder(in tableView: UITableView) -> UIView {
        return Bundle.main.loadNibNamed("EmptyCartView", owner: self, options: [:])?.first as? UIView ?? UIView()
    }

    func shouldShowPlaceholder(in tableView: UITableView) -> Bool {
        tenders.isEmpty
    }
    
    func frameForPlaceholder(in tableView: UITableView) -> CGRect {
        tableView.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tenders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TenderTableViewCell = tableView.dequeueReusableCell()!
        cell.tender = tenders[indexPath.row]
        return cell
    }
}
