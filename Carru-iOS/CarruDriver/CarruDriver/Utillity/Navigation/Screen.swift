//
//  Screen.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//


import SwiftUI

enum SignScreen: Hashable {
    case signIn
    case signUp
    case address
}


enum MainScreen: Hashable {
    case mainTab
    
    case findRoute
    case matchLogistics
    case reservations
    case setting
    
    case address(title: String)
    case suggestRoutes(routePredicts: [RoutePredict])
    case matchedLogistics(maxWeight: Int, minWeight: Int)
    
    case matchedLogisticsMap(id: Int)
    case suggestMap(routes: RoutePredict)
    case reservationMap(reservation: LogisticReservation , type: ReservationsViewModel.ProcessSegment)
    case routeMatchingReservationMapView(reservation: RouteReservation, type: ReservationsViewModel.ProcessSegment)
    
    
    
    // 관리자에서만 사용
    case adminTotalLogisticAndOwnerMapView(logisticId: Int)
    case adminTotalDriverMatchedLogisticMapView(logisticId: Int)
    case adminTotalDriverRouteLogisticMapView(listId: Int)
    case adminOwnerApprovedLogisticsView(ownerId: Int)
    case adminDriverApprovedLogisticsView(driverId: Int)
    
    /// 화주에서만 사용
    case unApprovedLogisticMapView(logisticId: Int)
    case ownerLogisticsApprovedMapView(logisticId: Int, progressType: ProgressType)
    case editLogisticView(logisticId: Int)
}
