//
//  ReservationMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/13/24.
//

import SwiftUI
import Combine

struct logisticMatchReservationMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: logisticMatchReservationMapViewModel
    var mapType: ReservationsViewModel.ProcessSegment
    
    
    @State var draw: Bool = true
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .onTapGesture {
                        path.removeLast()
                    }
                    .frame(width: 40)
                VStack(alignment: .leading) {
                    Text(viewModel.routeDescription)
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
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendard(size: 15, weight: .bold))
                    Text(viewModel.description)
                        .foregroundStyle(.crGray2)
                        .font(.pretendard(size: 13, weight: .light))
                }
                .padding(.horizontal, 12)
                .padding(.top, 12)
                
                HStack {
                    switch mapType {
                    case .todo:
                        CarruButton {
                            mainViewManager.infoAlertViewModel = .init(
                                title: "알림",
                                description: "운송을 시작하시겠습니까?",
                                cancelAction: {
                                    logger.printOnDebug("nothing")
                                },
                                confirmAction: {
                                    viewModel.changeTransferStatus(.todoToProgress)
                                        .sink { isSuccess in
                                            mainViewManager.infoAlertViewModel = .init(
                                                title: "알림",
                                                description: "\(isSuccess ? "운송을 시작합니다" : "변경 실패")",
                                                cancelAction: nil,
                                                confirmAction: { path.removeLast() },
                                                isOnlyConfirm: true
                                            )
                                        }
                                        .store(in: &cancellables)
                                }
                            )
                        } label: {
                            Text("운송시작")
                        }
                    case .inProgress:
                        HStack {
                            Button {
                                mainViewManager.infoAlertViewModel = .init(
                                    title: "알림",
                                    description: "운송을 중단하시겠습니까?",
                                    cancelAction: {
                                        logger.printOnDebug("nothing")
                                    },
                                    confirmAction: {
                                        viewModel.changeTransferStatus(.progressToTodo)
                                            .sink { isSuccess in
                                                mainViewManager.infoAlertViewModel = .init(
                                                    title: "알림",
                                                    description: "\(isSuccess ? "운송 준비로 변경되었습니다." : "변경 실패")",
                                                    cancelAction: nil,
                                                    confirmAction: { path.removeLast() },
                                                    isOnlyConfirm: true
                                                )
                                            }
                                            .store(in: &cancellables)
                                    }
                                )
                            } label: {
                                Text("TODO로 변경")
                                    .font(.pretendardCaption)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appTypeColor, lineWidth: 1.8)
                                    )
                            }
                            
                            Button {
                                mainViewManager.infoAlertViewModel = .init(
                                    title: "알림",
                                    description: "운송을 완료하시겠습니까??",
                                    cancelAction: {
                                        logger.printOnDebug("nothing")
                                    },
                                    confirmAction: {
                                        viewModel.changeTransferStatus(.progressToFinished)
                                            .sink { isSuccess in
                                                mainViewManager.infoAlertViewModel = .init(
                                                    title: "알림",
                                                    description: "\(isSuccess ? "운송완료!" : "상태 변경 실패")",
                                                    cancelAction: nil,
                                                    confirmAction: { path.removeLast() },
                                                    isOnlyConfirm: true
                                                )
                                            }
                                            .store(in: &cancellables)
                                    }
                                )
                            } label: {
                                Text("운송 종료")
                                    .font(.pretendardCaption)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .foregroundStyle(.white)
                                    .background(Color.appTypeColor)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                        .padding(.bottom, 12)
                        .padding(.horizontal, 12)
                        
                    case .finished:
                        VStack(alignment: .leading) {
                            Text("운송 상태")
                                .font(.pretendard(size: 16, weight: .bold))
                            LogisticProgressView(type: .finished)
                        }
                        .padding(.horizontal, 12)
                    }
                }
            }
            .frame(alignment: .bottom)
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
