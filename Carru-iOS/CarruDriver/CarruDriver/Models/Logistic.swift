//
//  Logistic.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import CoreLocation

struct Logistic: Hashable {
    let productId: Int?
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let price: Int
    let weight: Int
    let operationDistance: Int
    let operationTime: Int
    let deadLine: String?
    
    // 상세에만 있는것
    let productName: String?
    let departureName: String?
    
    // 타입 필요할 때
    let logisticStatusType: ProgressType?
    
    var title: String {
        return "출발: \(departureLocation)\n도착: \(destinationLocation)"
    }
    
    var description: String {
        return "운송무게 \(weight)톤, 비용 \(price)만원, 운행거리 \(operationDistance)km, 운송기한 \(deadLine?.toDeadlineFormat() ?? "-")"
    }
    
    var location: Location {
        Location(latitude: departureLatitude, longitude: departureLongitude)
    }
    
    var destLocation: Location {
        Location(latitude: destinationLatitude, longitude: destinationLongitude)
    }
    
    var logisticStatus: ProgressType {
        return logisticStatusType ?? .finished
    }
    
    init(
        productId: Int,
        departureLocation: String,
        departureLatitude: Double,
        departureLongitude: Double,
        destinationLocation: String,
        destinationLatitude: Double,
        destinationLongitude: Double,
        price: Int,
        weight: Int,
        operationDistance: Int,
        operationTime: Int,
        deadLine: String,
        productName: String? = nil,
        departureName: String? = nil,
        logisticStatusType: ProgressType? = nil
    ) {
        self.productId = productId
        self.departureLocation = departureLocation
        self.departureLatitude = departureLatitude
        self.departureLongitude = departureLongitude
        self.destinationLocation = destinationLocation
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.price = price
        self.weight = weight
        self.operationDistance = operationDistance
        self.operationTime = operationTime
        self.deadLine = deadLine
        self.productName = productName
        self.departureName = departureName
        self.logisticStatusType = logisticStatusType
    }
    
    func toLogisticMapData() -> LogisticMapData {
        return .init(
            departureLocation: departureLocation,
            departureLatitude: departureLatitude,
            departureLongitude: departureLongitude,
            destinationLocation: destinationLocation,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude
        )
    }
}
