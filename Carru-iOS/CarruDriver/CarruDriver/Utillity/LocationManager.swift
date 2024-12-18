//
//  LocationManager.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    let locationAuthStatusPublisher = PassthroughSubject<Bool, Never>()
    
    var myLocation: Location {
        guard let location = locationManager.location?.coordinate else {
            logger.printOnDebug("내 위치 잡지 못함")
            return .init(latitude: 37.395866, longitude: 127.110497)
        }
        
        return Location(
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            logger.printOnDebug("사용중 위치 허용")
            manager.requestLocation()
            locationAuthStatusPublisher.send(true)
        case .authorizedAlways:
            logger.printOnDebug("항상 위치 허용")
            manager.requestLocation()
            locationAuthStatusPublisher.send(true)
        case .restricted:
            logger.printOnDebug("위치 제한됨")
        case .denied:
            logger.printOnDebug("위치 거부됨")
            locationAuthStatusPublisher.send(true)
        case .notDetermined:
            logger.printOnDebug("위치 권한 결정되지 않음")
            locationAuthStatusPublisher.send(true)
            manager.requestWhenInUseAuthorization() // 권한 요청
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        logger.printOnDebug("코어 로케이션 위치 변경")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.printOnDebug("error: \(error.localizedDescription)")
    }
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
}

