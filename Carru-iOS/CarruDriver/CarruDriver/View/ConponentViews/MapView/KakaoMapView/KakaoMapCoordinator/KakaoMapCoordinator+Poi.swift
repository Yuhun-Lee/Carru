//
//  KakaoMapCoordinator+Poi.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//
import Foundation
import KakaoMapsSDK

// MARK: - Poi Control 추가
extension KakaoMapCoordinator {
    /// 내 위치 Poi 추가
    func addMyLocationPoi(myMapPoint: MapPoint, moveCamera: Bool = false) {
        Task {
            await createLabelLayer(layerID: CoordNames.myLocation, zOrder: 2)
            await createDefaultPoiStyle()
            await createDefaultPois(layerID: CoordNames.myLocation,  locaiton: myMapPoint)
            if moveCamera { moveCameraByMapPoint(mapPoint: myMapPoint) }
        }
    }
    
    /// 여러 위치 Poi 추가
    func makeAndShowLogisticsPoi(mapPoints: [MapPoint], moveCameraMapPoints: [MapPoint]? = nil) {
        Task {
            await createLabelLayer(layerID: CoordNames.logisticsLayer, zOrder: 1)
            await createLogisticsPoiStyle()
            await createPois(layerID: CoordNames.logisticsLayer, mapPoints: mapPoints)
            if let moveCameraMapPoints {
                moveCameraByMapPoints(mapPoints: moveCameraMapPoints)
            }
        }
    }
    
    /// Poi생성을 위한 LabelLayer 생성
    @MainActor
    private func createLabelLayer(layerID: String, zOrder: Int) async {
        logger.printOnDebug("\(layerID) 레이어 추가")
        
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        let manager = kakaoMapView.getLabelManager()
        
        let layerOption = LabelLayerOptions(
            layerID: layerID,
            competitionType: .none,
            competitionUnit: .symbolFirst,
            orderType: .rank,
            zOrder: zOrder
        )
        
        manager.removeLabelLayer(layerID: layerID)
        let _ = manager.addLabelLayer(option: layerOption)
    }
    
    /// 기본 스타일 생성 (내 위치에 사용할 것)
    private func createDefaultPoiStyle() async {
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        let manager = kakaoMapView.getLabelManager()
        
        let iconStyleFrom6 = PoiIconStyle(
            symbol: UIImage(
                systemName: "location.fill"
            )?.withTintColor(.appTypeColor),
            anchorPoint: CGPoint(x: 0.5, y: 0.5)
        )
        
        let poiStyle = PoiStyle(
            styleID: CoordNames.defaultStyle,
            styles: [PerLevelPoiStyle(
                iconStyle: iconStyleFrom6,
                level: 6
            )]
        )
        
        manager.addPoiStyle(poiStyle)
    }
    
    /// 기본(내 위치) Poi 생성
    @MainActor
    private func createDefaultPois(layerID: String, locaiton: MapPoint) async {
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        let manager = kakaoMapView.getLabelManager()
        
        let poiOptions = PoiOptions(styleID: CoordNames.defaultStyle)
        poiOptions.rank = 0
        
        let layer = manager.getLabelLayer(layerID: layerID)
        let poi = layer?.addPoi(option: poiOptions, at: locaiton)
        
        poi?.show()
    }
    
    
    /// Logistics Poi 표시 스타일 생성
    private func createLogisticsPoiStyle() async {
        logger.printOnDebug("Logistics POI 스타일 추가")
        
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        
        let manager = kakaoMapView.getLabelManager()
        
        // 여기서부턴 시작 물류 아이콘
        
        let departureIcon = PoiIconStyle(
            symbol: UIImage(
                systemName: "truck.box.fill"
            )?.withTintColor(.appTypeColor),
            anchorPoint: CGPoint(
                x: 0.5,
                y: 0.5
            )
        )
        
        let departureStyle = PoiStyle(styleID: MapPinStyle.departureLogisticStyle, styles: [
            PerLevelPoiStyle(iconStyle: departureIcon, level: 6)
        ])
        
        manager.addPoiStyle(departureStyle)
        
        // 여기서부턴 기본 아이콘
        
        let iconStyleFrom6 = PoiIconStyle(
            symbol: UIImage(
                systemName: "truck.box.fill"
            )?.withTintColor(.black),
            anchorPoint: CGPoint(
                x: 0.5,
                y: 0.5
            )
        )
        
        var iconStyleFrom12: PoiIconStyle
        
        iconStyleFrom12 = PoiIconStyle(
            symbol: UIImage(
                systemName: "truck.box.fill"
            )?.withTintColor(.black),
            anchorPoint: CGPoint(x: 0.5, y: 0.5)
        )
        
        // 6~, 12~ 표출 스타일을 지정
        let poiStyle = PoiStyle(styleID: MapPinStyle.logisticStyle, styles: [
            PerLevelPoiStyle(iconStyle: iconStyleFrom6, level: 6),
            PerLevelPoiStyle(iconStyle: iconStyleFrom12, level: 12)
        ])
        
        manager.addPoiStyle(poiStyle)
    }
    
    /// 지도에 Poi 생성
    @MainActor
    private func createPois(layerID: String, mapPoints: [MapPoint]) async {
        logger.printOnDebug("Logistics POI 표시")
        
        var poisOptions: [PoiOptions] = []
        var poiMapPoints: [MapPoint] = []
        
        
        for i in 0..<mapPoints.count {
            let mapPoint = mapPoints[i]
            
            var poiOptions = PoiOptions(styleID: MapPinStyle.logisticStyle)
            
            if i == 0 {
                poiOptions = PoiOptions(styleID: MapPinStyle.departureLogisticStyle)
            }
            
            poiOptions.rank = 0
            
            poisOptions.append(poiOptions)
            poiMapPoints.append(mapPoint)
        }
        
        guard let kakaoMapView = controller?.getView(CoordNames.mapView) as? KakaoMap else { return }
        
        let manager = kakaoMapView.getLabelManager()
        
        let layer = manager.getLabelLayer(layerID: layerID)
        let pois = layer?.addPois(options: poisOptions, at: poiMapPoints)
        
        guard let pois else { return }
        
        for poi in pois {
            poi.show()
        }
    }
}
