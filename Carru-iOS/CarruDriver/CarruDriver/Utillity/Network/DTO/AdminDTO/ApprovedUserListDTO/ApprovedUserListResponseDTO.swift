//
//  ApprovedUserListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct ApprovedUserListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: DataDTO

    struct DataDTO: Decodable {
        let pageable: PageableDTO
        let size: Int
        let content: [ApprovedUserDTO]
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

        struct ApprovedUserDTO: Decodable {
            let userId: Int
            let name: String
            let email: String
            let phoneNumber: String
            let location: String
            let createdAt: String
        }
    }
}

extension ApprovedUserListResponseDTO {
    func toApprovedUserList() -> [ApprovedUser] {
        return data.content.map { dto in
            ApprovedUser(
                userId: dto.userId,
                name: dto.name,
                email: dto.email,
                phoneNumber: dto.phoneNumber,
                location: dto.location,
                createdAt: ISO8601DateFormatter().date(from: dto.createdAt) ?? Date()
            )
        }
    }
}
