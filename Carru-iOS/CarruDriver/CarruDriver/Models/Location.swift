//
//  Coordinate.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import CoreLocation
import KakaoMapsSDK

// 위도와 경도만 담는 모델
struct Location: Hashable {
    let latitude: Double
    let longitude: Double
    
    func toMapPoint() -> MapPoint {
        MapPoint(longitude: longitude, latitude: latitude)
    }
}
