//
//  LogisticApprovedMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import Combine
import SwiftUI

struct ApprovedLogisticMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: ApprovedLogisticMapViewModel
    
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
                    Text(viewModel.logistic?.title ?? "")
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
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("도착지: \(viewModel.logistic?.destination ?? "")")
                        .font(.pretendardTitle)
                    Text("물품명: \(viewModel.logistic?.productName ?? "")")
                        .font(.pretendardTitle)
                    Text("무게: \(viewModel.logistic?.weight ?? 0)톤, 비용: \(viewModel.logistic?.price ?? 0)만원, 예상거리: \(viewModel.logistic?.operationDistance ?? 0) 예상시간: \(viewModel.logistic?.operationTime ?? 0)")
                        .font(.pretendardDescription)
                }
                .padding(.horizontal, 20)
                
                if viewModel.progressType != .todo && viewModel.progressType != .approved {
                    VStack(alignment: .leading) {
                        Text("운송자")
                            .font(.pretendardTitle)
                        Text(viewModel.logistic?.transporterName ?? "")
                            .font(.pretendardDescription)
                        Text(viewModel.logistic?.transporterPhoneNumber ?? "")
                            .font(.pretendardDescription)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(maxWidth: .infinity)
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
