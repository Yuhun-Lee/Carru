//
//  LogisticsMatchingReservationDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/28/24.
//

import Foundation

struct LogisticsMatchingReservationDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: ReservationDetailDTO

    struct ReservationDetailDTO: Decodable {
        let productId: Int
        let status: String
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

extension LogisticsMatchingReservationDetailResponseDTO {
    func toLogisticsMatchingReservationDetail() -> LogisticsMatchingReservationDetail {
        return LogisticsMatchingReservationDetail(
            productId: data.productId,
            status: data.status,
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
