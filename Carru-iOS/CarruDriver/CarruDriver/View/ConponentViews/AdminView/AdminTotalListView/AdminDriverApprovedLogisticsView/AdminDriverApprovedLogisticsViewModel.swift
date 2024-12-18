//
//  AdminDriverLogisticsViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/28/24.
//

import Foundation
import Combine

@Observable
class AdminDriverApprovedLogisticsViewModel {
    enum ReservationSegment: String, CaseIterable, Identifiable {
        case Matched = "물류 매칭"
        case Route = "경로 탐색"
        
        var id: String { self.rawValue }
    }
    
    var userId: Int
    
    var matchedLogistics: [DriverLogisticMatching] = []
    var routeLogistics: [DriverRouteMatching] = []
    
    var selectedReservationSegment: ReservationSegment = .Matched {
        didSet {
            loadList()
        }
    }

    private let adminRepo = AdminRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    
    init(userId: Int) {
        self.userId = userId
    }
    
    func loadList() {
        logger.printOnDebug("현재 선택: \(selectedReservationSegment.rawValue)")
        
        if selectedReservationSegment == .Matched {
            adminRepo
                .driverLogisticMatchingListDetail(userId: userId)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "화물 기사 물류 매칭 승인 목록 조회", complition: $0)
                }, receiveValue: {
                    self.matchedLogistics = $0
                })
                .store(in: &cancellables)
            
        } else if selectedReservationSegment == .Route {
            adminRepo
                .driverRouteMatchingListDetail(userId: userId)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "화물 기사 경로 탐색 승인 목록 조회", complition: $0)
                }, receiveValue: {
                    self.routeLogistics = $0
                })
                .store(in: &cancellables)
            
        }
    }
}

