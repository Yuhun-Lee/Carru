//
//  DriverRouteMatchingListDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

import Foundation

struct DriverRouteMatchingListDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: DataDTO

    struct DataDTO: Decodable {
        let pageable: PageableDTO
        let size: Int
        let content: [RouteMatchingDTO]
        let number: Int
        let sort: SortDTO
        let numberOfElements: Int
        let first: Bool
        let last: Bool
        let empty: Bool

        struct PageableDTO: Decodable {
            let paged: Bool
            let pageNumber: Int
            let pageSize: Int
            let offset: Int
            let sort: SortDTO
            let unpaged: Bool
        }

        struct SortDTO: Decodable {
            let sorted: Bool
            let empty: Bool
            let unsorted: Bool
        }

        struct RouteMatchingDTO: Decodable {
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
}

extension DriverRouteMatchingListDetailResponseDTO {
    func toDriverRouteMatchingDetails() -> [DriverRouteMatching] {
        return data.content.map { dto in
            DriverRouteMatching(
                listId: dto.listId,
                startTime: ISO8601DateFormatter().date(from: dto.startTime) ?? Date(),
                departureLocation: dto.departureLocation,
                departureLatitude: dto.departureLatitude,
                departureLongitude: dto.departureLongitude,
                destinationLocation: dto.destinationLocation,
                destinationLatitude: dto.destinationLatitude,
                destinationLongitude: dto.destinationLongitude,
                totalWeight: dto.totalWeight,
                totalPrice: dto.totalPrice,
                totalOperationDistance: dto.totalOperationDistance,
                totalOperationTime: dto.totalOperationTime
            )
        }
    }
}
