//
//  MatchedListCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import SwiftUI

struct MatchedListCell: View {
    var logistic: Logistic
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Text(logistic.departureLocation)
                        .font(.pretendardTitle)
                    Image(systemName: "arrow.right")
                    Text(logistic.destinationLocation)
                        .font(.pretendardTitle)
                    
                }
                Text(logistic.description)
                    .font(.pretendardDescription)
                    .foregroundStyle(.crGray2)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    MatchedListCell(
        logistic: .init(productId: 1, departureLocation: "2", departureLatitude: 3, departureLongitude: 4, destinationLocation: "5", destinationLatitude: 6, destinationLongitude: 7, price: 8, weight: 9, operationDistance: 10, operationTime: 11, deadLine: "12")
    )
}
