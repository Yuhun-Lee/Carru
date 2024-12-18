//
//  d.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/1/24.
//

import Foundation
import Combine

@Observable
class AdminTotalDriverRouteLogisticMapViewModel {
    var listID: Int
    var logisticMapData: [LogisticMapData]? // 카카오맵 구성을 배열로 해놨기에 형태 따라가는 용
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    var logistic: DriverRouteMatchingDetail = .init(
        listId: 0,
        status: "",
        departureLocation: "",
        departureLatitude: 0.0,
        departureLongitude: 0.0,
        destinationLocation: "",
        destinationLatitude: 0.0,
        destinationLongitude: 0.0,
        totalWeight: 0,
        totalPrice: 0,
        totalOperationDistance: 0,
        totalOperationTime: 0,
        startTime: .now,
        stopOverCount: 0,
        stopOverList: []
    )
    
    
    
    private let adminRepo = AdminRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        listID: Int
    ) {
        self.listID = listID
        
        loadLogistic()
    }
    
    private func loadLogistic() {
        adminRepo
            .driverRouteMatchingDetail(listId: listID)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "화물기사 경로 상세 조회", complition: $0)
            }, receiveValue: {
                self.logistic = $0
                self.showMap()
            })
            .store(in: &cancellables)
    }
    
    private func showMap() {
        self.logisticMapData = logistic.toLogisticMapData()
        showPoiType = .showLogisticsPoints
    }
}
