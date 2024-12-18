//
//  ReservationsView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct ReservationsView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: ReservationsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(ViewTitle.reservations)
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            Picker("Reserve", selection: $viewModel.selectedReservationSegment) {
                ForEach(ReservationsViewModel.ReservationSegment.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Picker("Process", selection: $viewModel.selectedProcessSegment) {
                ForEach(ReservationsViewModel.ProcessSegment.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // 물류 매칭 예약 리스트
            if viewModel.selectedReservationSegment == .Matched {
                List(viewModel.matchedReservations, id: \.self) { reservation in
                    logisticMatchingListCell(reservation: reservation)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            path.append(
                                .reservationMap(
                                    reservation: reservation,
                                    type: viewModel.selectedProcessSegment
                                )
                            )
                        }
                }
                .listStyle(.plain)
            } else if viewModel.selectedReservationSegment == .Route { // 경로탐색 예약 리스트
                List(viewModel.routeReservations, id: \.self) { reservation in
                    RouteMatchingListCell(reservation: reservation)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                        .onTapGesture {
                            path.append(
                                .routeMatchingReservationMapView(
                                    reservation: reservation,
                                    type: viewModel.selectedProcessSegment
                                )
                            )
                        }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            viewModel.loadList()
        }
        .onChange(of: viewModel.selectedReservationSegment) { _, _ in
            viewModel.loadList()
        }
        .onChange(of: viewModel.selectedProcessSegment) { _, _ in
            viewModel.loadList()
        }
    }
}

#Preview {
    @Previewable @State var path: [MainScreen] = []
    
    ReservationsView(path: $path, viewModel: .init())
}
