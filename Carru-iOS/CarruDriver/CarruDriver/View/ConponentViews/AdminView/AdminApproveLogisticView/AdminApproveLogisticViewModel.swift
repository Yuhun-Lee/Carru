//
//  AdminApproveLogisticViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Combine

@Observable
class AdminApproveLogisticViewModel {
    var logistics: [UnApprovedLogistics] = []
    
    private let adminRepo = AdminRepository()
    private var cancellables = Set<AnyCancellable>()
    
    func loadList() {
        adminRepo.unApprovedLogisticsList()
            .sink(receiveCompletion: {
                logger.checkComplition(message: "미승인 물류 리스트 조회", complition: $0)
            }, receiveValue: { unApprovedLogistics in
                self.logistics = unApprovedLogistics
            })
            .store(in: &cancellables)
    }
    
    func approve(logistic: UnApprovedLogistics) {
        adminRepo.approveLogistics(logisticId: logistic.logisticsId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "물류 승인", complition: $0)
            }, receiveValue: { [weak self] _ in
                self?.loadList()
            })
            .store(in: &cancellables)
    }
}

