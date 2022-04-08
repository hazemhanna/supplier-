//
//  Cache.swift
//
//  Created by Ahmed Madeh.


import Foundation

final class Cache {
    private static func archiveUserInfo(info : Any) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: info)
    }
    
    static func object(key: String) -> Any? {
        if let unarchivedObject:  Data = UserDefaults.standard.object(forKey: key) as? Data{
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject)
        }
        return nil
    }
    
    static func set(object : Any, forKey key: String) {
        let archivedObject = archiveUserInfo(info: object)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func removeObject(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
        
    class var shouldShowSplash: Bool {
        set {
            Cache.set(object: newValue, forKey: "shouldShowSplash")
        } get {
            if let bool = Cache.object(key: "shouldShowSplash") as? Bool {
                return bool
            }
            return true
        }
    }
    
    class var shouldSelectHomeTab: Bool {
        set {
            Cache.set(object: newValue, forKey: "shouldSelectHomeTab")
        } get {
            if let bool = Cache.object(key: "shouldSelectHomeTab") as? Bool {
                return bool
            }
            return false
        }
    }
    
    class var shouldShowNotificationsDot: Bool {
        set {
            Cache.set(object: newValue, forKey: "shouldShowNotificationsDot")
        } get {
            if let bool = Cache.object(key: "shouldShowNotificationsDot") as? Bool {
                return bool
            }
            return false
        }
    }
    
    class var shouldSkipLogin: Bool {
        set {
            Cache.set(object: newValue, forKey: "shouldSkipLogin")
        } get {
            if let bool = Cache.object(key: "shouldSkipLogin") as? Bool {
                return bool
            }
            return false
        }
    }
}
