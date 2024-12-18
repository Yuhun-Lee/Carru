//
//  InputAlertView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct InputAlertView: View {
    @Bindable var viewModel: InputAlertViewModel
    var complition: (() -> Void) = { }
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text(viewModel.title)
                    .multilineTextAlignment(.center)
                    .font(.pretendardCaption)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                CarruTextField(text: $viewModel.text, placeholder: "placeholder")
                
                HStack {
                    Button {
                        if let cancelAction = viewModel.cancelAction {
                            cancelAction()
                        }
                        complition()
                    } label: {
                        Text("취소")
                            .font(.pretendardCaption)
                            .frame(width: 130, height: 40)
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundStyle(Color.appTypeColor)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.appTypeColor, lineWidth: 1.8)
                            )
                    }
                    
                    Button {
                        if let confirmAction = viewModel.confirmAction {
                            confirmAction(viewModel.text)
                        }
                        complition()
                    } label: {
                        Text("확인")
                            .font(.pretendardCaption)
                            .frame(width: 130, height: 40)
                            .foregroundStyle(.white)
                            .background(Color.appTypeColor)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }
            .frame(maxWidth: 300)
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
        }
    }
}

#Preview {
    InputAlertView(
        viewModel: InputAlertViewModel(
            text: "유저 원래 이름",
            title: "제목",
            cancelAction: nil,
            confirmAction: nil
        )
    )
}
