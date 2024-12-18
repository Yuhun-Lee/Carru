//
//  SignUpViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import Foundation
import Combine

@Observable
class SignUpViewModel {
    var email: String = ""
    var phone: String = ""
    var password: String = ""
    var passwordCheck: String = ""
    var name: String = ""
    var address: String = ""
    var warehouseName: String = ""
    
    var locationLat: Double = LocationManager.shared.myLocation.latitude
    var locationLng: Double = LocationManager.shared.myLocation.longitude
    var warehouse: Warehouse?
    
    
    let addressRepo = AddressRepository()
    let userRepo = UserRepository()
    var cancellables = Set<AnyCancellable>()
    
    var isAddressSelectPresent: Bool = false
    
    func getAddress() {
        self.addressRepo.getPointFromAddress(address: self.address)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "회원가입 전, 주소 좌표 조회", complition: $0)
            }, receiveValue: { data in
                self.locationLat = data?.latitude ?? LocationManager.shared.myLocation.latitude
                self.locationLng = data?.longitude ?? LocationManager.shared.myLocation.longitude
            })
            .store(in: &self.cancellables)
    }
    
    
    func signUp() -> Future<Bool, Error> {
        Future { promise in
            logger.printOnDebug("회원가입 시도")
//            if appType == .driver {
                self.userRepo
                    .signUp(
                        userStatus: appType.userStatus,
                        signUpDTO: .init(
                            name: self.name,
                            email: self.email,
                            password: self.password,
                            phoneNumber: self.phone,
                            location: self.address,
                            locationLat: self.locationLat,
                            locationLng: self.locationLng,
                            warehouseName: self.warehouseName
                        )
                    )
                    .sink { result in
                        switch result {
                        case .finished:
                            promise(.success(true))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    } receiveValue: { _ in}
                    .store(in: &self.cancellables)
//            } else {
//                self.userRepo
//                    .signUp(
//                        userStatus: appType.userStatus,
//                        signUpDTO: .init(
//                            name: self.name,
//                            email: self.email,
//                            password: self.password,
//                            phoneNumber: self.phone,
//                            location: self.warehouse?.name ?? "창고 없음",
//                            locationLat: self.warehouse?.locationLatitude ?? 0.0,
//                            locationLng: self.warehouse?.locationLongitude ?? 0.0
//                        )
//                    )
//                    .sink { result in
//                        switch result {
//                        case .finished:
//                            promise(.success(true))
//                        case .failure(let error):
//                            promise(.failure(error))
//                        }
//                    } receiveValue: { _ in}
//                    .store(in: &self.cancellables)
//            }
            
        }
    }
    
    
}
