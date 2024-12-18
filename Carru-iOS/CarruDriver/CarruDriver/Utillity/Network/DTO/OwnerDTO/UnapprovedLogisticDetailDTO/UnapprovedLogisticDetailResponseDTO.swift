//
//  UnapprovedLogisticDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct UnapprovedLogisticDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: LogisticDetailDTO

    struct LogisticDetailDTO: Decodable {
        let productName: String
        let warehouseId: Int
        let warehouseName: String
        let warehouseLat: Double
        let warehouseLng: Double
        let destination: String
        let destinationLat: Double
        let destinationLng: Double
        let weight: Int
        let price: Int
        let operationDistance: Double
        let operationTime: Double
        let deadline: String
    }
}

extension UnapprovedLogisticDetailResponseDTO {
    func toUnapprovedLogisticDetail() -> UnapprovedLogisticDetail {
        return UnapprovedLogisticDetail(
            productName: data.productName,
            warehouseId: data.warehouseId,
            warehouseName: data.warehouseName,
            warehouseLat: data.warehouseLat,
            warehouseLng: data.warehouseLng,
            destination: data.destination,
            destinationLat: data.destinationLat,
            destinationLng: data.destinationLng,
            weight: data.weight,
            price: data.price,
            operationDistance: data.operationDistance,
            operationTime: data.operationTime,
            deadline: data.deadline.toDateFromISO8601() ?? Date()
        )
    }
}
