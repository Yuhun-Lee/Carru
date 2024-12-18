//
//  d.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/1/24.
//

import Combine
import SwiftUI

struct AdminTotalDriverRouteLogisticMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminTotalDriverRouteLogisticMapViewModel
    
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
            
            VStack(alignment: .leading) {
                List(viewModel.logistic.stopOverList, id: \.self){ stopOver in
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading) {
                            Text("출발: \(stopOver.stopOverLocation)")
                                .font(.pretendardTitle)
                            Text("물품명: \(stopOver.productName)")
                                .font(.pretendardTitle)
                        }
                        
                        Text("운송무게 \(stopOver.weight)톤, 비용 \(stopOver.price)만원")
                            .font(.pretendardDescription)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendardTitle)
                    Text(viewModel.logistic.description)
                        .font(.pretendardDescription)
                }
                .padding(.horizontal,12)
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
