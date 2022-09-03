//
//  MessagesDetailsViewController.swift
//  ElsupplierApp
//
//  Created by MAC on 15/06/2022.
//

import UIKit

class MessagesDetailsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    var message = [MessagesModel]()
    
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    let supplierId: Int
    // MARK: - Life Cycle
    init(_ supplierId: Int) {
        self.supplierId = supplierId
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
        title = "_messages".localized
        tableView.registerCell(ofType: MessagesReceverTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        viewModel.listChats(supplierId: supplierId)
    }
    
    override func bindViewModelToViews() {
        viewModel.isLoading.bind {
            Hud.showDismiss($0)
        }.disposed(by: disposeBag)
    }
    
    override func setupCallbacks() {
        viewModel.error.bind {
            Alert.show(message: $0.localizedDescription)
        }.disposed(by: disposeBag)
        
        viewModel.messages.bind { [weak self] in
            self?.message = $0
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Actions
}

extension MessagesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessagesReceverTableViewCell = tableView.dequeueReusableCell()!
        cell.config(
            date: message[indexPath.row].date,
            Message: message[indexPath.row].body,
            ReceiverFlag: message[indexPath.row].supplier.id != UserModel.current?.id
        )
        return cell
    }
}

struct Message {
    var date: String?
    var message: String?
    var receiverFlag: Bool?
}
