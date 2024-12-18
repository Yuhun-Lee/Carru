//
//  LogisticAPI.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation
import Moya

enum LogisticAPI {
    /// 조건에 따른 경로 매칭 물류들 받기
    case routeMatching(request: RouteMatchingRequestDTO)
    /// 조건에 따른 매칭 물류들 받기
    case logisticMatching(matchConstraints: LogisticMatchingRequestDTO)
    /// 물류 상세 정보 받기
    case logisticMatchingById(id: Int)
}

extension LogisticAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .routeMatching:
            return InfoManager.carruAIServerBaseURL
        case .logisticMatching:
            return InfoManager.carruServerBaseURL
        case .logisticMatchingById:
            return InfoManager.carruServerBaseURL
        }
    }
    
    var path: String {
        switch self {
        case .routeMatching:
            return "/predict"
        case .logisticMatching:
            return "/v1/driver/logisticsMatchingList"
        case .logisticMatchingById(let id):
            return "/v1/driver/logisticsMatching/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .routeMatching:
            return .post
        case .logisticMatching:
            return .post
        case .logisticMatchingById:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .routeMatching(let request):
            return .requestJSONEncodable([request])
        case .logisticMatching(let matchConstraints):
            return .requestJSONEncodable(matchConstraints)
        case .logisticMatchingById:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        guard let token = try? Keychain.searchToken(kind: .accessToken) else {
            logger.printOnDebug("키체인 토큰 없음?!")
            return nil
        }
        
        switch self {
        case .routeMatching:
            return [
                "Content-Type": "application/json"
            ]
            
        case .logisticMatching, .logisticMatchingById:
            return [
                "Content-Type": "application/json",
                "X-AUTH-TOKEN": token
            ]
        }
    }
}


