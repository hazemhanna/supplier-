//
//  UINavigationControllerExtensions.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
extension UINavigationController {
    func popViewController(backIndex : Int , animated : Bool = true)  {
        
        let index = self.viewControllers.count - backIndex - 1
        self.popToViewController(self.viewControllers[index], animated: animated)
        
    }
    func popToViewController(identifier : String , animated : Bool = true)  {
        
        for controller in self.viewControllers {
            if identifier == controller.restorationIdentifier {
                self.popToViewController(controller, animated: animated)
                return
            }
        }
    }
    func containsController(identifier : String) -> Bool {
        
        for controller in self.viewControllers {
            if identifier == controller.restorationIdentifier {
                return true
            }
        }
        return false
    }
    func controller(identifier : String) -> UIViewController? {
        
        for controller in self.viewControllers {
            if identifier == controller.restorationIdentifier {
                return controller
            }
        }
        return nil
    }
    func popToViewController(ofType : UIViewController.Type , animated : Bool = true)  {
        
        for controller in self.viewControllers {
            if ofType == type(of: controller) {
                self.popToViewController(controller, animated: animated)
                return
            }
        }
    }
    func containsController(ofType : UIViewController.Type) -> Bool {
        
        for controller in self.viewControllers {
            if ofType == type(of: controller) {
                return true
            }
        }
        return false
    }
    func controller(ofType : UIViewController.Type) -> UIViewController? {
        
        for controller in self.viewControllers {
            if ofType == type(of: controller) {
                return controller
            }
        }
        return nil
    }
}
