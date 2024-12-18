//
//  DriverRouteMatchingDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverRouteMatching: Hashable {
    let listId: Int
    let startTime: Date
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let totalWeight: Int
    let totalPrice: Int
    let totalOperationDistance: Int
    let totalOperationTime: Int
    
    var description: String {
        return "운송무게 \(totalWeight)톤, 비용 \(totalPrice)만원, 운행거리 \(totalOperationDistance)km, 운행시간 \(totalOperationTime == 0 ? "1시간 이내" : "\(totalOperationTime)시간")"
    }
}

