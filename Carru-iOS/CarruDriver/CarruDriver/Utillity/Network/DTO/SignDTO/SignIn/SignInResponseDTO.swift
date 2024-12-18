//
//  SignInResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct SignInResponseDTO: Codable {
    let resultCode: String
    let message: String
    let data: TokenData
}

struct TokenData: Codable {
    let token: String
}
