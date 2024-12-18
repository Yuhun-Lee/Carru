//
//  SuggestRouteMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import Combine


struct RouteItem: Hashable {
    let locationName: String
    let productName: String
    let price: Int
    let weight: Int
    let destinationName: String // 도착지 이름 추가
}


@Observable
class SuggestRouteMapViewModel {
    var title: String = "경로탐색"
//    var description: String = "Suggest Route description"
    
    var route: RoutePredict
    var logistics: [RouteItem] = []
    var logisticMapData: [LogisticMapData]? = []
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    private let reservationRepository = ReservationRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(routePredict: RoutePredict) {
        self.route = routePredict
        setRouteData()
    }
    
    private func setRouteData() {
        logistics = route.toRouteItemList()
    }
    
    func showMap() {
        self.logisticMapData = route.toLogisticMapData()
        showPoiType = .showLogisticsPointsAndMyLocation
    }
    
    func reservation() -> Future<Bool, Never> {
        return Future { [weak self] promise in
            guard let self else { return }
            
            reservationRepository
                .routeMatchingReservation(
                    request: .init(
                        maxWeight: route.userProductInfo.maxWeight,
                        minWeight: route.userProductInfo.minWeight,
                        departureLocation: route.mainProductInfo.departure,
                        departureLatitude: route.mainProductInfo.departureLat,
                        departureLongitude: route.mainProductInfo.departureLong,
                        destinationLocation: route.mainProductInfo.destination,
                        destinationLatitude: route.mainProductInfo.destinationLat,
                        destinationLongitude: route.mainProductInfo.destinationLat,
                        estimatedDepartureTime: route.userProductInfo.departureTime.aiServerDateToISOString() ?? Date().ISO8601Format(),
                        likePrice: route.totalPrice,
                        likeShortOperationDistance: 0,
                        stopOverIds: route.stopOverIds()
                    )
                )
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "경로 탐색 예약", complition: $0)
                    
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
