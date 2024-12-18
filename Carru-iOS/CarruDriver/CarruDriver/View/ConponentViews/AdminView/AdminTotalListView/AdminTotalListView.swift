//
//  AdminTotalListView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//


import SwiftUI
import Combine

struct AdminTotalListView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminTotalListViewModel
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("목록")
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            Picker("UserType", selection: $viewModel.selectedListTypeSegment) {
                ForEach(AdminTotalListViewModel.ListType .allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            if viewModel.selectedListTypeSegment == .logistic {
                List(viewModel.logistics, id: \.self) { logistic in
                    AdminTotalLogisticCell(logistic: logistic)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            logger.printOnDebug("물류 상세 선택")
                            path.append(.adminTotalLogisticAndOwnerMapView(logisticId: logistic.logisticsId))
                        }
                }
                .listStyle(.plain)
            } else if viewModel.selectedListTypeSegment == .owner {
                List(viewModel.ownerUsers, id: \.self) { ownerUser in
                    AdminTotalOwnerCell(user: ownerUser)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            logger.printOnDebug("화주 상세 선택")
                            path.append(.adminOwnerApprovedLogisticsView(ownerId: ownerUser.userId))
                        }
                }
                .listStyle(.plain)
            } else if viewModel.selectedListTypeSegment == .driver {
                List(viewModel.driverUsers, id: \.self) { driverUser in
                    AdminTotalDriverCell(user: driverUser)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            logger.printOnDebug("기사 상세 선택")
                            path.append(.adminDriverApprovedLogisticsView(driverId: driverUser.userId))
                        }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.loadList()
        }
        .onChange(of: viewModel.selectedListTypeSegment) { _, _ in
            viewModel.loadList()
        }
    }
}
