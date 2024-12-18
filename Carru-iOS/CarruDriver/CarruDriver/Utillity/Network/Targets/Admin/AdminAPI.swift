//
//  AdminAPI.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Moya

enum AdminAPI {
    enum listType: Int {
        case driver = 0
        case owner = 1
    }
    
    // 미승인 유저 목록 조회
    case unApprovedUserList(type: listType)
    // 유저 가입 승인
    case userSignUpRegister(userId: Int)
    
    
    // 18. 미승인 물류 조회
    case unApprovedLogisticsList
    // 19. 물류 승인
    case approveLogistics(logisticId: Int)
    
    
    // 22. 승인된 물류 리스트 조회
    case approvedLogisticsList
    // 23. 물류 승인 리스트 상세 조회
    case approvedLogisticsDetail(logisticId: Int)
    
    // 24. 승인된 사용자 목록 조회
    case approvedUserList(type: listType)
    
    // 24-2. 화주의 승인된 목록 조회
    case ownerApprovedList(userId: Int)
    
    // 25. 관리자 - 화물기사 승인 목록 상세 조회(물류 매칭 목록 조회)
    case driverLogisticMatchingListDetail(userId: Int)
    
    // 26. 관리자 - 화물기사 승인 목록 상세 조회(경로 탐색 목록 조회)
    case driverRouteMatchingListDetail(userId: Int)
    
    // 27. 관리자 - 화물기사 승인 목록 상세 조회(화물기사의 물류 매칭 상세 조회)
    case driverLogisticMatchingDetail(logisticId: Int)
 
    // 28. 관리자 - 화물기사 승인 목록 상세 조회(화물기사의 경로 탐색 상세 조회)
    case driverRouteMatchingDetail(listId: Int)
}

extension AdminAPI: TargetType {
    var baseURL: URL {
        return InfoManager.carruServerBaseURL
    }
    
    var path: String {
        switch self {
        case .unApprovedUserList:
            return "/v1/manager/approvingList/user"
        case .userSignUpRegister(let userId):
            return "/v1/manager/approvingList/user/\(userId)"
        case .unApprovedLogisticsList:
            return "/v1/manager/approvingList/logistics"
        case .approveLogistics(let logisticId):
            return "/v1/manager/approvingList/logistics/\(logisticId)"
        case .approvedLogisticsList:
            return "/v1/manager/approvedList/logistics"
        case .approvedLogisticsDetail(let logisticId):
            return "/v1/manager/approvedList/logistics/\(logisticId)"
        case .approvedUserList:
            return "/v1/manager/approvedList/user"
        case .ownerApprovedList(let userId):
            return "/v1/manager/approvedList/owner/\(userId)"
        case .driverLogisticMatchingListDetail(let userId):
            return "/v1/manager/approvedList/driver/logisticsMatching/\(userId)"
        case .driverRouteMatchingListDetail(let userId):
            return "/v1/manager/approvedList/driver/routeMatching/\(userId)"
        case .driverLogisticMatchingDetail(logisticId: let logisticId):
            return "/v1/manager/approvedList/driver/logisticsMatchingDetail/\(logisticId)"
        case .driverRouteMatchingDetail(listId: let logisticId):
            return "/v1/manager/approvedList/driver/routeMatchingDetail/\(logisticId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .unApprovedUserList:
            return .get
        case .userSignUpRegister:
            return .patch
        case .unApprovedLogisticsList:
            return .get
        case .approveLogistics:
            return .patch
        case .approvedLogisticsList:
            return .get
        case .approvedLogisticsDetail:
            return .get
        case .approvedUserList:
            return .get
        case .ownerApprovedList:
            return .get
        case .driverLogisticMatchingListDetail:
            return .get
        case .driverRouteMatchingListDetail:
            return .get
        case .driverLogisticMatchingDetail:
            return .get
        case .driverRouteMatchingDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .unApprovedUserList(let listType):
            return .requestParameters(
                parameters: ["listType": listType.rawValue],
                encoding: URLEncoding.queryString
            )
        case .userSignUpRegister:
            return .requestPlain
        case .unApprovedLogisticsList:
            return .requestPlain
        case .approveLogistics:
            return .requestPlain
        case .approvedLogisticsList:
            return .requestPlain
        case .approvedLogisticsDetail:
            return .requestPlain
        case .approvedUserList(let type):
            return .requestParameters(
                parameters: ["listType": type.rawValue],
                encoding: URLEncoding.queryString
            )
        case .ownerApprovedList:
            return .requestPlain
        case .driverLogisticMatchingListDetail:
            return .requestPlain
        case .driverRouteMatchingListDetail:
            return .requestPlain
        case .driverLogisticMatchingDetail:
            return .requestPlain
        case .driverRouteMatchingDetail:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
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
