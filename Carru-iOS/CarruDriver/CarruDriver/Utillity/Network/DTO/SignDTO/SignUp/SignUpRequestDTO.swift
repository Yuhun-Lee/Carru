//
//  SignUpDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//


import Foundation

struct SignUpRequestDTO: Codable {
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let location: String
    let locationLat: Double
    let locationLng: Double
    let warehouseName: String
    
    func toDriverSignUpRequestDTO() -> DriverSignUpRequestDTO {
        return . init(
            name: name,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            location: location,
            locationLat: locationLat,
            locationLng: locationLng
        )
    }
}


struct DriverSignUpRequestDTO: Codable {
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let location: String
    let locationLat: Double
    let locationLng: Double
}
