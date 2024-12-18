//
//  SignUpError.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation

enum SignUpError: LocalizedError {
    case invalidError(message: String)
    
    var description: String {
        switch self {
        case .invalidError(let message):
            return message
        }
    }
}

enum CommonError: Error, LocalizedError {
    case commonError(message: String)
    
    var description: String {
        switch self {
        case .commonError(let message):
            return message
        }
    }
}
