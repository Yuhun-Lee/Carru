//
//  AddressRepository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Combine
import Moya
import CombineMoya

class AddressRepository: BaseRepository {
    private let provider = MoyaProvider<AddressAPI>()
    
    /// 주소 검색
    func searchAddress(keyword: String) -> AnyPublisher<[String], Error> {
        provider.requestPublisher(.searchAddress(keyword: keyword))
            .tryMap {
                try self.decodeResponse(AddressResponseDTO.self, from: $0)
            }
            .map{ $0.toAddresses() }
            .eraseToAnyPublisher()
    }
    
    /// 주소로 위경도 받기
    func getPointFromAddress(address: String) -> AnyPublisher<Location?, Error> {
        provider.requestPublisher(.getPointFromAddress(address: address))
            .tryMap {
                try self.decodeResponse(GeoPointResponseDTO.self, from: $0)
            }
            .map{ $0.toLocation() }
            .eraseToAnyPublisher()
    }
}
