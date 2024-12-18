//
//  MainTabView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var path: [MainScreen] = []
    
    var body: some View {
        NavigationStack(path: $path) { 
            TabView {
                Tab {
                    FindRouteView(path: $path, viewModel: .init())
                } label: {
                    Label("경로탐색", systemImage: "location.circle.fill")
                }
                
                Tab {
                    MatchLogisticsView(path: $path, viewModel: .init())
                } label: {
                    Label("물류매칭", systemImage: "pencil.circle.fill")
                }
                
                Tab {
                    ReservationsView(path: $path, viewModel: .init())
                } label: {
                    Label("예약목록", systemImage: "envelope.fill")
                }
                
                Tab {
                    SettingView(path: $path, viewModel: .init())
                } label: {
                    Label("설정", systemImage: "person.fill")
                }
            }
            .navigationDestination(for: MainScreen.self) { screen in
                switch screen {
                case .suggestRoutes(let routePredicts):
                    RouteListView(path: $path, viewModel: .init(routePredict: routePredicts))
                case .matchedLogistics(let maxWeight, let minWeight):
                    MatchedRouteListView(
                        path: $path,
                        viewModel: .init(
                            maxWeight: maxWeight,
                            minWeight: minWeight
                        )
                    )
                case .matchedLogisticsMap(let id):
                    MatchedRouteMapView(
                        path: $path,
                        viewModel: .init(id: id)
                    )
                    .navigationBarHidden(true)
                case .suggestMap(let routePredict):
                    SuggestRouteMapView(
                        path: $path,
                        viewModel: .init(routePredict: routePredict)
                    )
                        .navigationBarHidden(true)
                case .reservationMap(let reservation, let type):
                    logisticMatchReservationMapView(
                        path: $path,
                        viewModel: .init(productID: reservation.listId),
                        mapType: type
                    )
                    .navigationBarHidden(true)
                case .routeMatchingReservationMapView(let reservation, let type):
                    RouteMatchReservationMapView(
                        path: $path,
                        viewModel: .init(reservation: reservation),
                        mapType: type
                    )
                    .navigationBarHidden(true)
                default:
                    DefaultView()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
