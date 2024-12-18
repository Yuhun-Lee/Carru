//
//  ApprovedLogisticsDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct ApprovedLogisticsDetail {
    let productId: Int
    let productName: String
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let departureName: String
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let price: Int
    let weight: Int
    let operationDistance: Int
    let operationTime: Int
    let deadLine: Date
    let ownerName: String
    let driverName: String
    let driverEmail: String
    let driverPhoneNumber: String
    let driveStatus: String
    
    var title: String {
        return "출발: \(departureLocation)\n도착: \(destinationLocation)"
    }
    
    var description: String {
        return "운송무게: \(weight)톤, 비용 \(price)만원, 운행거리: \(operationDistance)km, 운송기한: \(deadLine.toString())"
    }
    
    var status: String {
        if driveStatus == "APPROVED" {
            return "물류 승인 완료"
        } else if driveStatus == "REJECTED" {
            return "물류 승인 거절"
        } else if driveStatus == "WAITING" {
            return "물류 승인 대기중"
        } else if driveStatus == "DRIVER_TODO" {
            return "물류 승인 완료 후 운송자가 예약한 상태"
        } else if driveStatus == "DRIVER_INPROGRESS" {
            return "물류 운송 진행중"
        } else if driveStatus == "DRIVER_FINISHED" {
            return "물류 운송 완료"
        } else {
            return "알 수 없는 상태"
        }
    }
    
    init(
        productId: Int,
        productName: String,
        departureLocation: String,
        departureLatitude: Double,
        departureLongitude: Double,
        departureName: String,
        destinationLocation: String,
        destinationLatitude: Double,
        destinationLongitude: Double,
        price: Int,
        weight: Int,
        operationDistance: Int,
        operationTime: Int,
        deadLine: Date,
        ownerName: String,
        driverName: String,
        driverEmail: String,
        driverPhoneNumber: String,
        driveStatus: String
    ) {
        self.productId = productId
        self.productName = productName
        self.departureLocation = departureLocation
        self.departureLatitude = departureLatitude
        self.departureLongitude = departureLongitude
        self.departureName = departureName
        self.destinationLocation = destinationLocation
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.price = price
        self.weight = weight
        self.operationDistance = operationDistance
        self.operationTime = operationTime
        self.deadLine = deadLine
        self.ownerName = ownerName
        self.driverName = driverName
        self.driverEmail = driverEmail
        self.driverPhoneNumber = driverPhoneNumber
        self.driveStatus = driveStatus
    }
    
    /// 빈값으로 초기화하는 초기화 메서드
    init() {
        self.productId = 0
        self.productName = ""
        self.departureLocation = ""
        self.departureLatitude = 0.0
        self.departureLongitude = 0.0
        self.departureName = ""
        self.destinationLocation = ""
        self.destinationLatitude = 0.0
        self.destinationLongitude = 0.0
        self.price = 0
        self.weight = 0
        self.operationDistance = 0
        self.operationTime = 0
        self.deadLine = Date()
        self.ownerName = ""
        self.driverName = ""
        self.driverEmail = ""
        self.driverPhoneNumber = ""
        self.driveStatus = ""
    }
    
    func toLogisticMapData() -> LogisticMapData {
        return LogisticMapData(
            departureLocation: departureLocation,
            departureLatitude: departureLatitude,
            departureLongitude: departureLongitude,
            destinationLocation: destinationLocation,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude
        )
    }
}
