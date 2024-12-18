//
//  ProfileResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct ProfileResponseDTO: Codable {
    let resultCode: String
    let message: String
    let data: ProfileData
    
    func toProfile() -> Profile {
        return Profile(
            email: data.email,
            name: data.name
        )
    }
}

struct ProfileData: Codable {
    let email: String
    let name: String
}
