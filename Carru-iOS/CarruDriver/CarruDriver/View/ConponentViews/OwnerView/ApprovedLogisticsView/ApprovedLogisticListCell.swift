//
//  ApprovedLogisticListCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/29/24.
//

import Foundation

import SwiftUI

struct ApprovedLogisticListCell: View {
    var logistic: OwnerApprovedLogistic
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("출발: \(logistic.location)\n도착: \(logistic.destination)")
                        .font(.pretendardTitle)
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
