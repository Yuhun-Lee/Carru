//
//  SettingViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI
import Combine

@Observable
class SettingViewModel {
    var profile: Profile = .init(
        email: "",
        name: ""
    )
    
    var garageAddress: String = ""
    
    var isLogoutAlertPresent: Bool = false
    var isNameChangeAlertPresent: Bool = false
    var isFindAddressPresent: Bool = false
    
    let userRepo = UserRepository()
    let addressRepo = AddressRepository()
    private var cancellables = Set<AnyCancellable>()
    
    func loadUser() {
        userRepo.profile()
            .sink(receiveCompletion: {
                logger.checkComplition(message: "프로필 로딩", complition: $0)
            }, receiveValue: { profile in
                self.profile = profile
            })
            .store(in: &cancellables)
    }
    
    func loadGarage() {
        userRepo.userWarehouseList()
            .sink(receiveCompletion: {
                logger.checkComplition(message: "차고지 조회", complition: $0)
            }, receiveValue: { garage in
                self.garageAddress = garage.location
            })
            .store(in: &cancellables)
    }
    
    func changeWarehouse(newAddress: String) -> Future<Bool, Error> {
        Future { [weak self] promise in
            guard let self else { return }
            logger.printOnDebug("창고 변경")
            garageAddress = newAddress
            
            addressRepo.getPointFromAddress(address: newAddress)
                .flatMap { location -> AnyPublisher<Bool, Error> in
                    guard let location else {
                        return Fail(error: CommonError.commonError(message: "Location 없음"))
                            .eraseToAnyPublisher()
                    }
                    
                    return self.userRepo.changeWareshouse(
                        request: .init(
                            location: newAddress,
                            locationLat: location.latitude,
                            locationLng: location.longitude
                        )
                    )
                    .map { _ in true }
                    .eraseToAnyPublisher()
                }
                .sink(
                    receiveCompletion: { completion in
                        logger.checkComplition(message: "주소 위경도 변환", complition: completion)
                        if case .failure(let error) = completion {
                            promise(.failure(error))
                        }
                    },
                    receiveValue: { success in
                        promise(.success(success))
                    }
                )
                .store(in: &self.cancellables)
        }
    }

    func userNameChange(newName: String) -> Future<Bool, Never> {
        logger.printOnDebug("이름 변경: \(newName)")
        isNameChangeAlertPresent = false
        
        return Future { [weak self] promise in
            guard let self else { return }
            userRepo
                .changeName(newName: newName)
                .sink(
                    receiveCompletion: {
                        logger.checkComplition(message: "이름 변경", complition: $0)
                        switch $0 {
                        case .finished:
                            promise(.success(true))
                        case .failure:
                            promise(.success(false))
                        }
                    },
                    receiveValue: { _ in
                        self.profile = .init(
                            email: self.profile.email,
                            name: newName
                        )
                })
                .store(in: &cancellables)
        }
    }
    
    func signOut() -> Future<Bool, Never> {
        Future { [weak self] promise in
            logger.printOnDebug("로그아웃")
            // 로그아웃 할 때, 작업들
            promise(.success(true))
            self?.isLogoutAlertPresent = false
        }
    }
}
