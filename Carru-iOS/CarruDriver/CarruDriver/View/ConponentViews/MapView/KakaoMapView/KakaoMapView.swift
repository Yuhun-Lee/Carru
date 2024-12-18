//
//  KakaoMapViewController.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import UIKit
import SwiftUI
import KakaoMapsSDK
import CoreLocation
import Combine

struct KakaoMapView: UIViewRepresentable {
    enum ShowPoiType {
        /// 내 위치 보여주기
        case showMyLocation
        /// 물류 하나일 때, 내위치, 출발->도착 보여주기
        case showMatchedLogisticAndMyLocation
        /// 물류 하나의 출발->도착 보여주기
        case showMatchedLogistic
        /// 물류 여러개와 내 위치, 출발->도착 보여주기
        case showLogisticsPointsAndMyLocation
        /// 물류 여러개의 출발->도착 보여주기
        case showLogisticsPoints
        /// 암것도 하지 않기
        case nothing
    }
    
    @Binding var draw: Bool
    @Binding var logistics: [LogisticMapData]?
    @Binding var currentLocation: Location
    @Binding var showPoiType: ShowPoiType
    @Binding var updateUIEvent: Bool
    @State var cancellables = Set<AnyCancellable>()
    
    var myMapPoint: MapPoint {
        MapPoint(
            longitude: currentLocation.longitude,
            latitude: currentLocation.latitude
        )
    }
    
    /// UIView를 상속한 KMViewContainer를 생성한다.
    /// 뷰 생성과 함께 KMControllerDelegate를 구현한 Coordinator를 생성하고, 엔진을 생성 및 초기화한다.
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        
        DispatchQueue.main.async{
            logger.printOnDebug("엔진 준비")
            context.coordinator.controller?.prepareEngine()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
//        guard context.coordinator.isViewAddedSubject.value else {
//            logger.printOnDebug("뷰 추가 안됨")
//            return
//        }
        
        if draw {
            DispatchQueue.main.async {
                context.coordinator.controller?.activateEngine()
            }
        } else {
            logger.printOnDebug("엔진 비활성화하자")
            context.coordinator.controller?.resetEngine()
        }
        
        logger.printOnDebug("🍋 지도 업데이트 UI - \(showPoiType)")
        
        switch showPoiType {
        case .showMyLocation:
            showMyLocation(context: context)
            
        case .showMatchedLogisticAndMyLocation:
            showMatchedLogisticAndMyLocation(context: context)
        
        case .showMatchedLogistic:
            showMatchedLogisticAndMyLocation(context: context, isShowMyLocation: false)
            
        case .showLogisticsPointsAndMyLocation:
            showLogisticsAndMyLocation(context: context)
        
        case .showLogisticsPoints:
            showLogisticsAndMyLocation(context: context, isShowMyLocation: false)
            
        case .nothing:
            break
        }
        
        if showPoiType != .nothing {
            DispatchQueue.main.async {
                showPoiType = .nothing
            }
        }
    }
    
    /// Coordinator 생성
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        logger.printOnDebug("dismantleUIView 호출!")
    }
}

extension KakaoMapView {
    /// 내 위치 표시 및 카메라 이동
    private func showMyLocation(context: Self.Context) {
        context.coordinator.addMyLocationPoi(myMapPoint: myMapPoint, moveCamera: true)
    }
    
    private func showMatchedLogisticAndMyLocation(context: Self.Context, isShowMyLocation: Bool = true) {
        guard let logistic = logistics?.first else {
            logger.printOnDebug("보여줄 물류 없음")
            showMyLocation(context: context)
            return
        }
        
        let departure = logistic.location.toMapPoint()
        let destination = logistic.destLocation.toMapPoint()
        
        
        if isShowMyLocation {
            // 내 위치 표시
            context.coordinator.addMyLocationPoi(myMapPoint: myMapPoint)
        }
        
        // 출발 -> 도착 표시
        context.coordinator.makeAndShowLogisticsPoi(mapPoints: [departure, destination])
        // 폴리라인
        context.coordinator.makeAndShowPolyLine(mapPoints: [departure, destination])
        
        if isShowMyLocation {
            // 카메라 이동
            context.coordinator.moveCameraByMapPoints(mapPoints: [myMapPoint, departure, destination])
        } else {
            context.coordinator.moveCameraByMapPoints(mapPoints: [departure, destination])
        }
    }
    
    private func showLogisticsAndMyLocation(context: Self.Context, isShowMyLocation: Bool = true) {
        guard let logistics else {
            logger.printOnDebug("보여줄 물류 없음")
            showMyLocation(context: context)
            return
        }
        
        if isShowMyLocation {
            // 내 위치 표시
            context.coordinator.addMyLocationPoi(myMapPoint: myMapPoint)
        }
        
        var mapPoints: [MapPoint] = []
        
        for i in 0..<logistics.count {
            let logistic = logistics[i]
            
            if i == logistics.count - 1 {
                mapPoints.append(
                    .init(
                        longitude: logistic.destinationLongitude,
                        latitude: logistic.destinationLatitude
                    )
                )
            } else {
                mapPoints.append(
                    .init(
                        longitude: logistic.departureLongitude,
                        latitude: logistic.departureLatitude
                    )
                )
            }
        }
        
        // 폴리라인
        context.coordinator.makeAndShowPolyLine(mapPoints: mapPoints)
        // 출발 -> 도착 표시
        context.coordinator.makeAndShowLogisticsPoi(mapPoints: mapPoints)
        // 카메라 이동
        context.coordinator.moveCameraByMapPoints(mapPoints: [myMapPoint] + mapPoints)
    }
    
    /// Location 위치 표시 및 카메라 이동
    private func showTargetLocations(context: Self.Context) {
        guard let logistics else {
            logger.printOnDebug("위치 보여주기 실패 - 물류 없음")
            return
        }
        let logisticMapPoints = logistics.map { $0.location.toMapPoint() }
        let movecameraMapPoints = [myMapPoint] + logisticMapPoints
        
        context.coordinator.addMyLocationPoi(myMapPoint: myMapPoint)
        context.coordinator.makeAndShowLogisticsPoi(
            mapPoints: logisticMapPoints,
            moveCameraMapPoints: movecameraMapPoints
        )
    }
    
    /// 내 위치 다시 찍고, 경로 추가, 카메라 이동
    private func findAndShowLocationsRoute(context: Self.Context) {
        guard let logistics else { return }
        let myMapPoint = myMapPoint
        
        let targetMapPoints = [myMapPoint] + logistics.map { $0.location.toMapPoint() }
        
        context.coordinator.addMyLocationPoi(myMapPoint: myMapPoint)
        context.coordinator.makeAndShowPolyLine(mapPoints: targetMapPoints, moveCamera: true)
    }
}
