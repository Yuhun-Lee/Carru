//
//  CarruTextField.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI

struct CarruTextField: View {
    @Binding var text: String
    var placeholder: String
    @State var isSecure: Bool = false
    @State var icon: String? = nil
    var cornerRadius: CGFloat = 10
    var borderColor: Color = .gray
    var borderWidth: CGFloat = 1
    var iconColor: Color = .gray
    var iconAction: (() -> Void)?
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding(.leading, 10)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .padding(.leading, 10)
            }
            
            if let icon = icon {
                Image(systemName: icon)
                    .padding(.trailing, 10)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        if icon == "eye" {
                            self.icon = "eye.slash"
                            self.isSecure = true
                        } else if icon == "eye.slash" {
                            self.icon = "eye"
                            self.isSecure = false
                        }
                        
                        guard let iconAction else { return }
                        iconAction()
                    }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 15)
        .background(Color.white) // 배경 색상 설정
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
    @FocusState var isTextFieldFocused: Bool
    
    CarruTextField(
        text: $text,
        placeholder: "예시",
        icon: "eye.slash"
    )
}
