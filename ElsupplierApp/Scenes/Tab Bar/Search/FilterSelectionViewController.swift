//
//  FilterSelectionViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 21/05/2022.
//

import UIKit
import RxSwift

protocol FilterSelectionViewControllerDelegate: AnyObject {
    func didSelectArea(area: PickerModel)
    func didSelectDipartment(dept: PickerModel)
}

class FilterSelectionViewController: PresentingViewController {

    // MARK: - Outlets
    @IBOutlet weak var filterByLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let type: FilterType
    var items = [PickerModel]()
    let viewModel = FilterSelectionViewModel()
    let disposeBag = DisposeBag()
    weak var delegate: FilterSelectionViewControllerDelegate?
    
    // MARK: - Life Cycle
    init(type: FilterType, delegate: FilterSelectionViewControllerDelegate) {
        self.type = type
        self.delegate = delegate
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
        setupCallbacks()
        filterByLabel.text = type == .areas ? "_filter_by_areas".localized : "_filter_by_department".localized
        tableView.registerCell(ofType: FilterSelectionTableCell.self)
        if type == .areas {
            viewModel.listAreas()
        } else {
            viewModel.listCategories()
        }
    }
    
    func setupCallbacks() {
        viewModel.isLoading.bind {
            if $0 {
                Hud.show()
            } else {
                Hud.hide()
            }
        }.disposed(by: disposeBag)
        
        viewModel.filterItems.bind {[weak self] in
            self?.items = $0
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
    @IBAction func closeClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func applyClicked(_ sender: UIButton) {
        if let selectedItem = items.first(where: { $0.isSelected }) {
            if type == .areas {
                delegate?.didSelectArea(area: selectedItem)
            } else {
                delegate?.didSelectDipartment(dept: selectedItem)
            }
            dismiss(animated: true)
        }
    }
}

extension FilterSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterSelectionTableCell = tableView.dequeueReusableCell()!
        cell.nameLabel.text = items[indexPath.row].name
        cell.selectionButton.isSelected = items[indexPath.row].isSelected
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items.forEach { item in
            item.isSelected = false
        }
        items[indexPath.row].isSelected = true
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 50 }
    
}
