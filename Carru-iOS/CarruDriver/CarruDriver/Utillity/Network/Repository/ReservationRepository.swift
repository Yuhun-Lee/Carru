//
//  ReservationRepository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/19/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

class ReservationRepository: BaseRepository {
    enum ReservationListType: Int {
        case todo = 0
        case inProgress = 1
        case finished = 2
    }
    
    private let provider = MoyaProvider<ReservationAPI>()
    
    // MARK: - 물류 매칭
    
    /// 9. 화물기사 - 물류 매칭 예약
    func logisticMatchingReservation(logisticId id: Int) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.logisticMatchingReservation(logisticsMatchingId: id))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 10.1. 화물기사 - 예약목록 조회(물류매칭 예약 조회)
    func logisticMatchingReservationList(type: Int) -> AnyPublisher<[LogisticReservation], Error> {
        provider.requestPublisher(.logisticsMatchingReservingList(type: type))
            .tryMap { try self.decodeResponse(LogisticMatchingReservationListResponseDTO.self, from: $0) }
            .map{ $0.toLogisticReservations() }
            .eraseToAnyPublisher()
    }
    
    /// 13. 화물기사 - 물류 매칭 운송 상태 변경
    func logisticsMatchingStatusChange(id: Int, status: ReservationAPI.StatusChnageType) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.logisticsMatchingStatusChange(id: id, status: status))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 15. 화물기사 - 물류 매칭 예약 상세 조회
    func logisticsMatchingReservationDetail(id: Int) -> AnyPublisher<LogisticsMatchingReservationDetail, Error> {
        provider.requestPublisher(.logisticsMatchingReservationDetail(id: id))
            .tryMap {
                try self.decodeResponse(LogisticsMatchingReservationDetailResponseDTO.self, from: $0)
            }
            .map { $0.toLogisticsMatchingReservationDetail() }
            .eraseToAnyPublisher()
    }

    
    // MARK: - 경로 탐색
    
    /// 10. 화물기사 - 경로 탐색 예약
    func routeMatchingReservation(request: RouteMatchingReservationRequestDTO) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.routeMatchingReservation(request: request))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 11. 화물기사 - 경로탐색 예약 목록 조회
    func routeMatchingReservationList(type: Int) -> AnyPublisher<[RouteReservation], Error> {
        provider.requestPublisher(.routeMatchingReservingList(type: type))
            .tryMap { try self.decodeResponse(RouteMatchingReservationListResponseDTO.self, from: $0) }
            .map{ $0.toRouteReservations() }
            .eraseToAnyPublisher()
    }
    
    /// 12. 화물기사 - 경로 탐색 운송 상태 변경
    func routeMatchingStatusChange(id: Int, status: ReservationAPI.StatusChnageType) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.routeMatchingStatusChange(id: id, status: status))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 14. 화물기사 - 경로 탐색 예약 목록 상세 조회
    func routeMatchingReservationDetails(id: Int) -> AnyPublisher<RouteMatchingReservationDetails, Error> {
        provider.requestPublisher(.routeMatchingReservationDetails(id: id))
            .tryMap {
                try self.decodeResponse(RouteMatchingReservationDetailsResponseDTO.self, from: $0)
            }
            .map{ $0.toReservationDetails() }
            .eraseToAnyPublisher()
    }
}

