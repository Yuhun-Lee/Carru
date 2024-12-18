//
//  KakaoMapCoordinator.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import KakaoMapsSDK
import CoreLocation
import SwiftUI
import Combine


class KakaoMapCoordinator: NSObject {
    enum CoordNames {
        static let mapView = "MapView"
        static let myLocation = "MyLocation"
        static let logisticsLayer = "LogisticsLayer"
        static let polylineLayer = "PolylineLayer"
        static let polylineStyleSet = "polylineStyleSet"
        static let defaultStyle = "Default"
    }
    
    enum MapPinStyle {
        static let defaultStyle = "DefualtStyle"
        static let truck = "Truck"
        static let logisticStyle = "LogisticStyle"
        static let departureLogisticStyle = "DepartureLogisticStyle"
    }
    
    var controller: KMController?
    let isViewAddedSubject = CurrentValueSubject<Bool, Never>(false)
    
    override init() {
        super.init()
    }
    
    // KMController 객체 생성 및 event delegate 지정
    func createController(_ view: KMViewContainer) {
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
}
