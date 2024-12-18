//
//  FixUnapprovedLogisticRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct FixDeleteUnapprovedLogisticRequestDTO: Encodable {
    let warehouseId: Int?
    let name: String
    let weight: Int
//    let cost: Int
    let deadline: String
}

