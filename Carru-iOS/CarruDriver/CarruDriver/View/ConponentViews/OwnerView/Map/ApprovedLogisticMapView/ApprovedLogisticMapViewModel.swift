//
//  ApprovedLogisticMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import Foundation
import Combine

@Observable
class ApprovedLogisticMapViewModel {
    private let logisticRepository = LogisticMatchingRepository()
    private let ownerRepo = OwnerRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var progressType: ProgressType
    var logistic: OwnerApprovedLogisticDetail?
    
    var logisticMapData: [LogisticMapData]? // 카카오맵 구성을 배열로 해놨기에 형태 따라가는 용
    
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    init(
        logisticId: Int,
        progressType: ProgressType
    ) {
        self.progressType = progressType
        loadLogistic(id: logisticId, progressType: progressType)
    }
    
    func loadLogistic(id: Int, progressType: ProgressType) {
        ownerRepo
            .approvedLogisticDetail(
                logisticId: id,
                type: progressType
            )
            .sink(receiveCompletion: {
                logger.checkComplition(message: "승인된 물류 상세 조회", complition: $0)
            }, receiveValue: {
                self.logistic = $0
                self.showMap()
            })
            .store(in: &cancellables)
    }
    
    func showMap() {
        guard let logistic else { return }
        self.logisticMapData = [logistic.toLogisticMapData()]
        showPoiType = .showMatchedLogistic
    }
}
