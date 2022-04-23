//
//  Enums.swift
//
//  Created by Ahmed Madeh.
//

enum ServerType: String {
    case staging = "http://64.227.117.9/backend/public/api"
    case live = ""
}

enum UserType: Int {
    case normal = 1
    case user = 2
    case agent = 3
}
