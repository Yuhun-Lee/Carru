//
//  UnApprovedLogisticListCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/29/24.
//

import SwiftUI

struct UnApprovedLogisticListCell: View {
    var logistic: UnapprovedLogistics
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("출발: \(logistic.location)\n도착: \(logistic.destination)")
                        .font(.pretendard(size: 18, weight: .bold))
                    Text(logistic.description)
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.crGray2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)

        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}
