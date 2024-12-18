//
//  ApprovedLogisticsDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct ApprovedLogisticsDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: LogisticsDetailDTO

    struct LogisticsDetailDTO: Decodable {
        let productId: Int
        let productName: String
        let departureLocation: String
        let departureLatitude: Double
        let departureLongitude: Double
        let departureName: String
        let destinationLocation: String
        let destinationLatitude: Double
        let destinationLongitude: Double
        let price: Int
        let weight: Int
        let operationDistance: Int
        let operationTime: Int
        let deadLine: String
        let ownerName: String
        let driverName: String
        let driverEmail: String
        let driverPhoneNumber: String
        let driveStatus: String
    }
}

extension ApprovedLogisticsDetailResponseDTO {
    func toApprovedLogisticsDetail() -> ApprovedLogisticsDetail {
        return ApprovedLogisticsDetail(
            productId: data.productId,
            productName: data.productName,
            departureLocation: data.departureLocation,
            departureLatitude: data.departureLatitude,
            departureLongitude: data.departureLongitude,
            departureName: data.departureName,
            destinationLocation: data.destinationLocation,
            destinationLatitude: data.destinationLatitude,
            destinationLongitude: data.destinationLongitude,
            price: data.price,
            weight: data.weight,
            operationDistance: data.operationDistance,
            operationTime: data.operationTime,
            deadLine: ISO8601DateFormatter().date(from: data.deadLine) ?? Date(),
            ownerName: data.ownerName,
            driverName: data.driverName,
            driverEmail: data.driverEmail,
            driverPhoneNumber: data.driverPhoneNumber,
            driveStatus: data.driveStatus
        )
    }
}
