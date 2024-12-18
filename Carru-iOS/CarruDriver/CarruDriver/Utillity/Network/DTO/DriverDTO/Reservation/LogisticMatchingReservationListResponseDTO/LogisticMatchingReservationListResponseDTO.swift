//
//  ㅇㅇ.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/20/24.
//

import Foundation

struct LogisticMatchingReservationListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: Data
    
    struct Data: Decodable {
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
            let listId: Int
            let departureLocation: String
            let departureLatitude: Double
            let departureLongitude: Double
            let destinationLocation: String
            let destinationLatitude: Double
            let destinationLongitude: Double
            let weight: Int
            let price: Int
            let operationDistance: Int
            let operationTime: Int
        }
    }
    
    func toLogisticReservations() -> [LogisticReservation] {
        return data.content.map {
            LogisticReservation(
                listId: $0.listId,
                departureLocation: $0.departureLocation,
                departureLatitude: $0.departureLatitude,
                departureLongitude: $0.departureLongitude,
                destinationLocation: $0.destinationLocation,
                destinationLatitude: $0.destinationLatitude,
                destinationLongitude: $0.destinationLongitude,
                weight: $0.weight,
                price: $0.price,
                operationDistance: $0.operationDistance,
                operationTime: $0.operationTime
            )
        }
    }
}

