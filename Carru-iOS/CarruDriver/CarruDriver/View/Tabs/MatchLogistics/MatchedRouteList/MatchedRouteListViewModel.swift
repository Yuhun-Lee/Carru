//
//  MatchedRouteListViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation
import Combine

@Observable
class MatchedRouteListViewModel {
    let logisticMatchingRepository = LogisticMatchingRepository()
    private var cancellables = Set<AnyCancellable>()
    
    var logistics: [Logistic] = []
    var maxWeight: Int
    var minWeight: Int
        
    init(
        maxWeight: Int,
        minWeight: Int
    ) {
        self.maxWeight = maxWeight
        self.minWeight = minWeight
        
//        loadLogistics(
//            sortPrice: 0,
//            sortDistance: 0,
//            warehouseKeyword: ""
//        )
    }
    
    func loadLogistics(
        sortPrice: Int,
        sortDistance: Int,
        warehouseKeyword: String
    ) {
        logger.printOnDebug("\(sortPrice)")
        
        logisticMatchingRepository
            .getLogisticMatching(
                matchConstraints: .init(
                    maxWeight: maxWeight,
                    minWeight: minWeight,
                    sortPrice: sortPrice,
                    sortOperationDistance: sortDistance,
                    warehouseKeyword: warehouseKeyword
                )
            )
            .sink(receiveCompletion: {
                logger.checkComplition(message: "물류 리스트 받기", complition: $0)
            }, receiveValue: { logistics in
                self.logistics = logistics
            })
            .store(in: &cancellables)
    }
}
