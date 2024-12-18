//
//  AdminApproveLogisticView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI
import Combine

struct AdminApproveLogisticView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminApproveLogisticViewModel
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("물류승인")
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            List(viewModel.logistics, id: \.self) { logistic in
                AdminApproveLogisticCell(logistic: logistic)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        logger.printOnDebug("물류 승인 선택")
                        logisticApproveAlert(logistic: logistic)
                    }
            }
            .listStyle(.plain)
            
        }
        .onAppear {
            viewModel.loadList()
        }
    }
    
    private func logisticApproveAlert(logistic: UnApprovedLogistics) {
        mainViewManager.infoAlertViewModel = .init(
            title: "물류 승인",
            description: "",
            cancelAction: {
                logger.printOnDebug("승인 취소")
            },
            confirmAction: {
                logger.printOnDebug("승인 시도")
                viewModel.approve(logistic: logistic)
            }
        )
    }
}


