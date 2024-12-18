//
//  UnapprovedLogisticsViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import Foundation
import Combine

@Observable
class UnapprovedLogisticsViewModel {
    var unApprovedLogistics: [UnapprovedLogistics] = []
    
    private let ownerRepo = OwnerRepository()
    private var cancellables = Set<AnyCancellable>()
    
    func loadList() {
        ownerRepo
            .unapprovedLogisticsList()
            .sink(receiveCompletion: {
                logger.checkComplition(message: "미승인 물류 리스트 조회", complition: $0)
            }, receiveValue: {
                self.unApprovedLogistics = $0
            })
            .store(in: &cancellables)
    }
}

