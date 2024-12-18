//
//  RouteMatchingReservationListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/20/24.
//

import Foundation

import Foundation

struct RouteMatchingReservationListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: RouteMatchingReservationData
    
    struct RouteMatchingReservationData: Decodable {
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
            let startTime: String
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
        }
    }
    
    // 변환 함수: Response -> RouteReservation 배열
    func toRouteReservations() -> [RouteReservation] {
        return data.content.map {
            RouteReservation(
                listId: $0.listId,
                startTime: $0.startTime,
                departureLocation: $0.departureLocation,
                departureLatitude: $0.departureLatitude,
                departureLongitude: $0.departureLongitude,
                destinationLocation: $0.destinationLocation,
                destinationLatitude: $0.destinationLatitude,
                destinationLongitude: $0.destinationLongitude,
                totalWeight: $0.totalWeight,
                totalPrice: $0.totalPrice,
                totalOperationDistance: $0.totalOperationDistance,
                totalOperationTime: $0.totalOperationTime
            )
        }
    }
}
