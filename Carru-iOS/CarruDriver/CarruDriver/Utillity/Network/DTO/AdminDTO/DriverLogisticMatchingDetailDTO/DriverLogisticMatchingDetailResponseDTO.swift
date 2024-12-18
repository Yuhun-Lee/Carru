//
//  DriverLogisticMatchingDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverLogisticMatchingDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: LogisticMatchingDetailDTO

    struct LogisticMatchingDetailDTO: Decodable {
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
    }
}

extension DriverLogisticMatchingDetailResponseDTO {
    func toDriverLogisticMatchingDetail() -> DriverLogisticMatchingDetail {
        return DriverLogisticMatchingDetail(
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
            deadLine: ISO8601DateFormatter().date(from: data.deadLine) ?? Date()
        )
    }
}

