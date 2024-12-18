//
//  OwnerAPI.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation
import Moya

enum OwnerAPI {
    // 물류 등록
    case registerLogistics(request: RegisterLogisticsRequestDTO)
    
    // 창고 리스트 검색
    case searchWarehouseList(keyword: String)
    
    // 21. 미승인 물류 리스트 조회
    case unapprovedLogisticsList
    
    // 22.미승인 물류 상세조회
    case unapprovedLogisticDetail(logisticId: Int)
    
    // 미승인 물류 수정
    case fixUnapprovedLogistic(logisticId: Int, request: FixDeleteUnapprovedLogisticRequestDTO)
    
    // 미승인 물류 삭제
    case deleteUnapprovedLogistic(logisticId: Int, request: FixDeleteUnapprovedLogisticRequestDTO)
    
    // 승인된 물류 리스트 조회
    case approvedLogisticsList(type: ProgressType)
    
    // 승인된 물류 상세 조회
    case approvedLogisticDetail(logisticId: Int, type: ProgressType)
}


extension OwnerAPI: TargetType {
    var baseURL: URL {
        return InfoManager.carruServerBaseURL
    }
    
    var path: String {
        switch self {
        case .registerLogistics:
            return "/v1/shipper/logistics"
        case .searchWarehouseList:
            return "/v1/shipper/search"
        case .unapprovedLogisticsList:
            return "/v1/shipper/logistics/pending"
        case .unapprovedLogisticDetail(let logisticId):
            return "/v1/shipper/logistics/pending/\(logisticId)"
        case .fixUnapprovedLogistic(let logisticId, _):
            return "/v1/shipper/logistics/pending/\(logisticId)"
        case .deleteUnapprovedLogistic(let logisticId, _):
            return "/v1/shipper/logistics/pending/\(logisticId)"
        case .approvedLogisticsList:
            return "/v1/shipper/logistics/approved"
        case .approvedLogisticDetail(let logisticId, _):
            return "/v1/shipper/logistics/approved/\(logisticId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .registerLogistics:
            return .post
        case .searchWarehouseList:
            return .get
        case .unapprovedLogisticsList:
            return .get
        case .unapprovedLogisticDetail:
            return .get
        case .fixUnapprovedLogistic:
            return .put
        case .deleteUnapprovedLogistic:
            return .delete
        case .approvedLogisticsList:
            return .get
        case .approvedLogisticDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .registerLogistics(let request):
            return .requestJSONEncodable(request)
        case .searchWarehouseList(keyword: let keyword):
            return .requestParameters(
                parameters: ["keyword": keyword],
                encoding: URLEncoding.queryString
            )
        case .unapprovedLogisticsList:
            return .requestPlain
        case .unapprovedLogisticDetail:
            return .requestPlain
        case .fixUnapprovedLogistic(_, let request):
            return .requestJSONEncodable(request)
        case .deleteUnapprovedLogistic(_, let request):
            return .requestJSONEncodable(request)
        case .approvedLogisticsList(let type):
            return .requestParameters(
                parameters: ["listType" : type.statusID],
                encoding: URLEncoding.queryString
            )
        case .approvedLogisticDetail(_, let type):
            return .requestParameters(
                parameters: ["listType" : type.statusID],
                encoding: URLEncoding.queryString
            )
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

