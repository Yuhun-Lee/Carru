//
//  UnapprovedLogisticDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct UnapprovedLogisticDetail {
    let productName: String
    let warehouseId: Int
    let warehouseName: String
    let warehouseLat: Double
    let warehouseLng: Double
    let destination: String
    let destinationLat: Double
    let destinationLng: Double
    let weight: Int
    let price: Int
    let operationDistance: Double
    let operationTime: Double
    let deadline: Date
    
    var desctiption: String {
        return "운송무게:\(weight)톤, 비용 \(price)만원, 운행거리: \(Int(operationDistance))km, 운행시간: \(Int(operationTime) == 0 ? "1시간 이내" : "\(Int(operationTime))시간"), 운송기한: \(deadline.toString())"
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
