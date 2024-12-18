//
//  LogisticMapData.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/20/24.
//

import Foundation

struct LogisticMapData {
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    
    var location: Location {
        Location(latitude: departureLatitude, longitude: departureLongitude)
    }
    
    var destLocation: Location {
        Location(latitude: destinationLatitude, longitude: destinationLongitude)
    }
    
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
