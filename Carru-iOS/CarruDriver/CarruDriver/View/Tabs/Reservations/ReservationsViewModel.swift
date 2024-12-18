//
//  ReservationsViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/13/24.
//

import Foundation
import Combine

@Observable
class ReservationsViewModel {
    enum ReservationSegment: String, CaseIterable, Identifiable {
        case Matched = "물류 매칭"
        case Route = "경로 탐색"
        
        var id: String { self.rawValue }
    }
    
    enum ProcessSegment: String, CaseIterable, Identifiable {
        case todo = "Todo"
        case inProgress = "In Progress"
        case finished = "Finished"
        
        var id: String { self.rawValue }
        
        var type: Int {
            switch self {
            case .todo: return 0
            case .inProgress: return 1
            case .finished: return 2
            }
        }
    }
    
    var matchedReservations: [LogisticReservation] = []
    var routeReservations: [RouteReservation] = []
    
    var selectedReservationSegment: ReservationSegment = .Matched {
        didSet {
            loadList()
        }
    }
    
    var selectedProcessSegment: ProcessSegment = .todo {
        didSet {
            loadList()
        }
    }
    
    let reserveRepo = ReservationRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    
    func loadList() {
        logger.printOnDebug("현재 선택: \(selectedReservationSegment.rawValue), \( selectedProcessSegment.rawValue)")
        
        if selectedReservationSegment == .Matched {
            reserveRepo
                .logisticMatchingReservationList(type: selectedProcessSegment.type)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "물류 리스트", complition: $0)
                }, receiveValue: { [weak self] reservations in
                    self?.matchedReservations = reservations
                })
                .store(in: &cancellables)
            
        } else if selectedReservationSegment == .Route {
            reserveRepo
                .routeMatchingReservationList(type: selectedProcessSegment.type)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "경로 탐색 리스트", complition: $0)
                }, receiveValue: { [weak self] reservations in
                    self?.routeReservations = reservations
                })
                .store(in: &cancellables)
        }
    }
}
