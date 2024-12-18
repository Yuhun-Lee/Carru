//
//  KakaoMapCoordinator+moveCamera.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import KakaoMapsSDK

// MARK: - 카메라 이동 조정
extension KakaoMapCoordinator {
    /// 한 포인트를 기준으로 카메라 이동
    func moveCameraByMapPoint(mapPoint: MapPoint) {
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        
        kakaoMapView.animateCamera(
            cameraUpdate: .make(
                target: mapPoint,
                zoomLevel: 12,
                mapView: kakaoMapView
            ),
            options: .init(
                autoElevation: true,
                consecutive: true,
                durationInMillis: 700
            )
        )
    }
    
    /// 여러 포인트를 기준으로 카메라 이동
    func moveCameraByMapPoints(mapPoints: [MapPoint]) {
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        
        let cameraUpdate = CameraUpdate.make(area: AreaRect(points: mapPoints))
        
        kakaoMapView.animateCamera(
            cameraUpdate: cameraUpdate,
            options: .init(
                autoElevation: true,
                consecutive: true,
                durationInMillis: 700
            )
        )
    }
}
