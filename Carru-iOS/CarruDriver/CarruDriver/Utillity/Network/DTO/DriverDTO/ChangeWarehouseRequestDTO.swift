//
//  ChangeWarehouseRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct ChangeWarehouseRequestDTO: Encodable {
    let location: String
    let locationLat: Double
    let locationLng: Double
    
    init(location: String, locationLat: Double, locationLng: Double) {
        self.location = location
        self.locationLat = locationLat
        self.locationLng = locationLng
    }
}
