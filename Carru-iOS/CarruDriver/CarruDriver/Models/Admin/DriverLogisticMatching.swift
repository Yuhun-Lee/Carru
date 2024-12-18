//
//  DriverLogisticMatching.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct DriverLogisticMatching: Hashable {
    let listId: Int
    let destination: String
    let departure: String
    let weight: Int
    let price: Int
    let operationDistance: Int
    let operationTime: Int
    let deadline: Date
    
    var description: String {
        return "운송무게 \(weight)톤, 비용 \(price)만원, 운행거리 \(operationDistance)km, 운행시간 \(operationTime == 0 ? "1시간 이내" : "\(operationTime)시간"), 운송기한 \(deadline.toString())"
    }
}

