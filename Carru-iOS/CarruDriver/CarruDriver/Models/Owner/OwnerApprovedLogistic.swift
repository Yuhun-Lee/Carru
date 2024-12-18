//
//  OwnerApprovedLogistic.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct OwnerApprovedLogistic: Hashable {
    let productId: Int
    let location: String
    let destination: String
    let weight: Int
    let cost: Int
    let operationDistance: Int
    let operationTime: Int
    let deadline: Date
    
    var description: String {
        return "운송무게: \(weight)톤, 비용: \(cost)만원, 운행거리: \(operationDistance)km, 운행시간: \(operationTime == 0 ? "1시간 이내" : "\(operationTime)시간"), 운송 기한: \(deadline.toString())"
    }
}

