//
//  SignInViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI
import Combine



@Observable
class SignInViewModel {
    var id: String = ""
    var password: String = ""
    
    let userRepo = UserRepository()
    
    private var cancellables = Set<AnyCancellable>()
    
    func selectWarehouse(wharehouse: Address) {
        logger.printOnDebug("창고 선택")
    }
    
    func signIn() -> Future<Bool, Error> {
        return Future { [weak self] promise in
            guard let self else {
                promise(.failure(SignUpError.invalidError(message: "self 없음")))
                return
            }
            
            self.userRepo
                .signIn(
                    userStatus: appType.userStatus,
                    signInDTO: .init(
                        email: self.id,
                        password: self.password
                    )
                )
                .sink { complication in
                    logger.checkComplition(message: "로그인", complition: complication)
                    
                    switch complication {
                    case .finished:
                        promise(.success(true))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { _ in}
                .store(in: &self.cancellables)
            
        }
    }
}
