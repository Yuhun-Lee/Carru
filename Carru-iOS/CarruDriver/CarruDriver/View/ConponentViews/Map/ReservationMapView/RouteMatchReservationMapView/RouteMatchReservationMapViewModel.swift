//
//  RouteMatchReservationMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/21/24.
//

import Foundation
import Combine

@Observable
class RouteMatchReservationMapViewModel {
    var stopOvers: [StopOverDetails]? = nil
    
    var logisticMapData: [LogisticMapData]? = nil
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    var reservation: RouteReservation
    var reservationDetail: RouteMatchingReservationDetails = .init()
    
    var dateDescription: String  {
        return ""
    }
    
    var routeDescription: String {
        return "출발: \(reservationDetail.departureLocation) \n도착: \(reservationDetail.destinationLocation) "
    }
    
    var description: String {
        return "운송무게: \(reservationDetail.totalWeight)톤, 비용: \(reservationDetail.totalPrice)만원"
    }
    
    private let reservationRepo = ReservationRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    
    init(reservation: RouteReservation) {
        self.reservation = reservation
        loadReservationDetail()
    }
    
    func loadReservationDetail() {
        reservationRepo
            .routeMatchingReservationDetails(id: reservation.listId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "경로 탐색 예약 상세 조회", complition: $0)
            }, receiveValue: {
                self.reservationDetail = $0
                self.stopOvers = $0.toStopOverDetails()
                self.showMap()
            })
            .store(in: &cancellables)
    }
    
    func showMap() {
        self.logisticMapData = reservationDetail.toLogisticMapData()
        showPoiType = .showLogisticsPointsAndMyLocation
    }
    
    func changeTransferStatus(_ status: ReservationAPI.StatusChnageType) -> Future<Bool, Never> {
        return Future { [weak self] promise in
            guard let self else { return }
            
            reservationRepo
                .routeMatchingStatusChange(id: reservationDetail.listId, status: status)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "경로 탐색 예약 운송 상태 변경", complition: $0)
                    switch $0 {
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
