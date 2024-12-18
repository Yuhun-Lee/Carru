//
//  LoadingView.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/8/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            // 반투명 배경
            Color.black
                .opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            // 로딩 인디케이터
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2) // 크기 조절
        }
    }
}
