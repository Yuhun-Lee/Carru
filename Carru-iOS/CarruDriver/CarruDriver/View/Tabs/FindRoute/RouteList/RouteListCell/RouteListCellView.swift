//
//  RouteListCellView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import SwiftUI

struct RouteListCellView: View {
    var route: RoutePredict
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(route.title)
                    .font(.pretendardTitle)
                Text(route.description)
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

