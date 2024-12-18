//
//  MatchLogisticsView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct MatchLogisticsView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: MatchLogisticsViewModel
    @FocusState var focusedField: Field?
    
    enum Field: Hashable {
        case maxWeight
        case minWeight
    }

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(ViewTitle.matchLogistics)
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

                    CarruButton {
                        path.append(
                            .matchedLogistics(
                                maxWeight: viewModel.maxWeightInt,
                                minWeight: viewModel.minWeightInt
                            )
                        )
                    } label: {
                        Text("물류 검색")
                    }

                    Spacer()
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

    MatchLogisticsView(path: $path, viewModel: .init())
}
