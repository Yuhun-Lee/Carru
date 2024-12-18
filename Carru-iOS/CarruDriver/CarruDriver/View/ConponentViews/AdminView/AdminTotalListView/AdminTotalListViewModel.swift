//
//  AdminTotalListViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Combine

@Observable
class AdminTotalListViewModel {
    enum ListType: String, CaseIterable, Identifiable {
        case logistic = "물류"
        case owner = "화주"
        case driver = "기사"
        
        var id: String { self.rawValue }
        
        var type: Int {
            switch self {
            case .logistic: return 0
            case .owner: return 1
            case .driver: return 2
            }
        }
    }
    
    var logistics: [ApprovedLogistics] = []
    var ownerUsers: [ApprovedUser] = []
    var driverUsers: [ApprovedUser] = []
    
    var selectedListTypeSegment: ListType = .logistic {
        didSet {
            loadList()
        }
    }
    
    private let adminRepo = AdminRepository()
    private var cancellables = Set<AnyCancellable>()
    
    
    func loadList() {
        if selectedListTypeSegment == .logistic {
            adminRepo.approvedLogisticsList()
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "승인된 물류 리스트 조회", complition: $0)
                }, receiveValue: {
                    self.logistics = $0
                })
                .store(in: &cancellables)
            
        } else if selectedListTypeSegment == .owner {
            adminRepo.approvedUserList(type: .owner)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "승인된 화주 리스트 조회", complition: $0)
                }, receiveValue: {
                    self.ownerUsers = $0
                })
                .store(in: &cancellables)
        } else if selectedListTypeSegment == .driver {
            adminRepo.approvedUserList(type: .driver)
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "승인된 기사 리스트 조회", complition: $0)
                }, receiveValue: {
                    self.driverUsers = $0
                })
                .store(in: &cancellables)
        }
    }
}
