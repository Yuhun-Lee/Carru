//
//  ApprovedLogisticsListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct OwnerApprovedLogisticsListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: [OwnerApprovedLogisticDTO]

    struct OwnerApprovedLogisticDTO: Decodable {
        let productId: Int
        let location: String
        let destination: String
        let weight: Int
        let cost: Int
        let operationDistance: Int
        let operationTime: Int
        let deadline: String
    }
}

extension OwnerApprovedLogisticsListResponseDTO {
    func toOwnerApprovedLogisticsList() -> [OwnerApprovedLogistic] {
        return data.map { dto in
            OwnerApprovedLogistic(
                productId: dto.productId,
                location: dto.location,
                destination: dto.destination,
                weight: dto.weight,
                cost: dto.cost,
                operationDistance: dto.operationDistance,
                operationTime: dto.operationTime,
                deadline: ISO8601DateFormatter().date(from: dto.deadline) ?? Date()
            )
        }
    }
}
