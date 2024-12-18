//
//  RouteMatchingRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/2/24.
//

import Foundation

struct RouteMatchingRequestDTO: Codable {
    let maxWeight: String
    let minWeight: String
    let departure: String
    let departureLat: String
    let departureLong: String
    let destination: String
    let destinationLat: String
    let destinationLong: String
    let preference: String
    let departureTime: String
    
    enum CodingKeys: String, CodingKey {
        case maxWeight = "max_weight"
        case minWeight = "min_weight"
        case departure
        case departureLat = "departure_lat"
        case departureLong = "departure_long"
        case destination
        case destinationLat = "destination_lat"
        case destinationLong = "destination_long"
        case preference
        case departureTime = "departure_time"
    }
}
