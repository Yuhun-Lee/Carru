//
//  MatchedRouteMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import Foundation
import Combine

@Observable
class MatchedRouteMapViewModel {
    private let logisticRepository = LogisticMatchingRepository()
    private let reservationRepository = ReservationRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var logistic: Logistic?
    
    var logisticMapData: [LogisticMapData]? // 카카오맵 구성을 배열로 해놨기에 형태 따라가는 용
    
    var currentLocation: Location
    var showPoiType: KakaoMapView.ShowPoiType
    var updateEvent: Bool
    
    // 아래는
    var targetLogistic: Logistic? {
        return logistic
    }
    
    var title: String {
        return logistic?.title ?? ""
    }
    
    var operationTime: String {
        return "\(logistic?.operationTime ?? 0)"
    }
    
    var description: String {
        return logistic?.description ?? ""
    }
    
    var category: String {
        return  logistic?.productName ?? "카테고리 없음"
    }
    
    var price: String {
        return "\(logistic?.price ?? 0)"
    }
    
    var destination: String {
        return logistic?.destinationLocation ?? "도착지 없음"
    }
    
    init(
        id: Int,
        logistic: Logistic? = nil,
        currentLocation: Location = LocationManager.shared.myLocation,
        showPoiType: KakaoMapView.ShowPoiType = .nothing,
        updateEvent: Bool = false
    ) {
        self.logistic = logistic
        self.currentLocation = currentLocation
        self.showPoiType = showPoiType
        self.updateEvent = updateEvent
        
        loadLogistic(id: id)
    }
    
    func loadLogistic(id: Int) {
        logisticRepository
            .getLogisticMatching(id: id)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "물류 상세 조회", complition: $0)
            }, receiveValue: { logistic in
                self.logistic = logistic
                self.logisticMapData = [logistic.toLogisticMapData()]
                self.currentLocation = LocationManager.shared.myLocation
                self.showPoiType = .showMatchedLogisticAndMyLocation
                self.updateEvent.toggle()
            })
            .store(in: &cancellables)
    }
    
    func reservation() -> Future<Bool, Never> {
        Future { [weak self] promise in
            guard
                let self,
                let id = targetLogistic?.productId
            else {
                logger.printOnDebug("물류 없음..!")
                promise(.success(false))
                return
            }
            
            reservationRepository
                .logisticMatchingReservation(logisticId: id)
                .sink(receiveCompletion: { complition in
                    logger.checkComplition(message: "물류 예약", complition: complition)
                    
                    switch complition {
                    case .finished:
                        promise(.success(true))
                    case .failure:
                        promise(.success(false))
                    }
                }, receiveValue: { _ in
                })
                .store(in: &cancellables)
        }
    }
}
