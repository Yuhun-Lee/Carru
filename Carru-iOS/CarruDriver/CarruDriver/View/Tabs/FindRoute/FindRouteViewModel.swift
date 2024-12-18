//
//  FindRouteViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation
import CoreLocation
import Combine

@Observable
class FindRouteViewModel {
    enum AddressFindType {
        case departure
        case destination
    }
    
    var maxWeight: String = ""
    var minWeight: String = ""
    var departure: String = ""
    
    var departureLat: Double = 0
    var departureLong: Double = 0
    
    var destination: String = ""
    
    var destinationLat: Double = 0
    var destinationLong: Double = 0

    var departureTime: Date = Date()
    var properRatio: Double = 5.0
    
    var addressFindType: AddressFindType = .departure
    var isStartAddressPresent: Bool = false
    var isDestAddressPresent: Bool = false
    var isFindAddressPresent: Bool = false
    var isFindWarehousePresent: Bool = false
    
    
    private let addressRepo = AddressRepository()
    private let logisticRepo = LogisticMatchingRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    
    
    func findRoute() -> Future<[RoutePredict], Never> {
        Future { [weak self] promise in
            guard let self else { return }
            
            logisticRepo
                .routeMatching(
                    request: .init(
                        maxWeight: maxWeight,
                        minWeight: minWeight,
                        departure: departure,
                        departureLat: "\(departureLat)",
                        departureLong: "\(departureLong)",
                        destination: destination,
                        destinationLat: "\(destinationLat)",
                        destinationLong: "\(destinationLong)",
                        preference: "\(Int(properRatio))",
                        departureTime: departureTime.toString()
                    )
                )
                .sink {
                    logger.checkComplition(message: "경로 탐색", complition: $0)
                    switch $0 {
                    case .finished:
                        break
                    case .failure:
                        promise(.success([]))
                    }
                } receiveValue: {
                    promise(.success($0))
                }
                .store(in: &cancellables)
        }
    }
    
    func departureAddress(address: String) {
        logger.printOnDebug("선택된 주소: \(address)")
        departure = address
        
        addressRepo
            .getPointFromAddress(address: address)
            .sink {
                logger.checkComplition(message: "출발 주소 좌표", complition: $0)
            } receiveValue: { [weak self] location in
                guard
                    let self,
                    let location
                else { return }
                
                departureLat = location.latitude
                departureLong = location.longitude
            }
            .store(in: &cancellables)
    }
    
    func destinationAddress(address: String) {
        logger.printOnDebug("선택된 주소: \(address)")
        destination = address
        
        addressRepo
            .getPointFromAddress(address: address)
            .sink {
                logger.checkComplition(message: "도착 주소 좌표", complition: $0)
            } receiveValue: { [weak self] location in
                guard
                    let self,
                    let location
                else { return }
                
                destinationLat = location.latitude
                destinationLong = location.longitude
            }
            .store(in: &cancellables)
    }
    
    func departureCurrentLocation() {
        let currentLocation = LocationManager.shared.myLocation
        departureLat = currentLocation.latitude
        departureLong = currentLocation.longitude
        
        departure = "현재 위치"
    }
    
    func destinationWarehouse(warehouse: Warehouse) {
        destination = warehouse.name
        destinationLat = warehouse.locationLatitude
        destinationLong = warehouse.locationLongitude
    }
    
    func resetFeilds() {
        maxWeight = ""
        minWeight = ""
        
        departure = ""
        departureLat = 0
        departureLong = 0
        
        destination = ""
        destinationLat = 0
        destinationLong = 0
        
        departureTime = Date()
        
        properRatio = 5.0
    }
}
