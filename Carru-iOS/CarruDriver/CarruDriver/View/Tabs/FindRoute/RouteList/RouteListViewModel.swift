//
//  RouteListViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation

@Observable
class RouteListViewModel {    
    var routes: [RoutePredict]
    
    init(routePredict: [RoutePredict]) {
        self.routes = routePredict
    }
}
