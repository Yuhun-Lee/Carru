//
//  BaseRepository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation
import Moya

protocol BaseRepository {
    func decodeResponse<T: Decodable>(
        _ type: T.Type,
        from response: Response
    ) throws -> T
}

extension BaseRepository {
    
    /// 디코딩, 및 에러 확인 등 체크
    @discardableResult
    func decodeResponse<T: Decodable>(
        _ type: T.Type,
        from response: Response
    ) throws -> T {
        do {
            if response.statusCode == 200 {
                // 성공 케이스: 요청한 타입으로 디코딩
                logger.printDataToJson(response.data)
                return try JSONDecoder().decode(T.self, from: response.data)
            } else {
                // 에러 케이스: CommonErrorResponse로 디코딩하여 에러 생성
                let errorResponse = try JSONDecoder().decode(
                    CommonErrorResponse.self,
                    from: response.data
                )
                throw NSError(
                    domain: "APIError",
                    code: response.statusCode,
                    userInfo: [
                        NSLocalizedDescriptionKey: "\(errorResponse.resultCode): \(errorResponse.message)"
                    ]
                )
            }
        } catch {
            logger.printOnDebug("디코딩 실패 에러: \(error)")
            
            throw error // 에러를 다시 던짐
        }
    }

}
