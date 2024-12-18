//
//  AdminDriverApprovedRouteLogisticsCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/1/24.
//


import SwiftUI

struct AdminDriverApprovedRouteLogisticsCell: View {
    var logistic: DriverRouteMatching
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("출발: \(logistic.departureLocation)\n도착: \(logistic.destinationLocation)")
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
