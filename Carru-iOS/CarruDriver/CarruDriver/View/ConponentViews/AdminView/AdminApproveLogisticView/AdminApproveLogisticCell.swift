//
//  AdminApproveLogisticCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct AdminApproveLogisticCell: View {
    var logistic: UnApprovedLogistics
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("출발: \(logistic.departure)")
                            .font(.pretendardTitle)
                        Spacer()
                    }
                    
                    HStack {
                        Text("도착: \(logistic.destination)")
                            .font(.pretendardTitle)
                        Spacer()
                    }
                    
                    Text(logistic.description)
                        .font(.pretendardDescription)
                        .foregroundStyle(.crGray2)
                }
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)

        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}
