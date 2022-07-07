//
//  NetworkManager.swift
//
//  Created by Ahmed Madeh.
//

import ESNetworkManager
import Alamofire

final class NetworkManager: ESNetworkManager {
    
//    static let session: Session = {
//         let manager = ServerTrustManager(evaluators: ["www.fortisfin.tech": DisabledTrustEvaluator()])
//         let configuration = URLSessionConfiguration.af.default
//          return Session(configuration: configuration, serverTrustManager: manager)
//         }()
//
//     override class var Manager: Session { return session}
    
    override class func map(_ response: AFDataResponse<Any>) -> ESNetworkResponse<JSON> {
        if response.response?.statusCode == 401 {
            UserModel.current = nil
            UIApplication.initWindow()
            return .failure(NSError.init(error: "_session_expired", code: 401))
        }
        
        if let error = response.error {
            return .failure(error)
        }
        
        print(response.value ?? "No response")
        let json = JSON(response.value)
        let status: Int = json.code.value() ?? 1
        let validations: [String] = json.validation.value() ?? []
        
        if let _ = response.value as? [[String: Any]] {
            return .success(json)
        }
        
        switch status {
        case 200, 105:
            return .success(json)
        case 401:
            return .failure(NSError.init(error: "_session_expired", code: 401))
            
        case let code where !validations.isEmpty:
            return .failure(NSError.init(error: validations.joined(separator: "\n"), code: code))
            
        case let code:
            return .failure(NSError.init(error: "Error \(code)", code: code))
        }
    }
}

extension ESNetworkRequest {
    convenience init(_ path: String) {
        self.init(base: Constants.baseUrl, path: path)
//        "x-localization": Language.currentLanguage.rawValue, 
        self.headers = ["Accept": "application/json"]
        if let user = UserModel.current {
            self.headers?["Authorization"] = "Bearer " + user.token
        }
    }
}
