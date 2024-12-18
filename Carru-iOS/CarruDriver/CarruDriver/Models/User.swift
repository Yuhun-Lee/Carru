//
//  User.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import Foundation

struct User: Hashable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let address: String
    let password: String
    let registerRequestedDate: String?
    
    var registerRequestedDateString: String {
        if let registerRequestedDate {
            return registerRequestedDate
        } else {
            return "가입 요청일 정보 없음"
        }
    }
}

struct UnApprovedUser: Hashable {
    let userId: Int
    let email: String
    let name: String
    let phoneNumber: String
    let createdAt: Date
}

struct ApprovedUser: Hashable {
    let userId: Int
    let name: String
    let email: String
    let phoneNumber: String
    let location: String
    let createdAt: Date
}


struct Profile {
    let email: String
    let name: String
}
