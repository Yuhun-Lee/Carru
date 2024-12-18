//
//  InFoAlertView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct InfoAlertView: View {
    @Bindable var viewModel: InfoAlertViewModel
    var complition: (() -> Void) = { }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                if !viewModel.title.isEmpty {
                    Text(viewModel.title)
                        .multilineTextAlignment(.center)
                        .font(.pretendardCaption)
                        .padding(.top, 20)
                        .padding(.horizontal, 20)
                }
                
                if !viewModel.description.isEmpty {
                    Text(viewModel.description)
                        .multilineTextAlignment(.center)
                        .font(.pretendardBody)
                        .padding(.horizontal, 20)
                }
                
                HStack {
                    if !viewModel.isOnlyConfirm {
                        Button {
                            if let cancelAction = viewModel.cancelAction {
                                cancelAction()
                            }
                            complition()
                        } label: {
                            Text("취소")
                                .font(.pretendardCaption)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .clipShape(.rect(cornerRadius: 10))
                                .foregroundColor(Color.appTypeColor)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.appTypeColor, lineWidth: 1.8)
                                )
                        }
                    }
                    
                    Button {
                        if let confirmAction = viewModel.confirmAction {
                            confirmAction()
                        }
                        complition()
                    } label: {
                        Text("확인")
                            .font(.pretendardCaption)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundStyle(.white)
                            .background(Color.appTypeColor)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
            .frame(maxWidth: 300)
            .background(.white)
            .clipShape(.rect(cornerRadius: 15))
        }
    }
}

#Preview {
    InfoAlertView(viewModel: InfoAlertViewModel(title: "제목", description: "상세"))
}
