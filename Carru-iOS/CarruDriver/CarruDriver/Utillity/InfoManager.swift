//
//  InfoManager.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation

struct InfoManager {
    private enum ConfigKey {
        static let kakaoMapAPIKey = "KAKAO_MAP_API_KEY"
        static let kakaoMapOWnerAPIKey = "KAKAO_MAP_OWNER_API_KEY"
        static let kakaoMapAdminAPIKey = "KAKAO_MAP_ADMIN_API_KEY"
        
        static let geoCoderAPIKey = "GEO_CODER_API_KEY"
        static let addressSearchAPIKey = "ADDRESS_SEARCH_API_KEY"
        
        static let carruServerBaseURL = "CARRU_SERVER_BASE_URL"
        static let carruAIServerBaseURL = "CARRU_AI_SERVER_BASE_URL"
        
        static let geoCoderBaseURL = "GEO_CODER_BASE_URL"
        static let addressSearchBaseURL = "ADDRESS_SEARCH_BASE_URL"
    }
    
    private static let infoDic: [String: Any] = {
        guard let infoDic = Bundle.main.infoDictionary else {
            fatalError("info.plist 확인 필요")
        }
        return infoDic
    }()
    
    static let carruServerBaseURL: URL = {
        guard
            let urlString = infoDic[ConfigKey.carruServerBaseURL] as? String,
            let url = URL(string: urlString)
        else {
            logger.printOnDebug("Carru Server Base URL 확인 필요")
            fatalError("Carru Server Base URL 확인 필요")
        }
        return url
    }()
    
    static let carruAIServerBaseURL: URL = {
        guard
            let urlString = infoDic[ConfigKey.carruAIServerBaseURL] as? String,
            let url = URL(string: urlString)
        else {
            logger.printOnDebug("Carru AI Server Base URL 확인 필요")
            fatalError("Carru Server Base URL 확인 필요")
        }
        return url
    }()
    
    static let kakaoMapAPIKey: String = {
        var apiKey: String = ConfigKey.kakaoMapAPIKey
        
        // 앱 번들아이디 분리시 활성화 필요.
        
        switch appType {
        case .driver:
            apiKey = ConfigKey.kakaoMapAPIKey
        case .owner:
            apiKey = ConfigKey.kakaoMapOWnerAPIKey
        case .admin:
            apiKey = ConfigKey.kakaoMapAdminAPIKey
        }
                
        guard let key = infoDic[apiKey] as? String
        else {
            logger.printOnDebug("카카오맵 API Key 확인 필요")
            return ""
        }
        
        return key
    }()
    
    static let geoCoderAPIKey: String = {
        guard let key = infoDic[ConfigKey.geoCoderAPIKey] as? String
        else {
            logger.printOnDebug("GeoCoder API Key 확인 필요")
            return ""
        }
        return key
    }()
    
    static let geoCoderBaseURL: URL = {
        guard
            let urlString = infoDic[ConfigKey.geoCoderBaseURL] as? String,
            let url = URL(string: urlString)
        else {
            fatalError("geoCoderBaseURL 확인 필요")
        }
        return url
    }()
    
    static let addressAPIKey: String = {
        guard let key = infoDic[ConfigKey.addressSearchAPIKey] as? String
        else {
            logger.printOnDebug("Address Search API Key 확인 필요")
            return ""
        }
        return key
    }()
    
    static let addressSearchBaseURL: URL = {
        guard
            let urlString = infoDic[ConfigKey.addressSearchBaseURL] as? String,
            let url = URL(string: urlString)
        else {
            fatalError("Address Search Base URL 확인 필요")
        }
        return url
    }()
}
