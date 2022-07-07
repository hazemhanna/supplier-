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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
//        self.message.append(Message(date: "منذ يومين", message: "هذا الكلام سخيف جدااا", receiverFlag: false))
//        self.message.append(Message(date: "منذ يومين", message: " هذا الكلام سخيف جدااا الكلامالكلامالكلام الكلامالكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلامالكلام الكلام الكلام الكلام الكلام الكلام الكلامالكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلام الكلامالكلام الكلام الكلام الكلام الكلام الكلام الكلام", receiverFlag: true))
//        self.message.append(Message(date: "منذ يومين", message: "هذا الكلام سخيف جدااا", receiverFlag: false))
//        self.message.append(Message(date: "منذ يومين", message: "هذا الكلام سخيف جدااا", receiverFlag: true))
//        self.message.append(Message(date: "منذ دقيقة", message: "اجل", receiverFlag: false))
//        self.message.append(Message(date: "الان", message: "اجل", receiverFlag: true))
//
        title = "_messages".localized
        tableView.registerCell(ofType: MessagesReceverTableViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        viewModel.listChats(supplierId: 1)

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
       // cell.config(date: message[indexPath.row].date ?? "" , Message:  message[indexPath.row].message ?? "", ReceiverFlag:  message[indexPath.row].receiverFlag ?? false)
        
        return cell
    }
}

struct Message {
    var date: String?
    var message: String?
    var receiverFlag: Bool?
}
