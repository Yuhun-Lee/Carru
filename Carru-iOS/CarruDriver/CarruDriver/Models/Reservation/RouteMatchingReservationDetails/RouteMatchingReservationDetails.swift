//
//  LogisticsMatchingReservationDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct RouteMatchingReservationDetails {
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
    
    struct StopOver {
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
    
    init(
        listId: Int,
        status: String,
        departureLocation: String,
        departureLatitude: Double,
        departureLongitude: Double,
        destinationLocation: String,
        destinationLatitude: Double,
        destinationLongitude: Double,
        totalWeight: Int,
        totalPrice: Int,
        totalOperationDistance: Int,
        totalOperationTime: Int,
        startTime: Date,
        stopOverCount: Int,
        stopOverList: [StopOver]
    ) {
        self.listId = listId
        self.status = status
        self.departureLocation = departureLocation
        self.departureLatitude = departureLatitude
        self.departureLongitude = departureLongitude
        self.destinationLocation = destinationLocation
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.totalWeight = totalWeight
        self.totalPrice = totalPrice
        self.totalOperationDistance = totalOperationDistance
        self.totalOperationTime = totalOperationTime
        self.startTime = startTime
        self.stopOverCount = stopOverCount
        self.stopOverList = stopOverList
    }

    init() {
        self.listId = 0
        self.status = ""
        self.departureLocation = ""
        self.departureLatitude = 0.0
        self.departureLongitude = 0.0
        self.destinationLocation = ""
        self.destinationLatitude = 0.0
        self.destinationLongitude = 0.0
        self.totalWeight = 0
        self.totalPrice = 0
        self.totalOperationDistance = 0
        self.totalOperationTime = 0
        self.startTime = Date()
        self.stopOverCount = 0
        self.stopOverList = []
    }
    
    /// 수정된 `toLogisticMapData`
    func toLogisticMapData() -> [LogisticMapData] {
        var logisticMapDataList: [LogisticMapData] = []
        
        // 첫 번째 StopOver의 출발지 추가
        if let firstStopOver = stopOverList.first {
            logisticMapDataList.append(
                LogisticMapData(
                    departureLocation: firstStopOver.stopOverLocation,
                    departureLatitude: firstStopOver.stopOverLocationLatitude,
                    departureLongitude: firstStopOver.stopOverLocationLongitude,
                    destinationLocation: "",
                    destinationLatitude: 0.0,
                    destinationLongitude: 0.0
                )
            )
        }
        
        // 나머지 StopOver의 출발지 추가 (첫 번째 제외)
        for stopOver in stopOverList.dropFirst() {
            logisticMapDataList.append(
                LogisticMapData(
                    departureLocation: stopOver.stopOverLocation,
                    departureLatitude: stopOver.stopOverLocationLatitude,
                    departureLongitude: stopOver.stopOverLocationLongitude,
                    destinationLocation: "",
                    destinationLatitude: 0.0,
                    destinationLongitude: 0.0
                )
            )
        }
        
        // 첫 번째 StopOver의 도착지 추가
        if let firstStopOver = stopOverList.first {
            logisticMapDataList.append(
                LogisticMapData(
                    departureLocation: "",
                    departureLatitude: 0.0,
                    departureLongitude: 0.0,
                    destinationLocation: firstStopOver.stopOverDestination,
                    destinationLatitude: firstStopOver.stopOverDestinationLatitude,
                    destinationLongitude: firstStopOver.stopOverDestinationLongitude
                )
            )
        }
        
        return logisticMapDataList
    }
    
    /// StopOver 배열을 변환하는 함수
    func toStopOverDetails() -> [StopOverDetails] {
        return stopOverList.map { stopOver in
            StopOverDetails(
                id: stopOver.stopOverId,
                location: stopOver.stopOverLocation,
                latitude: stopOver.stopOverLocationLatitude,
                longitude: stopOver.stopOverLocationLongitude,
                destination: stopOver.stopOverDestination,
                destinationLatitude: stopOver.stopOverDestinationLatitude,
                destinationLongitude: stopOver.stopOverDestinationLongitude,
                productName: stopOver.productName,
                weight: stopOver.weight,
                price: stopOver.price
            )
        }
    }
    
    static func mockUp() -> RouteMatchingReservationDetails {
        return .init(
            listId: 0,
            status: "",
            departureLocation: "",
            departureLatitude: 0,
            departureLongitude: 0,
            destinationLocation: "",
            destinationLatitude: 0,
            destinationLongitude: 0,
            totalWeight: 0,
            totalPrice: 0,
            totalOperationDistance: 0,
            totalOperationTime: 0,
            startTime: .now,
            stopOverCount: 0,
            stopOverList: []
        )
    }
}

/// 새 모델 StopOverDetails
struct StopOverDetails: Hashable {
    let id: Int
    let location: String
    let latitude: Double
    let longitude: Double
    let destination: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let productName: String
    let weight: Int
    let price: Int
    
    var title: String {
        return "출발: \(location)\n도착: \(destination)"
    }
    
    var description: String {
        return "운송무게: \(weight)톤, 가격: \(price)만원"
    }
}
