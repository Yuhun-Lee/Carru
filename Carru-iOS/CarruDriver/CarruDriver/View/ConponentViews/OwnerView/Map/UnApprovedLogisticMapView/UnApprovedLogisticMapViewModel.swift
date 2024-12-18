//
//  UnApprovedLogisticMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import Foundation
import Combine

@Observable
class UnApprovedLogisticMapViewModel {
    private let logisticRepository = LogisticMatchingRepository()
    
    private let addressRepo = AddressRepository()
    private let ownerRepo = OwnerRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var logisticId: Int
    var logistic: UnapprovedLogisticDetail = .init(
        productName: "",
        warehouseId: 0,
        warehouseName: "",
        warehouseLat: 0,
        warehouseLng: 0,
        destination: "",
        destinationLat: 0,
        destinationLng: 0,
        weight: 0,
        price: 0,
        operationDistance: 0,
        operationTime: 0,
        deadline: .now
    )
    
    
    var logisticMapData: [LogisticMapData]? // 카카오맵 구성을 배열로 해놨기에 형태 따라가는 용
    
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    var title: String {
        return "출발: \(logistic.warehouseName)\n도착: \(logistic.destination)"
    }
    
    init(
        id: Int
    ) {
        logisticId = id
    }
    
    func loadLogistic() {
        ownerRepo
            .unapprovedLogisticDetail(logisticId: logisticId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "미승인 물류 상세조회", complition: $0)
            }, receiveValue: {
                self.logistic = $0
                self.showMap()
            })
            .store(in: &cancellables)
    }
    
    func showMap() {
        self.logisticMapData = [logistic.toLogisticMapData()]
        showPoiType = .showMatchedLogistic
    }
    
    func removeLogistic() -> Future<Bool, Never> {
        return Future { [weak self] promise in
            guard let self else { return }
            
            ownerRepo.deleteUnapprovedLogistic(
                logisticId: logisticId,
                request: .init(
                    warehouseId: logistic.warehouseId,
                    name: logistic.warehouseName,
                    weight: logistic.weight,
//                    cost: logistic.price,
                    deadline: logistic.deadline.ISO8601Format()
                )
            )
            .sink {
                logger.checkComplition(message: "미승인 물류 삭제", complition: $0)
                switch $0 {
                case .finished:
                    promise(.success(true))
                case .failure:
                    promise(.success(false))
                }
                
            } receiveValue: { _ in }
            .store(in: &cancellables)
        }
    }
    
    func editLogistic() {
        
    }
}

