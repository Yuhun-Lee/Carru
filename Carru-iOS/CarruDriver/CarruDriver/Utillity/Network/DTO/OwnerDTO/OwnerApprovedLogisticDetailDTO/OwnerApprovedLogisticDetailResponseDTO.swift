//
//  OwnerApprovedLogisticDetailResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct OwnerApprovedLogisticDetailResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: LogisticDetailDTO

    struct LogisticDetailDTO: Decodable {
        let productName: String
        let warehouseName: String
        let warehouseLat: Double
        let warehouseLng: Double
        let destination: String
        let destinationLat: Double
        let destinationLng: Double
        let weight: Int
        let price: Int
        let operationDistance: Int
        let operationTime: Int
        let transporterName: String?
        let transporterPhoneNumber: String?
    }
}

extension OwnerApprovedLogisticDetailResponseDTO {
    func toOwnerApprovedLogisticDetail() -> OwnerApprovedLogisticDetail {
        return OwnerApprovedLogisticDetail(
            productName: data.productName,
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
            transporterName: data.transporterName ?? "",
            transporterPhoneNumber: data.transporterPhoneNumber ?? ""
        )
    }
}
