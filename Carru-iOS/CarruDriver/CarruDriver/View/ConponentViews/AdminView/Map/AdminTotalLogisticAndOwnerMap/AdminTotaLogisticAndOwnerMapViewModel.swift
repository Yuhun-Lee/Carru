//
//  AdminTotalListMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Combine

@Observable
class AdminTotalLogisticAndOwnerMapViewModel {
    var logisticId: Int
    var logisticMapData: [LogisticMapData]? // 카카오맵 구성을 배열로 해놨기에 형태 따라가는 용
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .showMyLocation
    var updateEvent: Bool = false
    
    var logistic: ApprovedLogisticsDetail = .init()
    
    
    private let adminRepo = AdminRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        logisticId: Int
    ) {
        self.logisticId = logisticId
    }
    
    func loadLogistic() {
        adminRepo
            .approvedLogisticsDetail(logisticId: logisticId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "승인 물류 디테일 조회", complition: $0)
            }, receiveValue: {
                self.logistic = $0
                self.showMap()
            })
            .store(in: &cancellables)
    }
    
    private func showMap() {
        let logisticMapData = logistic.toLogisticMapData()
        self.logisticMapData = [logisticMapData]
        showPoiType = .showMatchedLogistic
    }
}

