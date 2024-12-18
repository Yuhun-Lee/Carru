//
//  RouteMatchingResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/2/24.
//

import Foundation

struct RouteMatchingResponseDTO: Codable {
    let status: String
    let message: String
    let results: [ResultDTO]
    
    struct ResultDTO: Codable {
        let userProductInfo: UserProductInfoDTO
        let mainProductInfo: ProductInfoDTO
        let stopoverProductInfo: ProductInfoDTO?
        let secondStopoverProductInfo: ProductInfoDTO?
        
        enum CodingKeys: String, CodingKey {
            case userProductInfo = "user_product_info"
            case mainProductInfo = "main_product_info"
            case stopoverProductInfo = "stopover_product_info"
            case secondStopoverProductInfo = "second_stopover_product_info"
        }
    }
    
    struct UserProductInfoDTO: Codable {
        let maxWeight: String
        let minWeight: String
        let departureLat: String
        let departureLong: String
        let destinationLat: String
        let destinationLong: String
        let preference: String
        let departureTime: String  // JSON에서 문자열로 처리
        
        enum CodingKeys: String, CodingKey {
            case maxWeight = "max_weight"
            case minWeight = "min_weight"
            case departureLat = "departure_lat"
            case departureLong = "departure_long"
            case destinationLat = "destination_lat"
            case destinationLong = "destination_long"
            case preference
            case departureTime = "departure_time"
        }
    }
    
    struct ProductInfoDTO: Codable {
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
        let deadline: String  // JSON에서 문자열로 처리
        let date: String      // JSON에서 문자열로 처리
        let distance: Double
        let price: Int
        let departureName: String
        let destinationName: String
        
        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case productId = "product_id"
            case departure
            case departureLat = "departure_lat"
            case departureLong = "departure_long"
            case name
            case destination
            case destinationLat = "destination_lat"
            case destinationLong = "destination_long"
            case weight
            case deadline
            case date
            case distance
            case price
            case departureName = "departure_name"
            case destinationName = "destination_name"
        }
    }
}

extension RouteMatchingResponseDTO {
    func toRoutePredicts() -> [RoutePredict] {
        return results.map { result in
            RoutePredict(
                userProductInfo: result.userProductInfo.toUserProductInfo(),
                mainProductInfo: result.mainProductInfo.toProductInfo(),
                stopoverProductInfo: result.stopoverProductInfo?.toProductInfo(),
                secondStopoverProductInfo: result.secondStopoverProductInfo?.toProductInfo()
            )
        }
    }
}

extension RouteMatchingResponseDTO.UserProductInfoDTO {
    func toUserProductInfo() -> RoutePredict.UserProductInfo {
        return RoutePredict.UserProductInfo(
            maxWeight: Int(maxWeight) ?? 0,
            minWeight: Int(minWeight) ?? 0,
            departureLat: Double(departureLat) ?? 0.0,
            departureLong: Double(departureLong) ?? 0.0,
            destinationLat: Double(destinationLat) ?? 0.0,
            destinationLong: Double(destinationLong) ?? 0.0,
            preference: Int(preference) ?? 0,
            departureTime: departureTime
        )
    }
}

extension RouteMatchingResponseDTO.ProductInfoDTO {
    func toProductInfo() -> RoutePredict.ProductInfo {
        return RoutePredict.ProductInfo(
            userId: userId,
            productId: productId,
            departure: departure,
            departureLat: departureLat,
            departureLong: departureLong,
            name: name,
            destination: destination,
            destinationLat: destinationLat,
            destinationLong: destinationLong,
            weight: weight,
            deadline: deadline,
            date: date,
            distance: distance,
            price: price,
            departureName: departureName,
            destinationName: destinationName
        )
    }
}
