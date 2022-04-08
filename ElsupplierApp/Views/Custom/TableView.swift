//
//  TableView.swift
//
//  Created by Ahmed Madeh on 10/22/19.
//

import UIKit

class TableView: UITableView {
    override func reloadData() {
        super.reloadData()
        guard let dataSource = dataSource as? TableViewDataSource else {
            return
        }
        if dataSource.shouldShowPlaceholder(in: self) {
            backgroundView = dataSource.viewForPlaceholder(in: self)
        } else {
            backgroundView = nil
        }
    }
}
@objc protocol TableViewDataSource: UITableViewDataSource {
    func viewForPlaceholder(in tableView: UITableView) -> UIView
    func shouldShowPlaceholder(in tableView: UITableView) -> Bool
    func frameForPlaceholder(in tableView: UITableView) -> CGRect
}
