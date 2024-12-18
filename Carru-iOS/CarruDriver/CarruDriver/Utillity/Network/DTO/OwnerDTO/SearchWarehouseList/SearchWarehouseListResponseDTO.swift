//
//  SearchWarehouseListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct SearchWarehouseListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: [WarehouseDTO]

    struct WarehouseDTO: Decodable {
        let warehouseId: Int
        let name: String
        let location: String
        let locationLat: Double
        let locationLng: Double
    }
}

extension SearchWarehouseListResponseDTO {
    func toWarehouseList() -> [Warehouse] {
        return data.map { dto in
            Warehouse(
                warehouseId: dto.warehouseId,
                name: dto.name,
                location: dto.location,
                locationLatitude: dto.locationLat,
                locationLongitude: dto.locationLng
            )
        }
    }
}
