//
//  RoutePredict.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/2/24.
//

import Foundation

struct RoutePredict: Codable, Hashable {
    var title: String {
        return "출발:\(mainProductInfo.departure)\n도착:\(mainProductInfo.destination)"
    }
    
    var description: String {
        return "총운송무게 \(totalWeight)톤, 총비용 \(totalPrice)만원"
    }
    
    var totalWeight: Int {
        return  mainProductInfo.weight + (stopoverProductInfo?.weight ?? 0) + (secondStopoverProductInfo?.weight ?? 0)
    }
    
    var totalPrice: Int {
        return mainProductInfo.price + (stopoverProductInfo?.price ?? 0) + (secondStopoverProductInfo?.price ?? 0)
    }
    
    var totalDistance: Double {
        return mainProductInfo.distance + (stopoverProductInfo?.distance ?? 0) + (secondStopoverProductInfo?.distance ?? 0)
    }
    
    let userProductInfo: UserProductInfo
    let mainProductInfo: ProductInfo
    let stopoverProductInfo: ProductInfo?
    let secondStopoverProductInfo: ProductInfo?
    
    enum CodingKeys: String, CodingKey {
        case userProductInfo
        case mainProductInfo
        case stopoverProductInfo
        case secondStopoverProductInfo
    }
    
    struct UserProductInfo: Codable, Hashable {
        let maxWeight: Int
        let minWeight: Int
        let departureLat: Double
        let departureLong: Double
        let destinationLat: Double
        let destinationLong: Double
        let preference: Int
        let departureTime: String
        
        enum CodingKeys: String, CodingKey {
            case maxWeight
            case minWeight
            case departureLat
            case departureLong
            case destinationLat
            case destinationLong
            case preference
            case departureTime
        }
    }
    
    struct ProductInfo: Codable, Hashable {
        let userId: Int
        let productId: Int
        let departure: String
        let departureLat: Double
        let departureLong: Double
        let name: String
        let destination: String
        let destinationLat: Double
        let destinationLong: Double
        let weight: Int
        let deadline: String
        let date: String
        let distance: Double
        let price: Int
        let departureName: String
        let destinationName: String
        
        enum CodingKeys: String, CodingKey {
            case userId
            case productId
            case departure
            case departureLat
            case departureLong
            case name
            case destination
            case destinationLat
            case destinationLong
            case weight
            case deadline
            case date
            case distance
            case price
            case departureName
            case destinationName
        }
    }
}

extension RoutePredict {
    func toLogisticMapData() -> [LogisticMapData] {
        var logisticMapDataList: [LogisticMapData] = []
        
        // Main product info's departure
        logisticMapDataList.append(
            LogisticMapData(
                departureLocation: mainProductInfo.departure,
                departureLatitude: mainProductInfo.departureLat,
                departureLongitude: mainProductInfo.departureLong,
                destinationLocation: "",
                destinationLatitude: 0.0,
                destinationLongitude: 0.0
            )
        )
        
        // Stopover product info's departure (if exists)
        if let stopover = stopoverProductInfo {
            logisticMapDataList.append(
                LogisticMapData(
                    departureLocation: stopover.departure,
                    departureLatitude: stopover.departureLat,
                    departureLongitude: stopover.departureLong,
                    destinationLocation: "",
                    destinationLatitude: 0.0,
                    destinationLongitude: 0.0
                )
            )
        }
        
        // Second stopover product info's departure (if exists)
        if let secondStopover = secondStopoverProductInfo {
            logisticMapDataList.append(
                LogisticMapData(
                    departureLocation: secondStopover.departure,
                    departureLatitude: secondStopover.departureLat,
                    departureLongitude: secondStopover.departureLong,
                    destinationLocation: "",
                    destinationLatitude: 0.0,
                    destinationLongitude: 0.0
                )
            )
        }
        
        // Main product info's destination
        logisticMapDataList.append(
            LogisticMapData(
                departureLocation: "",
                departureLatitude: 0.0,
                departureLongitude: 0.0,
                destinationLocation: mainProductInfo.destination,
                destinationLatitude: mainProductInfo.destinationLat,
                destinationLongitude: mainProductInfo.destinationLong
            )
        )
        
        return logisticMapDataList
    }
}

extension RoutePredict {
    func toRouteItemList() -> [RouteItem] {
        var routeItems: [RouteItem] = []
        
        // Main product info
        routeItems.append(
            RouteItem(
                locationName: mainProductInfo.departureName,
                productName: mainProductInfo.name,
                price: mainProductInfo.price,
                weight: mainProductInfo.weight,
                destinationName: mainProductInfo.destinationName // 도착지 추가
            )
        )
        
        // Stopover product info (if exists)
        if let stopover = stopoverProductInfo {
            routeItems.append(
                RouteItem(
                    locationName: stopover.departureName,
                    productName: stopover.name,
                    price: stopover.price,
                    weight: stopover.weight,
                    destinationName: stopover.destinationName // 도착지 추가
                )
            )
        }
        
        // Second stopover product info (if exists)
        if let secondStopover = secondStopoverProductInfo {
            routeItems.append(
                RouteItem(
                    locationName: secondStopover.departureName,
                    productName: secondStopover.name,
                    price: secondStopover.price,
                    weight: secondStopover.weight,
                    destinationName: secondStopover.destinationName // 도착지 추가
                )
            )
        }
        
        return routeItems
    }
    
    func stopOverIds() -> [Int] {
        var ids: [Int] = []
        
        ids.append(mainProductInfo.productId)
        
        if let stopoverProductInfo = stopoverProductInfo {
            ids.append(stopoverProductInfo.productId)
        }
        
        if let secondStopoverProductInfo = secondStopoverProductInfo {
            ids.append(secondStopoverProductInfo.productId)
        }
        
        return ids
    }
}
