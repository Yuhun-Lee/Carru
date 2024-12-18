//
//  UserRegisterApproveViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Combine

@Observable
class UserRegisterApproveViewModel {    
    var users: [UnApprovedUser] = []
    
    private let adminRepo = AdminRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var selectedUserTypeSegment: AdminUserType = .owner {
        didSet {
            loadUserList()
        }
    }
    
    func loadUserList() {
        adminRepo.unApprovedUserList(type: selectedUserTypeSegment.type)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "미승인 \(self.selectedUserTypeSegment.rawValue) 유저 목록", complition: $0)
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &cancellables)
    }
    
    func approve(user: UnApprovedUser) {
        adminRepo.userSignUpRegister(userId: user.userId)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "\(user.name) 유저 승인", complition: $0)
            }, receiveValue: { [weak self] _ in
                // 승인이 끝나면 loadUserList업데이트
                self?.loadUserList()
            })
            .store(in: &cancellables)
    }
}
