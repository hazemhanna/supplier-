//
//  UITableViewExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(ofType type: T.Type){
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    func dequeueReusableCell<T: UITableViewCell>() -> T? {
        return dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}
extension UITableViewCell {
    static var identifier: String {
         return String(describing: self)
     }
    static var nib: UINib {
        return UINib.init(nibName: identifier, bundle: .main)
    }
}
