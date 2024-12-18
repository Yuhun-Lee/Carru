//
//  DriverRouteMatchingDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverRouteMatchingDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: RouteMatchingDetailDTO

    struct RouteMatchingDetailDTO: Decodable {
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
        let startTime: String
        let stopOverCount: Int
        let stopOverList: [StopOverDTO]

        struct StopOverDTO: Decodable {
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
    }
}

extension DriverRouteMatchingDetailResponseDTO {
    func toDriverRouteMatchingDetail() -> DriverRouteMatchingDetail {
        return DriverRouteMatchingDetail(
            listId: data.listId,
            status: data.status,
            departureLocation: data.departureLocation,
            departureLatitude: data.departureLatitude,
            departureLongitude: data.departureLongitude,
            destinationLocation: data.destinationLocation,
            destinationLatitude: data.destinationLatitude,
            destinationLongitude: data.destinationLongitude,
            totalWeight: data.totalWeight,
            totalPrice: data.totalPrice,
            totalOperationDistance: data.totalOperationDistance,
            totalOperationTime: data.totalOperationTime,
            startTime: ISO8601DateFormatter().date(from: data.startTime) ?? Date(),
            stopOverCount: data.stopOverCount,
            stopOverList: data.stopOverList.map { dto in
                DriverRouteMatchingDetail.StopOver(
                    stopOverId: dto.stopOverId,
                    stopOverLocation: dto.stopOverLocation,
                    stopOverLocationLatitude: dto.stopOverLocationLatitude,
                    stopOverLocationLongitude: dto.stopOverLocationLongitude,
                    stopOverDestination: dto.stopOverDestination,
                    stopOverDestinationLatitude: dto.stopOverDestinationLatitude,
                    stopOverDestinationLongitude: dto.stopOverDestinationLongitude,
                    productName: dto.productName,
                    weight: dto.weight,
                    price: dto.price
                )
            }
        )
    }
}
