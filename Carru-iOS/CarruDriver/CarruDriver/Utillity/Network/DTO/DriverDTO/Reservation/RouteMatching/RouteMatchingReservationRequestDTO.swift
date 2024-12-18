//
//  RouteMatchingReservationRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/19/24.
//

import Foundation

struct RouteMatchingReservationRequestDTO: Encodable {
    let maxWeight: Int
    let minWeight: Int
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let estimatedDepartureTime: String // ISO 8601 형식
    let likePrice: Int
    let likeShortOperationDistance: Int
    let stopOverIds: [Int]
}
