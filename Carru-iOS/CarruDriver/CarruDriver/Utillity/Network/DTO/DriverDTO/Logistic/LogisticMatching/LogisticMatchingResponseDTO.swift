//
//  LogisticMatchingResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct LogisticMatchingResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: LogisticMatchingData
    
    struct LogisticMatchingData: Decodable {
        let pageable: Pageable
        let size: Int
        let content: [Content]
        let number: Int
        let sort: Sort
        let numberOfElements: Int
        let first: Bool
        let last: Bool
        let empty: Bool
        
        struct Pageable: Decodable {
            let paged: Bool
            let pageNumber: Int
            let pageSize: Int
            let offset: Int
            let sort: Sort
            let unpaged: Bool
        }
        
        struct Sort: Decodable {
            let sorted: Bool
            let empty: Bool
            let unsorted: Bool
        }
        
        struct Content: Decodable {
            let productId: Int
            let departureLocation: String
            let departureLatitude: Double
            let departureLongitude: Double
            let destinationLocation: String
            let destinationLatitude: Double
            let destinationLongitude: Double
            let price: Int
            let weight: Int
            let operationDistance: Int
            let operationTime: Int
            let deadLine: String
        }
    }
    
    // 변환 함수: Response -> Logistic 배열
    func toLogistics() -> [Logistic] {
        return data.content.map {
            Logistic(
                productId: $0.productId,
                departureLocation: $0.departureLocation,
                departureLatitude: $0.departureLatitude,
                departureLongitude: $0.departureLongitude,
                destinationLocation: $0.destinationLocation,
                destinationLatitude: $0.destinationLatitude,
                destinationLongitude: $0.destinationLongitude,
                price: $0.price,
                weight: $0.weight,
                operationDistance: $0.operationDistance,
                operationTime: $0.operationTime,
                deadLine: $0.deadLine
            )
        }
    }
}
