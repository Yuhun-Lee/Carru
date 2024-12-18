//
//  NetworkManager.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation
import Combine
import Moya

class NetworkManager {
    static let shared = NetworkManager()
    
    let addressRepository = AddressRepository()
    
    private init() {}
    
    func searchAddress(keyword: String) -> AnyPublisher<[String], Error> {
        addressRepository.searchAddress(keyword: keyword)
    }
    
    func getPointFromAddress(address: String) -> AnyPublisher<Location?, Error> {
        addressRepository.getPointFromAddress(address: address)
    }
}
