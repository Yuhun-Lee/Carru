//
//  AdminTotalListMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Combine
import SwiftUI

struct AdminTotalLogisticAndOwnerMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminTotalLogisticAndOwnerMapViewModel
    
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
                    Text(viewModel.logistic.title)
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
                    Text("도착지: \(viewModel.logistic.destinationLocation)")
                        .font(.pretendardTitle)
                    Text("물품명: \(viewModel.logistic.productName)")
                        .font(.pretendardTitle)
                    Text(viewModel.logistic.description)
                        .font(.pretendardDescription)
                }
                .padding(.horizontal, 20)
                
                
                VStack(alignment: .leading) {
                    Text("운송자")
                        .font(.pretendardTitle)
                    Text(viewModel.logistic.driverName)
                        .font(.pretendardDescription)
                    Text(viewModel.logistic.driverPhoneNumber)
                        .font(.pretendardTitle)
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .center) {
                    Text("운송 상태")
                        .font(.pretendardTitle)
                    
                    Text(viewModel.logistic.status)
                        .font(.pretendardDescription)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .padding(.horizontal, 12)
                        .foregroundStyle(.white)
                        .background(Color.appTypeColor)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.horizontal, 20)
            }
            .frame(alignment: .bottom)
        }
        .onAppear {
            draw = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                viewModel.loadLogistic()
            }
        }
        .onDisappear {
            draw = false
        }
    }
}
