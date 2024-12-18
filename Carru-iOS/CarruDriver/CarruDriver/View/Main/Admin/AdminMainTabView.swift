//
//  AdminMainTabView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import SwiftUI

struct AdminMainTabView: View {
    @State private var path: [MainScreen] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                Tab {
                    UserRegisterApproveView(path: $path, viewModel: .init())
                } label: {
                    Label("가입 승인", systemImage: "pencil.circle.fill")
                }
                
                Tab {
                    AdminApproveLogisticView(path: $path, viewModel: .init())
                } label: {
                    Label("물류 승인", systemImage: "envelope.fill")
                }
                
                Tab {
                    AdminTotalListView(path: $path, viewModel: .init())
                } label: {
                    Label("목록", systemImage: "person.fill")
                }
                
                Tab {
                    SettingView(path: $path, viewModel: .init())
                } label: {
                    Label("설정", systemImage: "person.fill")
                }
            }
            .navigationDestination(for: MainScreen.self) { screen in
                switch screen {
                case .adminTotalLogisticAndOwnerMapView(let logisticId):
                    AdminTotalLogisticAndOwnerMapView(
                        path: $path,
                        viewModel: .init(logisticId: logisticId)
                    )
                    .toolbarVisibility(.hidden, for: .navigationBar)
                case .adminTotalDriverMatchedLogisticMapView(let logisticId):
                    AdminTotalDriverMatchedLogisticMapView(
                        path: $path,
                        viewModel: .init(logisticId: logisticId)
                    )
                    .toolbarVisibility(.hidden, for: .navigationBar)
                case .adminTotalDriverRouteLogisticMapView(let listId):
                    AdminTotalDriverRouteLogisticMapView(
                        path: $path,
                        viewModel: .init(listID: listId)
                    )
                    .toolbarVisibility(.hidden, for: .navigationBar)
                case .adminOwnerApprovedLogisticsView(let userId):
                    AdminOwnerApprovedLogisticsView(
                        path: $path,
                        viewModel: .init(id: userId)
                    )
                case .adminDriverApprovedLogisticsView(let userId):
                    AdminDriverApprovedLogisticsView(
                        path: $path,
                        viewModel: .init(userId: userId)
                    )
                default:
                    DefaultView()
                }
            }
        }
    }
}

