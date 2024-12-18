//
//  UserWarehouseResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct UserWarehouseResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: WarehouseLocationDTO

    struct WarehouseLocationDTO: Decodable {
        let location: String
        let locationLat: Double
        let locationLng: Double
    }
}

extension UserWarehouseResponseDTO {
    func toWarehouseLocation() -> WarehouseLocation {
        return WarehouseLocation(
            location: data.location,
            latitude: data.locationLat,
            longitude: data.locationLng
        )
    }
}

