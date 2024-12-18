//
//  SuggestRouteMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import SwiftUI
import Combine

struct SuggestRouteMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: SuggestRouteMapViewModel
    @State var draw: Bool = true
    @State private var cancellables = Set<AnyCancellable>()
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .padding(.trailing, 12)
                    .onTapGesture {
                        path.removeLast()
                    }
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.pretendardTitle)
                }
                Spacer()
            }
            .padding(.leading, 16)
            .background(.white)
            
            KakaoMapView(
                draw: $draw,
                logistics: $viewModel.logisticMapData,
                currentLocation: $viewModel.currentLocation,
                showPoiType: $viewModel.showPoiType,
                updateUIEvent: $viewModel.updateEvent
            )
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            
            VStack(alignment: .leading) {
                List(viewModel.logistics, id: \.self) { logistic in
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading) {
                            Text("출발: \(logistic.locationName)\n도착: \(logistic.destinationName)")
                                .font(.pretendardTitle)
                            Text("물품명: \(logistic.productName)")
                                .font(.pretendardTitle)
                                
                        }
                        
                        Text("운송무게 \(logistic.weight)톤, 비용 \(logistic.price)만원")
                            .foregroundStyle(.crGray2)
                            .font(.pretendardDescription)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendardTitle)
                    Text("\(viewModel.route.description)")
                        .font(.pretendardDescription)
                }
                .padding(.horizontal,20)
                
                CarruButton {
                    mainViewManager.infoAlertViewModel = .init(
                        title: "알림",
                        description: "예약하시겠습니까?",
                        cancelAction: {
                            logger.printOnDebug("nothing")
                        },
                        confirmAction: {
                            logger.printOnDebug("예약 시도")
                            viewModel.reservation()
                                .sink { isSuccess in
                                    mainViewManager
                                        .infoAlertViewModel = .init(
                                            title: "예약 \(isSuccess ? "성공" : "실패")",
                                            description:"",
                                            cancelAction: nil,
                                            confirmAction: {
                                                path.removeAll()
                                            },
                                            isOnlyConfirm: true
                                        )
                                }
                                .store(in: &cancellables)
                        }
                    )
                } label: {
                    Text("예약하기")
                }
            }
            .frame(maxHeight: 350, alignment: .bottom)
            
            Text("\(viewModel.updateEvent)")
                .hidden()
        }
        .onAppear {
            draw = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                viewModel.showMap()
            }
        }
        .onDisappear {
            draw = false
        }
    }
}
