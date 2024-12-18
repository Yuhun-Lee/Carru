//
//  RouteListView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import SwiftUI

struct RouteListView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: RouteListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            List(viewModel.routes, id: \.self){ route in
                RouteListCellView(route: route)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        path.append(.suggestMap(routes: route))
                    }
            }
            .listStyle(.plain)
        }
        .navigationTitle("추천경로")
    }
}
