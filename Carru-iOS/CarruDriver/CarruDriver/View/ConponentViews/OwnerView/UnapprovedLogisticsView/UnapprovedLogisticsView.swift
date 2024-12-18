//
//  UnapprovedLogisticsView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import SwiftUI

struct UnapprovedLogisticsView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: UnapprovedLogisticsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("미승인 물류")
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            
            List(viewModel.unApprovedLogistics, id: \.self) { logistic in
                UnApprovedLogisticListCell(logistic: logistic)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        logger.printOnDebug("미승인물류 선택")
                        path.append(.unApprovedLogisticMapView(logisticId: logistic.productId))
                    }
            }
            .listStyle(.plain)
            
        }
        .onAppear {
            viewModel.loadList()
        }
    }
}

