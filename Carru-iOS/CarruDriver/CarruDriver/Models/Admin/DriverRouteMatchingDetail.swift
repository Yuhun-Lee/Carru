//
//  DriverRouteMatchingDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverRouteMatchingDetail {
    let listId: Int
    let status: String
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
    let startTime: Date
    let stopOverCount: Int
    let stopOverList: [StopOver]
    
    struct StopOver: Hashable {
        let stopOverId: Int
        let stopOverLocation: String
        let stopOverLocationLatitude: Double
        let stopOverLocationLongitude: Double
        let stopOverDestination: String
        let stopOverDestinationLatitude: Double
        let stopOverDestinationLongitude: Double
        let productName: String
        let weight: Int
        let price: Int
    }
    
    var title: String {
        return "출발:\(departureLocation)\n도착: \(destinationLocation)"
    }
    
    var description: String {
        return "경유지 \(stopOverCount)개, 운송무게 \(totalWeight)톤, 운행거리 \(totalOperationDistance)km, 운행시간: \( totalOperationTime == 0 ? "1시간 이내" : "\(totalOperationTime)시간")"
    }
    
    func toLogisticMapData() -> [LogisticMapData] {
        return stopOverList.map { stopOver in
            LogisticMapData(
                departureLocation: stopOver.stopOverLocation,
                departureLatitude: stopOver.stopOverLocationLatitude,
                departureLongitude: stopOver.stopOverLocationLongitude,
                destinationLocation: stopOver.stopOverDestination,
                destinationLatitude: stopOver.stopOverDestinationLatitude,
                destinationLongitude: stopOver.stopOverDestinationLongitude
            )
        }
    }
}



