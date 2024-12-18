//
//  UnApprovedUserListResponseDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct UnApprovedUserListResponseDTO: Decodable {
    let resultCode: String
    let message: String
    let data: DataDTO

    struct DataDTO: Decodable {
        let pageable: PageableDTO
        let size: Int
        let content: [UnApprovedUserDTO]
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

        struct UnApprovedUserDTO: Decodable {
            let userId: Int
            let email: String
            let name: String
            let phoneNumber: String
            let createdAt: String
        }
    }
}

extension UnApprovedUserListResponseDTO {
    func toUnApprovedUserList() -> [UnApprovedUser] {
        return data.content.map { dto in
            UnApprovedUser(
                userId: dto.userId,
                email: dto.email,
                name: dto.name,
                phoneNumber: dto.phoneNumber,
                createdAt: dto.createdAt.toISO8601Date() ?? Date()
            )
        }
    }
}
