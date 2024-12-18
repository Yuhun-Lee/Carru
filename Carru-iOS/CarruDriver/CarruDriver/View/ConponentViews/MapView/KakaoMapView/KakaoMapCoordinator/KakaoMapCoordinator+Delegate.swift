//
//  KakaoMapCoordinator+Delegate.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import KakaoMapsSDK

// MARK: - Delegate 이벤트
extension KakaoMapCoordinator: MapControllerDelegate {
    
    func addViews() {
        logger.printOnDebug("뷰 추가")
        let location = LocationManager.shared.myLocation
        
        // 지도 기본 위치 설정
        let defaultPosition: MapPoint = MapPoint(
            longitude: location.longitude,
            latitude: location.latitude
        )
        
        // 맵뷰 깔기
        let mapviewInfo: MapviewInfo = MapviewInfo(
            viewName: CoordNames.mapView,
            viewInfoName: "map",
            defaultPosition: defaultPosition
        )
        
        // 맵뷰 추가
        controller?.addView(mapviewInfo)
    }
    
    ///addView 성공 이벤트 delegate. 추가적으로 수행할 작업을 진행한다.
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        logger.printOnDebug("\(viewName)뷰 추가 성공")
        
        // 뷰 추가 확인 및 로고 정책 준수
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        isViewAddedSubject.send(true)
        
        kakaoMapView.setLogoPosition(
            origin: GuiAlignment(
                vAlign: .top,
                hAlign: .left
            ),
            position: CGPoint(x: 2.0, y: 2.0)
        )
    }
    
    /// addView 실패 이벤트 delegate. 실패에 대한 오류 처리를 진행한다.
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        logger.printOnDebug("뷰 추가 실패")
    }
    
    /// KMViewContainer 리사이징 될 때 호출.
    func containerDidResized(_ size: CGSize) {
        logger.printOnDebug("뷰 리사이징")
    }
}
