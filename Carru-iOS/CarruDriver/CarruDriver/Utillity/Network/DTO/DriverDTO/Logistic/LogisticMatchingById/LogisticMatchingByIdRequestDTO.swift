//
//  LogisticMatchingByIdRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct LogisticMatchingByIdResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: LogisticMatchingDataById
    
    struct LogisticMatchingDataById: Decodable {
        let productId: Int
        let productName: String
        let departureLocation: String
        let departureLatitude: Double
        let departureLongitude: Double
        let departureName: String
        let destinationLocation: String
        let destinationLatitude: Double
        let destinationLongitude: Double
        let price: Int
        let weight: Int
        let operationDistance: Int
        let operationTime: Int
        let deadLine: String // JSON에서 문자열로 그대로 받음
    }
    
    /// 변환 함수: Response -> Logistic
    func toLogistic() -> Logistic {
        return Logistic(
            productId: data.productId,
            departureLocation: data.departureLocation,
            departureLatitude: data.departureLatitude,
            departureLongitude: data.departureLongitude,
            destinationLocation: data.destinationLocation,
            destinationLatitude: data.destinationLatitude,
            destinationLongitude: data.destinationLongitude,
            price: data.price,
            weight: data.weight,
            operationDistance: data.operationDistance,
            operationTime: data.operationTime,
            deadLine: data.deadLine,
            productName: data.productName,
            departureName: data.departureName
        )
    }
}
