//
//  AdminUserLogisticsViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Combine

@Observable
class AdminOwnerApprovedLogisticsViewModel {
    var logistics: [OwnerApprovedLogistics] = []
    
    
    private let adminRepo = AdminRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    // 화주의 ID
    init(id: Int) {
        loadList(id: id)
    }
    
    func loadList(id: Int) {
        adminRepo
            .ownerApprovedList(userId: id)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "화주의 승인된 물류 리스트 조회", complition: $0)
            }, receiveValue: {
                self.logistics = $0
            })
            .store(in: &cancellables)
            
    }
}
