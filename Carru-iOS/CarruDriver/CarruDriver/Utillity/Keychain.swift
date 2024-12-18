//
//  Keychain.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

enum KeychainError: Error {
    case encodingFailed
    case decodingFailed
    case notFound
    case unhandledError(status: OSStatus)
}

struct Keychain {
    //    static let shared = Keychain()
    
    enum TokenKind: String {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
    private init() {}
    
    static func addToken(kind: Keychain.TokenKind, token: String) throws {
        guard let saveToken = token.data(using: .utf8) else { throw KeychainError.encodingFailed }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: InfoManager.carruServerBaseURL.absoluteString,
            kSecValueData as String: saveToken
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status)}
    }
    
    static func addOrUpdateToken(kind: Keychain.TokenKind, token: String) throws {
        guard let saveToken = token.data(using: .utf8) else {
            throw KeychainError.encodingFailed
        }
        
        // 공통 쿼리 (키체인 항목을 식별하기 위한 기본 정보)
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: InfoManager.carruServerBaseURL.absoluteString
        ]
        
        // 이미 존재하는 항목인지 확인
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            // 항목이 이미 존재하면 업데이트
            let attributes: [String: Any] = [
                kSecValueData as String: saveToken
            ]
            let updateStatus = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            guard updateStatus == errSecSuccess else {
                throw KeychainError.unhandledError(status: updateStatus)
            }
        } else if status == errSecItemNotFound {
            // 항목이 존재하지 않으면 추가
            var newQuery = query
            newQuery[kSecValueData as String] = saveToken
            
            let addStatus = SecItemAdd(newQuery as CFDictionary, nil)
            guard addStatus == errSecSuccess else {
                throw KeychainError.unhandledError(status: addStatus)
            }
        } else {
            // 예상치 못한 에러 처리
            throw KeychainError.unhandledError(status: status)
        }
    }

    
    static func searchToken(kind: Keychain.TokenKind) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: InfoManager.carruServerBaseURL.absoluteString,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.notFound }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard
            let existingItem = item as? [String : Any],
            let savedToken = existingItem[kSecValueData as String] as? Data,
            let tokenString = String(data: savedToken, encoding: .utf8)
        else {
            throw KeychainError.decodingFailed
        }
        
        return tokenString
    }
    
    static func updateToken(kind: Keychain.TokenKind, newToken: String) throws {
        guard let token = newToken.data(using: .utf8) else { throw KeychainError.encodingFailed }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: InfoManager.carruServerBaseURL.absoluteString
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: token
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.notFound }
        guard status == errSecSuccess else { throw  KeychainError.unhandledError(status: status) }
    }
    
    static func deleteToken(kind: Keychain.TokenKind) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrType as String : kind.rawValue,
            kSecAttrServer as String: InfoManager.carruServerBaseURL.absoluteString
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}




extension KeychainError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingFailed:
            return NSLocalizedString("토큰 디코딩 에러", comment: "")
        case .encodingFailed:
            return NSLocalizedString("토큰 인코딩 에러", comment: "")
        case .notFound:
            return NSLocalizedString("토큰을 찾을 수 없습니다.", comment: "")
        case .unhandledError(let status):
            return NSLocalizedString("예상치 못한 에러: \(status)", comment: "")
        }
    }
}
