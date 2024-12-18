//
//  LogisticMatchingRepository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class LogisticMatchingRepository: BaseRepository {
    private let provider = MoyaProvider<LogisticAPI>()
    
    /// AI 서버
    func routeMatching(request: RouteMatchingRequestDTO) -> AnyPublisher<[RoutePredict], Error> {
        provider.requestPublisher(.routeMatching(request: request))
            .tryMap {
                try self.decodeResponse(RouteMatchingResponseDTO.self, from: $0)
            }
            .map{ $0.toRoutePredicts() }
            .eraseToAnyPublisher()
    }
    
    
    /// 7. 화물기사 - 물류매칭 리스트 조회 조건에 부합하는 매칭 물류들 받기
    func getLogisticMatching(matchConstraints: LogisticMatchingRequestDTO) -> AnyPublisher<[Logistic], Error> {
        provider.requestPublisher(.logisticMatching(matchConstraints: matchConstraints))
            .tryMap {
                try self.decodeResponse(LogisticMatchingResponseDTO.self, from: $0)
            }
            .map{ $0.toLogistics() }
            .eraseToAnyPublisher()
    }
    
    /// 8. 화물기사 - 물류 매칭 리스트 상세조회(특정 물류 받기)
    func getLogisticMatching(id: Int) -> AnyPublisher<Logistic, Error> {
        provider.requestPublisher(.logisticMatchingById(id: id))
            .tryMap {
                try self.decodeResponse(LogisticMatchingByIdResponseDTO.self, from: $0)
            }
            .map{ $0.toLogistic()}
            .eraseToAnyPublisher()
    }
}
