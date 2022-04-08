//
//
//  Created by Ahmed Madeh.
//

import UIKit

extension UIApplication {
    static func set(style: UIUserInterfaceStyle){
        if #available(iOS 13.0, *) {
            (UIApplication.shared.delegate as! AppDelegate).window?.overrideUserInterfaceStyle = style
        } else {
            // Fallback on earlier versions
        }
    }
    static func initWindow(){
        (UIApplication.shared.delegate as! AppDelegate).initWindow()
    }
    static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    static func call(mobile: String) {
        guard let url = URL(string: "tel://\(mobile)") else {
            print("Invalid mobile number \(mobile)")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

