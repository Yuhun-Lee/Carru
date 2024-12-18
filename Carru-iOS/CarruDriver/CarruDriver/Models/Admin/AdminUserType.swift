//
//  AdminUserType.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/28/24.
//

import Foundation

enum AdminUserType: String, CaseIterable, Identifiable {
    case owner = "화주"
    case driver = "기사"
    
    var id: String { self.rawValue }
    
    var type: AdminAPI.listType {
        switch self {
        case .owner: return .owner
        case .driver: return .driver
        }
    }
}
