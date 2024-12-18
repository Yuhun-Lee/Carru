//
//  RouteReservation.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/20/24.
//

import Foundation

struct RouteReservation: Hashable {
    let listId: Int
    let startTime: String
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
    
    var title: String {
        return "출발지: \(departureLocation)\n도착지: \(destinationLocation)"
    }
    
    var description: String {
        return "운송무게: \(totalWeight)톤, 비용: \(totalPrice)만원"
    }
}
