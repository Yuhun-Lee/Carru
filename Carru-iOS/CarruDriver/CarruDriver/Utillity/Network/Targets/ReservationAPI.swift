//
//  ReservationAPI.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/19/24.
//

import Foundation
import Moya

enum ReservationAPI {
    enum StatusChnageType {
        case todoToProgress
        case progressToTodo
        case progressToFinished
        
        var statusID: Int {
            switch self {
            case .todoToProgress:
                return 0
            case .progressToTodo:
                return 1
            case .progressToFinished:
                return 2
            }
        }
        
        var title: String {
            switch self {
            case .todoToProgress:
                "투두에서 진행"
            case .progressToTodo:
                "진행에서 투두"
            case .progressToFinished:
                "진행에서 종료"
            }
        }
    }
    
    
    // 물류 매칭 예약
    case logisticMatchingReservation(logisticsMatchingId: Int)
    // 물류 매칭 예약 목록
    case logisticsMatchingReservingList(type: Int)
    // 물류 매칭 운송 상태 변경
    case logisticsMatchingStatusChange(id: Int, status: StatusChnageType)
    // 물류 매칭 예약 상세 조회
    case logisticsMatchingReservationDetail(id: Int)
    
    
    // 경로 탐색 예약
    case routeMatchingReservation(request: RouteMatchingReservationRequestDTO)
    // 경로 탐색 예약 목록
    case routeMatchingReservingList(type: Int)
    // 경로 탐색 운송 상태 변경
    case routeMatchingStatusChange(id: Int, status: StatusChnageType)
    // 경로 탐색 예약 상세 조회
    case routeMatchingReservationDetails(id: Int)
}

extension ReservationAPI: TargetType {
    var baseURL: URL {
        return InfoManager.carruServerBaseURL
    }
    
    var path: String {
        switch self {
        case .logisticMatchingReservation(let logisticsMatchingId):
            return "/v1/driver/logisticsMatching/\(logisticsMatchingId)"
        case .logisticsMatchingReservingList:
            return "/v1/driver/logisticsMatching/reservingList"
        case .logisticsMatchingStatusChange(let id, _):
            return "/v1/driver/logisticsMatching/\(id)"
        case .logisticsMatchingReservationDetail(let id):
            return "/v1/driver/logisticsMatching/reservingList/\(id)"
            
            
        case .routeMatchingReservation:
            return "/v1/driver/routeMatching"
        case .routeMatchingReservingList:
            return "/v1/driver/routeMatching/reservingList"
        case .routeMatchingStatusChange(let id, _):
            return "/v1/driver/routeMatching/\(id)"
        case .routeMatchingReservationDetails(let id):
            return "/v1/driver/routeMatching/reservingList/\(id)"
        
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logisticMatchingReservation:
            return .post
        case .logisticsMatchingReservingList:
            return .get
        case .logisticsMatchingStatusChange:
            return .patch
        case .logisticsMatchingReservationDetail:
            return .get
            
        case .routeMatchingReservation:
            return .post
        case .routeMatchingReservingList:
            return .get
        case .routeMatchingStatusChange:
            return .patch
        case .routeMatchingReservationDetails:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logisticMatchingReservation:
            return .requestPlain
        case .logisticsMatchingReservingList(let type):
            return .requestParameters(
                parameters: ["listType": type],
                encoding: URLEncoding.queryString
            )
        case .logisticsMatchingStatusChange(_, status: let status):
            return .requestParameters(
                parameters: ["status" : status.statusID],
                encoding:  URLEncoding.queryString
            )
        case .logisticsMatchingReservationDetail:
            return .requestPlain
            
            
        case .routeMatchingReservation(let matchConstraints):
            return .requestJSONEncodable(matchConstraints)
        case .routeMatchingReservingList(let type):
            return .requestParameters(
                parameters: ["listType": type],
                encoding: URLEncoding.queryString
            )
        case .routeMatchingStatusChange(_, let status):
            return .requestParameters(
                parameters: ["status" : status.statusID],
                encoding:  URLEncoding.queryString
            )
        case .routeMatchingReservationDetails:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        guard let token = try? Keychain.searchToken(kind: .accessToken) else {
            logger.printOnDebug("키체인 토큰 없음?!")
            return nil
        }
        
        return [
            "Content-Type": "application/json",
            "X-AUTH-TOKEN": token
        ]
    }
}
