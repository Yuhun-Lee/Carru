//
//  KakaoMapCoordinator+PolyLine.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//
import Foundation
import KakaoMapsSDK

// MARK: - 폴리라인 추가
extension KakaoMapCoordinator {
    /// 포인트 연결 폴리라인 추가 및 카메라 이동(옵션)
    func makeAndShowPolyLine(mapPoints: [MapPoint], moveCamera: Bool = false) {
        Task {
            await createPolylineStyleSet()
            await createPolylineShape(mapPoints: mapPoints)
            if moveCamera { moveCameraByMapPoints(mapPoints: mapPoints) }
        }
    }
    
    /// 스타일셋 생성: 12 기준으로 색 다르게
    private func createPolylineStyleSet() async {
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        let manager = kakaoMapView.getShapeManager()
        
        manager.removeShapeLayer(layerID: CoordNames.polylineLayer)
        let _ = manager.addShapeLayer(layerID: CoordNames.polylineLayer, zOrder: 10001)
        
        
        let polylineStyle = PolylineStyle(
            styles: [
                PerLevelPolylineStyle(
                    bodyColor: UIColor.appTypeColor,
                    bodyWidth: 5,
                    strokeColor: UIColor.red,
                    strokeWidth: 0,
                    level: 0
                )
//                ,
//                PerLevelPolylineStyle(
//                    bodyColor: UIColor.blue,
//                    bodyWidth: 8,
//                    strokeColor: UIColor.green,
//                    strokeWidth: 0,
//                    level: 12
//                )
            ]
        )
        
        manager.addPolylineStyleSet(PolylineStyleSet(styleSetID: CoordNames.polylineStyleSet, styles: [polylineStyle]))
    }
    
    /// 폴리라인 그리기
    @MainActor
    private func createPolylineShape(mapPoints: [MapPoint]) async {
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        let manager = kakaoMapView.getShapeManager()
        
        let layer = manager.getShapeLayer(layerID: CoordNames.polylineLayer)
        
        let mapPolyLine = MapPolyline(line: mapPoints, styleIndex: 0)
        let options = MapPolylineShapeOptions(
            shapeID: "LogisticsPolyLines",
            styleID: CoordNames.polylineStyleSet,
            zOrder: 1
        )
        options.polylines = [mapPolyLine]
        
        let polyline = layer?.addMapPolylineShape(options)
        polyline?.show()
    }
}
