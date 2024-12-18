//
//  DriverLogisticMatchingListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverLogisticMatchingListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: DataDTO

    struct DataDTO: Decodable {
        let pageable: PageableDTO
        let size: Int
        let content: [LogisticMatchingDTO]
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

        struct LogisticMatchingDTO: Decodable {
            let listId: Int
            let destination: String
            let departure: String
            let weight: Int
            let price: Int
            let operationDistance: Int
            let operationTime: Int
            let deadline: String
        }
    }
}

extension DriverLogisticMatchingListResponseDTO {
    func toDriverLogisticMatchingList() -> [DriverLogisticMatching] {
        return data.content.map { dto in
            DriverLogisticMatching(
                listId: dto.listId,
                destination: dto.destination,
                departure: dto.departure,
                weight: dto.weight,
                price: dto.price,
                operationDistance: dto.operationDistance,
                operationTime: dto.operationTime,
                deadline: ISO8601DateFormatter().date(from: dto.deadline) ?? Date()
            )
        }
    }
}
