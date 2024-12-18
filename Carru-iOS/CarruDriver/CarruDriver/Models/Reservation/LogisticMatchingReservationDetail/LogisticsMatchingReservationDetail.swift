//
//  LogisticsMatchingReservationDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/28/24.
//

import Foundation

struct LogisticsMatchingReservationDetail {
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
    let deadLine: Date

    init(
        productId: Int,
        status: String,
        productName: String,
        departureLocation: String,
        departureLatitude: Double,
        departureLongitude: Double,
        departureName: String,
        destinationLocation: String,
        destinationLatitude: Double,
        destinationLongitude: Double,
        price: Int,
        weight: Int,
        operationDistance: Int,
        operationTime: Int,
        deadLine: Date
    ) {
        self.productId = productId
        self.status = status
        self.productName = productName
        self.departureLocation = departureLocation
        self.departureLatitude = departureLatitude
        self.departureLongitude = departureLongitude
        self.departureName = departureName
        self.destinationLocation = destinationLocation
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.price = price
        self.weight = weight
        self.operationDistance = operationDistance
        self.operationTime = operationTime
        self.deadLine = deadLine
    }

    init() {
        self.productId = 0
        self.status = ""
        self.productName = ""
        self.departureLocation = ""
        self.departureLatitude = 0.0
        self.departureLongitude = 0.0
        self.departureName = ""
        self.destinationLocation = ""
        self.destinationLatitude = 0.0
        self.destinationLongitude = 0.0
        self.price = 0
        self.weight = 0
        self.operationDistance = 0
        self.operationTime = 0
        self.deadLine = Date()
    }

    /// Converts to LogisticMapData
    func toLogisticMapData() -> LogisticMapData {
        return LogisticMapData(
            departureLocation: departureLocation,
            departureLatitude: departureLatitude,
            departureLongitude: departureLongitude,
            destinationLocation: destinationLocation,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude
        )
    }
}

