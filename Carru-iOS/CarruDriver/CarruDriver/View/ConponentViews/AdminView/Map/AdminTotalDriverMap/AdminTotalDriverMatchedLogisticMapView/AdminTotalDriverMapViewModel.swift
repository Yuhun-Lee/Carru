//
//  AdminTotalDriverMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/29/24.
//

import Foundation
import Combine

@Observable
class AdminTotalDriverMapViewModel {
    var logisticId: Int
    var logisticMapData: [LogisticMapData]? // 카카오맵 구성을 배열로 해놨기에 형태 따라가는 용
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    var logistic: DriverLogisticMatchingDetail = .init(
        productId: 0,
        productName: "",
        departureLocation: "",
        departureLatitude: 0,
        departureLongitude: 0,
        departureName: "",
        destinationLocation: "",
        destinationLatitude: 0,
        destinationLongitude: 0,
        price: 0,
        weight: 0,
        operationDistance: 0,
        operationTime: 0,
        deadLine: .now
    )
    
    
    private let adminRepo = AdminRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        logisticId: Int
    ) {
        self.logisticId = logisticId
        
        loadLogistic()
    }
    
    private func loadLogistic() {
        adminRepo
            .driverLogisticMatchingDetail(logisticId: logisticId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "화물기사 매칭 물류 상세 조회", complition: $0)
            }, receiveValue: {
                self.logistic = $0
                self.showMap()
            })
            .store(in: &cancellables)
    }
    
    private func showMap() {
        self.logisticMapData = [logistic.toLogisticMapData()]
        showPoiType = .showMatchedLogistic
    }
}


