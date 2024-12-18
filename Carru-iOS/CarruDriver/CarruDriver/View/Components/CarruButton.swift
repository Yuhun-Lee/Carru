//
//  CarruButton.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI

struct CarruButton<Label: View>: View {
    var backgroundColor: Color = .appTypeColor
    var action: () -> Void
    @ViewBuilder var label: () -> Label
    
    var body: some View {
        Button(action: action) {
            label()
                .font(.pretendardCaption)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
    }
}


#Preview {
    CarruButton(backgroundColor: .blue) {
        //
    } label: {
        Text("버튼")
    }
}
