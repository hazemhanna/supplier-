//
//  UIScrollViewExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
extension UIScrollView {

    func snapshot() -> UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(self.contentSize, false, 0)
        do {
            let savedContentOffset: CGPoint = self.contentOffset
            let savedFrame: CGRect = self.frame
            self.contentOffset = CGPoint.zero
            self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            image = UIGraphicsGetImageFromCurrentImageContext()
            self.contentOffset = savedContentOffset
            self.frame = savedFrame
        }
        UIGraphicsEndImageContext()
        return image
    }

}
extension UIScrollView {
    
    var isRefreshControlEnabled: Bool{
        set {
            if newValue {
                registerRefreshControl()
            } else {
                refreshControl = nil
            }
        } get {
            return refreshControl != nil
        }
    }
    
    private func registerRefreshControl()  {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .red
        refreshControl.addTarget(self, action: #selector(self.didRefresh(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    @objc private func didRefresh(_ sender: UIRefreshControl)  {
        if let delegate = delegate as? UIRefreshControlDelegate{
            delegate.didRefresh(sender)
        }
    }
    
}
@objc protocol UIRefreshControlDelegate: class {
    func didRefresh(_ refreshControl: UIRefreshControl)
}
