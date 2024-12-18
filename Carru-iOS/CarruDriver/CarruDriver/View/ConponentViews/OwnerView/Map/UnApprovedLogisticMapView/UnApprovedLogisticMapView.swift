//
//  UnApprovedLogisticMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import SwiftUI
import Combine

struct UnApprovedLogisticMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: UnApprovedLogisticMapViewModel
    @State private var cancellables = Set<AnyCancellable>()
    @State var draw: Bool = true
    
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
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("도착지: \(viewModel.logistic.destination)")
                            .font(.pretendardTitle)
                        Text("물품명: \(viewModel.logistic.productName)")
                            .font(.pretendardTitle)
                        Text(viewModel.logistic.desctiption)
                            .font(.pretendardDescription)
                    }
                    .padding(.horizontal, 20)
                }
                
                HStack {
                    Button {
                        logger.printOnDebug("미승인 물류 삭제 시도")
                        viewModel.removeLogistic()
                            .sink(receiveValue: { isSuccess in
                                mainViewManager.infoAlertViewModel = .init(
                                    title: "알림",
                                    description: "삭제 \(isSuccess ? "성공" : "실패")",
                                    cancelAction: nil,
                                    confirmAction: {
                                        path.removeAll()
                                    },
                                    isOnlyConfirm: true
                                )
                            })
                            .store(in: &cancellables)
                    } label: {
                        Text("삭제")
                            .font(.pretendardCaption)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundStyle(Color.appTypeColor)
                            .clipShape(.rect(cornerRadius: 10))
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appTypeColor, lineWidth: 1.8)
                            )
                    }
                    
                    Button {
                        logger.printOnDebug("미승인 물류 수정 시도")
                        path.append(.editLogisticView(logisticId: viewModel.logisticId))
                    } label: {
                        Text("수정")
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
            }
            .frame(alignment: .bottom)
        }
        .onAppear {
            draw = true
            viewModel.loadLogistic()
        }
        .onDisappear {
            draw = false
        }
    }
}
