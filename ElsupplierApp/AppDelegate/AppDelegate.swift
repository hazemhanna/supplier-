//
//  AppDelegate.swift
//  ElsupplierApp
//
//  Created by Ahmed Madeh on 08/04/2022.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3)
        IQKeyboardManager.shared.enable = true
        registerForRemoteNotification()
        Swizzler.swizzleForUI()
        Swizzler.swizzleForlocalize()
        window = UIWindow()
        initWindow()
        return true
    }
    
    func initWindow() {
        setupAppearance()
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return }
        if UserModel.current != nil {
            Cache.shouldSelectHomeTab = true
            window.rootViewController = NavigationController(rootViewController: BaseTabBarController())
        } else {
            window.rootViewController = NavigationController(rootViewController: LoginViewController())
        }
        window.makeKeyAndVisible()
    }
    
    func setupAppearance() {
        UIView.appearance().semanticContentAttribute = Language.isArabic ? .forceRightToLeft : .forceLeftToRight
        UIBarButtonItem.appearance().setTitleTextAttributes ([.foregroundColor: UIColor.clear], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes ([.foregroundColor: UIColor.clear], for: .normal)
        UINavigationBar.appearance().backIndicatorImage = R.image.arrowLeft()
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = R.image.arrowLeft()
    }
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings (UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

}

//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        messaging.subscribe(toTopic: "General")
////        NotificationsAPI.updateToken().done { _ in }.catch { error in
////            print(error.localizedDescription)
////        }
//    }
//}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
//        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(.newData)
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        Cache.shouldShowNotificationsDot = true
        completionHandler([.alert, .badge, .sound])
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Messaging.messaging().apnsToken = deviceToken
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("deviceTokenString \(deviceTokenString)")
//       if UserModel.current != nil {
//        AuthAPI.UpdateToken(token: deviceTokenString).subscribe {message in
//            print(message)
//        } onError: { error in
//              print(error)
//        }.disposed(by: disposeBag)
//       }
    }
    
}
