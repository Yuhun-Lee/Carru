//
//  RegisterLogisticsRequestDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation

struct RegisterLogisticsRequestDTO: Codable {
    let warehouseId: Int
    let name: String
    let weight: Int
//    let cost: Int
    let deadline: String // ISO 8601 형식의 날짜 문자열
}
