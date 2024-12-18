//
//  MatchedRouteMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import Combine
import SwiftUI

struct MatchedRouteMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: MatchedRouteMapViewModel
    
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
                        .font(.pretendard(size: 15, weight: .bold))
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
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("물품명: \(viewModel.category)")
                        .font(.pretendardTitle)
                    Text("비용 \(viewModel.price)만원")
                        .font(.pretendardTitle)
                }
                .padding(.horizontal, 20)
                
                Text("도착지: \(viewModel.destination)")
                    .font(.pretendardTitle)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendardTitle)
                    Text(viewModel.description)
                        .foregroundStyle(.crGray2)
                        .font(.pretendardDescription)
                }
                .padding(.horizontal, 20)
                
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
                                .sink(
                                    receiveValue: { isSuccess in
                                        mainViewManager.infoAlertViewModel = .init(
                                            title: "알림",
                                            description: "예약 \(isSuccess ? "성공" : "실패")",
                                            cancelAction: nil,
                                            confirmAction: { path.removeAll() },
                                            isOnlyConfirm: true
                                        )
                                    }
                                )
                                .store(in: &cancellables)
                        }
                    )
                } label: {
                    Text("예약하기")
                }
            }
            .frame(alignment: .bottom)
        }
        .onAppear {
            draw = true
        }
        .onDisappear {
            draw = false
        }
    }
}
