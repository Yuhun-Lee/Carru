//
//  ApprovedLogisticsView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import SwiftUI

struct ApprovedLogisticsView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: ApprovedLogisticsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("승인 물류")
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            Picker("Process", selection: $viewModel.selectedProcessType) {
                ForEach(ProgressType.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            List(viewModel.logistics, id: \.self) { logistic in
                ApprovedLogisticListCell(logistic: logistic)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        logger.printOnDebug("승인물류 선택")
                        path.append(
                            .ownerLogisticsApprovedMapView(
                                logisticId: logistic.productId,
                                progressType: viewModel.selectedProcessType
                            )
                        )
                    }
            }
            .listStyle(.plain)
            
        }
        .onAppear {
            viewModel.loadList()
        }
        .onChange(of: viewModel.selectedProcessType) { _, _ in
            viewModel.loadList()
        }
    }
}
