//
//  AdminDriverLogisticsView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/28/24.
//

import SwiftUI

struct AdminDriverApprovedLogisticsView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminDriverApprovedLogisticsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Picker("adminApproved", selection: $viewModel.selectedReservationSegment) {
                ForEach(AdminDriverApprovedLogisticsViewModel.ReservationSegment.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if viewModel.selectedReservationSegment == .Matched {
                List(viewModel.matchedLogistics, id: \.self) { logistic in
                    AdminDriverApprovedLogisticsCell(logistic: logistic)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            logger.printOnDebug("물류 매칭 선택")
                            path.append(.adminTotalDriverMatchedLogisticMapView(logisticId: logistic.listId))
                        }
                }
                .listStyle(.plain)
            } else if viewModel.selectedReservationSegment == .Route {
                List(viewModel.routeLogistics, id: \.self) { logistic in
                    AdminDriverApprovedRouteLogisticsCell(logistic: logistic)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            logger.printOnDebug("경로 탐색 물류 선택")
                            path.append(.adminTotalDriverRouteLogisticMapView(listId: logistic.listId))
                        }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.loadList()
        }
        .navigationTitle("물류 확인")
    }
}
