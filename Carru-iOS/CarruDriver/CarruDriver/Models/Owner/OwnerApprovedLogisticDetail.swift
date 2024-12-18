//
//  OwnerApprovedLogisticDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct OwnerApprovedLogisticDetail {
    let productName: String
    let warehouseName: String
    let warehouseLat: Double
    let warehouseLng: Double
    let destination: String
    let destinationLat: Double
    let destinationLng: Double
    let weight: Int
    let price: Int
    let operationDistance: Int
    let operationTime: Int
    let transporterName: String
    let transporterPhoneNumber: String
    
    var title: String {
        return "출발: \(warehouseName)\n 도착:\(destination)"
    }
    
    func toLogisticMapData() -> LogisticMapData {
        return .init(
            departureLocation: warehouseName,
            departureLatitude: warehouseLat,
            departureLongitude: warehouseLng,
            destinationLocation: destination,
            destinationLatitude: destinationLat,
            destinationLongitude: destinationLng
        )
    }
}
