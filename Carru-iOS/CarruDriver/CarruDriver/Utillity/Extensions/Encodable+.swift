//
//  Encodable+.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            // 객체를 JSON 데이터로 인코딩
            let data = try JSONEncoder().encode(self)
            // JSON 데이터를 딕셔너리로 변환
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonObject as? [String: Any]
        } catch {
            logger.printOnDebug("Request의 toDictionary 실패: \(error)")
            return nil
        }
    }
}
