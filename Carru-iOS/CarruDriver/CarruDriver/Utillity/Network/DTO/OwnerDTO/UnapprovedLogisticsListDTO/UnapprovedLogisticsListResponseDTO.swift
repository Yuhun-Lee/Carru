//
//  UnapprovedLogisticsListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct UnapprovedLogisticsListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: [UnapprovedLogisticsDTO]

    struct UnapprovedLogisticsDTO: Decodable {
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

extension UnapprovedLogisticsListResponseDTO {
    func toUnapprovedLogisticsList() -> [UnapprovedLogistics] {
        return data.map { dto in
            UnapprovedLogistics(
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
