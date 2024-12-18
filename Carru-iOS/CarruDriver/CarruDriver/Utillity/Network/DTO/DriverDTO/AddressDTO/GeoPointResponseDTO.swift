//
//  GeoPointDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation

struct GeoPointResponseDTO: Decodable {
    let response: Response
    
    struct Response: Decodable {
//        let service: Service
//        let status: String
//        let input: Input
//        let refined: Refined
        let result: Result
        
//        struct Service: Decodable {
//            let name: String
//            let version: String
//            let operation: String
//            let time: String
//        }
//        
//        struct Input: Decodable {
//            let type: String
//            let address: String
//        }
//        
//        struct Refined: Decodable {
//            let text: String
//            let structure: Structure
//            
//            struct Structure: Decodable {
//                let level0: String
//                let level1: String
//                let level2: String
//                let level3: String
//                let level4L: String
//                let level4LC: String
//                let level4A: String
//                let level4AC: String
//                let level5: String
//                let detail: String
//            }
//        }
        
        struct Result: Decodable {
            let crs: String
            let point: Point
            
            struct Point: Decodable {
                let x: String
                let y: String
            }
        }
    }
    
    // 위도와 경도를 추출하는 메서드
    func toLocation() -> Location? {
        guard
            let latitude = Double(response.result.point.y),
            let longitude = Double(response.result.point.x)
        else {
            return nil
        }
        
        return Location(latitude: latitude, longitude: longitude)
    }
}
