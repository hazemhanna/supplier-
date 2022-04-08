//
//  UIViewControllerExtension.swift
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIViewController {
    
    class func with(identifier: String,storyboardName: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
    func push(identifier: String) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func push(controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pop()  {
        self.navigationController?.popViewController(animated: true)
    }
    
}


