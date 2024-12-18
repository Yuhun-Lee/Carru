//
//  LogisticReservation.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/20/24.
//

import Foundation

struct LogisticReservation: Hashable {
    let listId: Int
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let weight: Int
    let price: Int
    let operationDistance: Int
    let operationTime: Int
    
    var description: String {
        return "운송무게: \(weight)톤, 비용: \(price)만원, 운행거리: \(operationDistance)km, 운행시간: \(operationTime == 0 ? "1시간 이내" : "\(operationTime)시간")"
    }
    
    func toLogisticMapData() -> LogisticMapData {
        LogisticMapData(
            departureLocation: departureLocation,
            departureLatitude: departureLatitude,
            departureLongitude: departureLongitude,
            destinationLocation: destinationLocation,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude
        )
    }
}
