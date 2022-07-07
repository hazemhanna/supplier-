//
//  MessagesViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/06/2022.
//

import UIKit

class MessagesViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Variables
    let viewModel = ProfileViewModel()
    var list: [MessagesModel] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_messages".localized
        tableView.registerCell(ofType: MessageTableViewCell.self)
        viewModel.listMessages()
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
            self?.list = $0
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    // MARK: - Actions
}

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageTableViewCell = tableView.dequeueReusableCell()!
        cell.list = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        push(controller: MessagesDetailsViewController())
    }
    
}
