//
//  AddressAPI.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import Moya

enum AddressAPI {
    // 검색 키워드로 주소 검색
    case searchAddress(keyword: String)
    
    // 도로명 주소를 통해 좌표 가져오기
    case getPointFromAddress(address: String)
}

extension AddressAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .searchAddress:
            return InfoManager.addressSearchBaseURL
        case .getPointFromAddress:
            return InfoManager.geoCoderBaseURL
        }
    }
    
    var path: String {
        switch self {
        case .searchAddress:
            return ""
        case .getPointFromAddress:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchAddress:
            return .get
        case .getPointFromAddress:
            return .get            
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .searchAddress(keyword: let keyword):
            return .requestParameters(
                parameters: [
                    "firstSort": "road",
                    "resultType": "json",
                    "currentPage": "1",
                    "countPerPage": "20",
                    "confmKey" : InfoManager.addressAPIKey,
                    "keyword": keyword
                ],
                encoding: URLEncoding.queryString
            )
        case .getPointFromAddress(address: let address):
            return .requestParameters(
                parameters: [
                    "service": "address",
                    "request": "getcoord",
                    "type": "road",
                    "key": InfoManager.geoCoderAPIKey,
                    "address": address
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
