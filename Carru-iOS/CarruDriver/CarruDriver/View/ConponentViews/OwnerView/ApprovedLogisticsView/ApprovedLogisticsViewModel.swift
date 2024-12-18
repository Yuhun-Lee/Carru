//
//  ApprovedLogisticsViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import Foundation
import Combine

@Observable
class ApprovedLogisticsViewModel {    
    var logistics: [OwnerApprovedLogistic] = []
    
    private let ownerRepo = OwnerRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var selectedProcessType: ProgressType = .todo {
        didSet {
            loadList()
        }
    }
    
    func loadList() {
        ownerRepo
            .approvedLogisticsList(type: selectedProcessType)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "승인된 물류 리스트 조회", complition: $0)
            }, receiveValue: {
                self.logistics = $0
            })
            .store(in: &cancellables)
    }
}
