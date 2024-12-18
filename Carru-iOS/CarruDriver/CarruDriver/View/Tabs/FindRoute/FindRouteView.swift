//
//  FindRouteView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI
import Combine

struct FindRouteView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: FindRouteViewModel
//    @State var addressFindType: AddressFindType = .departure
    @FocusState var focusedField: Field?
    
    @State var cancellables: Set<AnyCancellable> = []
    
    enum Field: Hashable {
        case maxWeight
        case minWeight
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("경로탐색")
                        .font(.pretendardTitle)
                        .padding(.top, 12)
                        .padding(.leading, 20)
                    
                    VStack(alignment: .leading) {
                        Text("최대 수용 무게")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $viewModel.maxWeight,
                            placeholder: "단위 톤",
                            keyboardType: .numberPad
                        )
                        .focused($focusedField, equals: .maxWeight)
                        .id(Field.maxWeight)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("최소 수용 무게")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $viewModel.minWeight,
                            placeholder: "단위 톤",
                            keyboardType: .numberPad
                        )
                        .focused($focusedField, equals: .minWeight)
                        .id(Field.minWeight)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("출발지")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextView(text: $viewModel.departure, placeholder: "출발지 선택")
                            .onTapGesture {
                                viewModel.isStartAddressPresent.toggle()
                                focusedField = nil
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("도착지")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextView(
                            text: $viewModel.destination,
                            placeholder: "도착지 선택"
                        )
                        .onTapGesture {
                            viewModel.isDestAddressPresent.toggle()
                            focusedField = nil
                        }
                    }
                    
                    HStack() {
                        Text("출발 예정 시간")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        
                        CarruDatePickerView(targetDate: $viewModel.departureTime)
                        .onTapGesture {
                            viewModel.isFindAddressPresent.toggle()
                            focusedField = nil
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("단가")
                                .font(.pretendardBody)
                            
                            Spacer()
                            
                            Text("짧은 거리")
                                .font(.pretendardBody)
                        }
                        
                        
                        Slider(value: $viewModel.properRatio, in: 1...10, step: 1)
                            .tint(Color.appTypeColor)
                    }
                    .padding(.horizontal, 20)
                    
                    CarruButton {
                        mainViewManager.isLoading = true
                        
                        viewModel.findRoute()
                            .sink { routePredicts in
                                mainViewManager.isLoading = false
                                
                                if routePredicts.isEmpty {
                                    mainViewManager.infoAlertViewModel = .init(
                                        title: "알림",
                                        description: "이미 예약되거나 승인되지 않은 물류입니다.",
                                        cancelAction: nil,
                                        confirmAction: nil,
                                        isOnlyConfirm: true
                                    )
                                    
                                } else {
                                    path.append(.suggestRoutes(routePredicts: routePredicts))
                                    viewModel.resetFeilds()
                                }
                            }
                            .store(in: &cancellables)
                        
                    } label: {
                        Text("경로 탐색")
                    }
                    
                    Spacer()
                }
                .confirmationDialog("출발지 선택", isPresented: $viewModel.isStartAddressPresent, titleVisibility: .visible) {
                    Button("주소입력") {
                        viewModel.addressFindType = .departure
                        viewModel.isFindAddressPresent.toggle()
                    }
                    Button("현재위치") {
                        viewModel.departureCurrentLocation()
                    }
                }
                .confirmationDialog("도착지 선택", isPresented: $viewModel.isDestAddressPresent, titleVisibility: .visible) {
                    Button("주소입력") {
                        viewModel.addressFindType = .destination
                        viewModel.isFindAddressPresent.toggle()
                    }
                    Button("차고지") {
                        viewModel.isFindWarehousePresent.toggle()
                    }
                }
                .sheet(isPresented: $viewModel.isFindAddressPresent) {
                    switch viewModel.addressFindType {
                    case .departure:
                        AddressView(
                            title: "출발지 선택",
                            viewModel: AddressViewModel(),
                            confirmAction: { address in
                                viewModel.departureAddress(address: address)
                                viewModel.isFindAddressPresent = false
                            },
                            confirmAction2: nil)
                    case .destination:
                        AddressView(
                            title: "도착지 선택",
                            viewModel: AddressViewModel(),
                            confirmAction: { address in
                                viewModel.destinationAddress(address: address)
                                viewModel.isFindAddressPresent = false
                            },
                            confirmAction2: nil)
                    }
                }
                .sheet(isPresented: $viewModel.isFindWarehousePresent) {
                    AddressView(
                        title: "차고지 선택",
                        viewModel: .init(type: .warehouseSearch),
                        confirmAction: nil) { warehouse in
                            viewModel.destinationWarehouse(warehouse: warehouse)
                            viewModel.isFindWarehousePresent = false
                        }
                }
                .onChange(of: focusedField) { _, newValue in
                    if let field = newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                            withAnimation {
                                proxy.scrollTo(field, anchor: .center)
                            }
                        }
                    }
                }
            }
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}

#Preview {
    @Previewable @State var path: [MainScreen] = []
    
    FindRouteView(path: $path, viewModel: .init())
}
