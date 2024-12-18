//
//  AppType.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/23/24.
//

import Foundation

enum AppType {
    case driver
    case owner
    case admin
    
    var userStatus: UserStatus {
        switch self {
        case .driver: return .driver
        case .owner: return .owner
        case .admin: return .admin
        }
    }
}

