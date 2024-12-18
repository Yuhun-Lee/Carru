//
//  OwnerMainTabView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import SwiftUI

struct OwnerMainTabView: View {
    @State private var path: [MainScreen] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView {
                Tab {
                    UnapprovedLogisticsView(path: $path, viewModel: .init())
                } label: {
                    Label("미승인", systemImage: "location.circle.fill")
                }
                
                Tab {
                    LogisticRegisterView(
                        path: $path,
                        viewModel: .init()
                    )
                } label: {
                    Label("물류등록", systemImage: "pencil.circle.fill")
                }
                
                Tab {
                    ApprovedLogisticsView(path: $path, viewModel: .init())
                } label: {
                    Label("승인물류", systemImage: "envelope.fill")
                }
                
                Tab {
                    SettingView(path: $path, viewModel: .init())
                } label: {
                    Label("설정", systemImage: "person.fill")
                }
            }
            .navigationDestination(for: MainScreen.self) { screen in
                switch screen {
                case .unApprovedLogisticMapView(let logisticId):
                    UnApprovedLogisticMapView(
                        path: $path,
                        viewModel: .init(id: logisticId)
                    )
                    .toolbarVisibility(.hidden, for: .navigationBar)
                case .ownerLogisticsApprovedMapView(let logisticId, let progressType):
                    ApprovedLogisticMapView(
                        path: $path,
                        viewModel: .init(
                            logisticId: logisticId,
                            progressType: progressType
                        )
                    )
                    .toolbarVisibility(.hidden, for: .navigationBar)
                case .editLogisticView(let logisticId):
                    LogisticRegisterView(
                        path: $path,
                        viewModel: .init(id: logisticId)
                    )
                default:
                    DefaultView()
                }
            }
        }
    }
}
