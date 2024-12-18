//
//  LogisticRegisterViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import Foundation
import Combine

@Observable
class LogisticRegisterViewModel {
    enum State {
        case register
        case edit
    }
    var state: State = .register
    var viewTitle: String = "물류 등록"
    
    var category: String = ""
    var weight: String = ""
//    var price: String = ""
    var destination: String = ""
    var deadline: Date = .now
    
    var selectedWarehouse: Warehouse?
    
    var logisticId: Int? // 수정 삭제시에만 사용
    var deadlineString: String {
        deadline.ISO8601Format()
    }
    
    var buttonTitle: String {
        state == .register ? "등록" : "수정"
    }
    
    private let ownerRepo = OwnerRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(id: Int? = nil) {
        logisticId = id
        if let id {
            loadLogistic(id: id)
            state = .edit
            viewTitle = "물류 수정"
        }
    }
    
    var isDestAddressPresent: Bool = false
    var isFindAddressPresent: Bool = false
    
    func loadLogistic(id: Int) {
        ownerRepo
            .unapprovedLogisticDetail(logisticId: id)
            .sink(
                receiveCompletion: {
                    logger.checkComplition(message: "미승인 물류 상세 조회", complition: $0)
                },
                receiveValue: { [weak self] in
                    self?.category = $0.productName
//                    self?.price = "\($0.price)"
                    self?.weight = "\($0.weight)"
                    self?.destination = $0.destination
                    self?.deadline = $0.deadline
            })
            .store(in: &cancellables)
    }
    
    func registerLogistic() -> Future<Bool, Never> {
        return Future { [weak self] promise in
            guard
                let self,
                let selectedWarehouse,
                let weight = Int(weight)
//                let cost = Int(price)
            else {
                logger.printOnDebug("값 설정 확인 필요")
                return
            }
            
            ownerRepo
                .registerLogistics(
                    request: .init(
                        warehouseId: selectedWarehouse.warehouseId,
                        name: category,
                        weight: weight,
//                        cost: cost,
                        deadline: deadline.ISO8601Format()
                    )
                )
                .sink(receiveCompletion: {
                    logger.checkComplition(message: "물류 등록", complition: $0)
                    switch $0 {
                    case .finished:
                        promise(.success(true))
                    case .failure:
                        promise(.success(false))
                    }
                }, receiveValue: { _ in
                })
                .store(in: &cancellables)
        }
    }
    
    func editLogistic() -> Future<Bool, Never> {
        return Future { [weak self] promise in
            guard
                let self,
                let weight = Int(weight),
                let logisticId
            else {
                logger.printOnDebug("값 설정 확인 필요")
                return
            }
            
            ownerRepo.fixUnapprovedLogistic(
                logisticId: logisticId,
                request: .init(
                    warehouseId: selectedWarehouse?.warehouseId,
                    name: category,
                    weight: weight,
//                    cost: cost,
                    deadline: deadline.ISO8601Format()
                )
            )
            .sink(receiveCompletion: {
                logger.checkComplition(message: "물류 수정", complition: $0)
                
                switch $0 {
                case .finished:
                    promise(.success(true))
                case .failure:
                    promise(.success(false))
                }
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)
        }
    }
    
    func resetFeilds() {
        weight = ""
        category = ""
        destination = ""
        selectedWarehouse = nil
        deadline = Date()
    }
}



