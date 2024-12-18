//
//  CarruTextView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct CarruTextView: View {
    @Binding var text: String
    var placeholder: String
    var icon: String? = nil
    var cornerRadius: CGFloat = 10
    var borderColor: Color = .gray
    var borderWidth: CGFloat = 1
    var iconColor: Color = .gray
    
    var body: some View {
        HStack {
            Text(text.isEmpty ? placeholder : text)
                .foregroundColor(text.isEmpty ? .gray : .primary) // placeholder와 입력된 텍스트 색상 구분
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                
            if let icon = icon {
                Image(systemName: icon)
                    .padding(.trailing, 10)
                    .foregroundColor(iconColor)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable
    @State var text: String = ""
    
    CarruTextView(text: $text, placeholder: "예시 텍스트")
}
