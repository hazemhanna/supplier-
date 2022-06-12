//
//  FilterSelectionViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 21/05/2022.
//

import UIKit
import RxSwift

class FilterSelectionViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var filterByLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let type: FilterType
    var items = [PickerModel]()
//    let viewModel = FilterSelectionViewModel()
//    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    init(type: FilterType) {
        self.type = type
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
        filterByLabel.text = type == .areas ? "_filter_by_areas".localized : "_filter_by_department".localized
        tableView.registerCell(ofType: FilterSelectionTableCell.self)
//        if type == .areas {
//            viewModel.listAreas()
//        }
    }
    
    func setupCallbacks() {
//        viewModel.filterItems.bind {[weak self] in
//            self?.items = $0
//            self?.tableView.reloadData()
//        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func closeClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func applyClicked(_ sender: UIButton) {
    }
}

extension FilterSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterSelectionTableCell = tableView.dequeueReusableCell()!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
}
