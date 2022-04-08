//
//  PickerViewController.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
//import PromiseKit


//class PickerViewController<T: PickerObject>: PresentingViewController, UITableViewDelegate, UITableViewDataSource, UIRefreshControlDelegate{
//
//    // MARK: - Outlets
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var multipleLabel: UILabel!
//    
//    // MARK: - Variables
//    let source: Promise<[T]>
//    var comparable: [PickerObject] = []
//    var completion: ((_ t: T) -> ()?)? = nil
//    var multipleCompletion: ((_ t: [T]) -> ()?)? = nil
//    var items: [T] = []
//    var isMultiple = false
//    var shouldShowCanChooseMoreThanOneLabel = false
//    var isFirstTime = true
//    
//    // MARK: - LifeCycle
//    init(_ source: Promise<[T]>, title: String, completion: @escaping (_ t: T) -> ()) {
//        self.source = source
//        self.completion = completion
//        super.init(nibName: "PickerViewController", bundle: .main)
//        self.title = title.localized
//    }
//    
//    init(_ source: Promise<[T]>, comparable: [PickerObject] = [], title: String, isMultiple: Bool = false, shouldShowCanChooseMoreThanOneLabel: Bool = false, completion: @escaping (_ t: [T]) -> ()) {
//        self.source = source
//        self.comparable = comparable
//        self.multipleCompletion = completion
//        self.isMultiple = isMultiple
//        self.shouldShowCanChooseMoreThanOneLabel = shouldShowCanChooseMoreThanOneLabel
//        super.init(nibName: "PickerViewController", bundle: .main)
//        self.title = title.localized
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    // MARK: - Functions
//    override func setupView() {
//        super.setupView()
//        titleLabel.text = title
//        tableView.isRefreshControlEnabled = true
//        tableView.registerCell(ofType: PickerTableViewCell.self)
//        multipleLabel.isHidden = !shouldShowCanChooseMoreThanOneLabel
//        fetchData()
//    }
//
//    fileprivate func fetchData() {
//        source.done { [weak self] (items) in
//            guard let self = self else { return }
//            if !self.comparable.isEmpty {
//                for item in items {
//                    if self.comparable.contains(where: { $0.specialityId == item.id }) {
//                        item.isSelected = true
//                    }
//                }
//            }
//            self.items = items
//            self.tableViewHeightConstraint.constant = 50 * CGFloat(items.count)
//            self.tableView.reloadData()
//        }.catch { error in
//            Alert.show(title: "Error", message: error.localizedDescription)
//        }.finally {}
//    }
//    
//    // MARK: - Actions
//    @IBAction func selectClicked(_ sender: UIButton) {
//        if isMultiple {
//            multipleCompletion!(items.filter({ $0.isSelected }))
//            dismiss(animated: true)
//            return
//        }
//        guard let selectedItem = items.filter({ $0.isSelected }).first else {
//            return
//        }
//        self.completion!(selectedItem)
//        dismiss(animated: true)
//    }
//    
//    
//    // MARK: - UITableViewDataSource
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: PickerTableViewCell = tableView.dequeueReusableCell()!
//        cell.pickingLabel.text = items[indexPath.row].name
//        cell.selectButton.isSelected = items[indexPath.row].isSelected
//        if indexPath.row == items.count - 1 {
//            isFirstTime = false
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if isMultiple {
//            items[indexPath.row].isSelected = !items[indexPath.row].isSelected
//        } else {
//            items.filter({ $0.id != items[indexPath.row].id }).forEach({ $0.isSelected = false })
//            items[indexPath.row].isSelected = !items[indexPath.row].isSelected
//        }
//        tableView.reloadData()
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
//    
//    func didRefresh(_ refreshControl: UIRefreshControl) {
//        refreshControl.endRefreshing()
//        fetchData()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//}
