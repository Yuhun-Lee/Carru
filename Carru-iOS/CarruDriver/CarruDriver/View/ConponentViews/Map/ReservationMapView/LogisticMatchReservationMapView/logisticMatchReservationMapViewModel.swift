//
//  ReservationMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/13/24.
//

import Foundation
import Combine

@Observable
class logisticMatchReservationMapViewModel {
    var logisticMapData: [LogisticMapData]?
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    var reservation: LogisticsMatchingReservationDetail = .init()
    
    var reserveRepo = ReservationRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var routeDescription: String {
        return "출발: \(reservation.departureLocation)\n도착: \(reservation.destinationLocation) "
    }
    
    var description: String {
        return "운송무게: \(reservation.weight)톤, 비용: \(reservation.price)만원, 운행거리: \(reservation.operationDistance)km, 운행시간: \(reservation.operationTime == 0 ? "1시간 이내" : "\(reservation.operationTime)시간")"
    }
    
    init(productID: Int) {
        loadReservatedLogistic(listId: productID)
    }
    
    func loadReservatedLogistic(listId: Int) {
        reserveRepo.logisticsMatchingReservationDetail(id: listId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "물류 예약 상세 로드", complition: $0)
            }, receiveValue: { [weak self] reservation in
                self?.reservation = reservation
                self?.showMap()
            })
            .store(in: &cancellables)
    }
    
    func showMap() {
        let logisticMapData = reservation.toLogisticMapData()
        self.logisticMapData = [logisticMapData]
        showPoiType = .showMatchedLogisticAndMyLocation
    }
    
    
    func changeTransferStatus(_ type: ReservationAPI.StatusChnageType ) -> Future<Bool, Never> {
        Future { [weak self] promise in
            guard let self else { return }
            
            reserveRepo.logisticsMatchingStatusChange(
                id: reservation.productId,
                status: type
            )
            .sink(
                receiveCompletion: {
                    logger.checkComplition(
                        message: "\(self.reservation.productId) \(type.title) 변경",
                        complition: $0
                    )
                    
                    switch $0 {
                    case .finished:
                        promise(.success(true))
                    case .failure:
                        promise(.success(false))
                    }
                },
                receiveValue: { _ in
            })
            .store(in: &cancellables)
        }
    }
}

