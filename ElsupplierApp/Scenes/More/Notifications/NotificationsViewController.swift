//
//  NotificationsViewController.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 15/04/2022.
//

import UIKit

class NotificationsViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let viewModel = NotificationsViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        title = "_notifications".localized
        tableView.registerCell(ofType: NotificationTableViewCell.self)
    }
    
    override func bindViewsToViewModel() {
        
    }
    
    override func bindViewModelToViews() {

    }
    
    override func setupCallbacks() {
        
    }
    
    // MARK: - Actions

}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NotificationTableViewCell = tableView.dequeueReusableCell()!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
