//
//  AddressViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import Foundation
import Combine


@Observable
class AddressViewModel {
    enum ListType {
        case addressSearch
        case warehouseSearch
    }
    
    var addresses: [String] = []
    var wareshouses: [Warehouse] = []
    
    var searchKey: String
    var selectedAddress: String? = nil
    var selectedWarehouse: Warehouse? = nil
    
    
    var listType: ListType
    
    
    let addressRepository = AddressRepository()
    private let ownerRepo = OwnerRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(searchKey: String = "", type: ListType = .addressSearch) {
        self.searchKey = searchKey
        self.listType = type
    }
    
    func searchAddress() {
        logger.printOnDebug("주소 검색")
        
        addressRepository
            .searchAddress(keyword: searchKey)
            .sink {
                logger.checkComplition(message: "주소 조회", complition: $0)
            } receiveValue: { addresses in
                self.addresses = addresses
            }
            .store(in: &cancellables)
    }
    
    func searchWarehouse() {
        logger.printOnDebug("창고 검색")
        
        ownerRepo
            .searchWarehouseList(keyword: searchKey)
            .sink(receiveCompletion: {
                logger.checkComplition(message: "창고 리스트 조회", complition: $0)
            }, receiveValue: {
                self.wareshouses = $0
            })
            .store(in: &cancellables)
    }
}
