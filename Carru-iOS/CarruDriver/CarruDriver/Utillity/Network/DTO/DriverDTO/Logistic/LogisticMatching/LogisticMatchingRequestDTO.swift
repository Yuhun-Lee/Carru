//
//  LogisticMatchingRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct LogisticMatchingRequestDTO: Encodable {
    let maxWeight: Int
    let minWeight: Int
    let sortPrice: Int
    let sortOperationDistance: Int
    let warehouseKeyword: String
}
