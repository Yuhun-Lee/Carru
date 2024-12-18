//
//  AdminTotalLogisticCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct AdminTotalLogisticCell: View {
    var logistic: ApprovedLogistics
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(logistic.title)
                        .font(.pretendardTitle)
                    Text(logistic.description)
                        .font(.pretendardDescription)
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
