//
//  UserRegisterApproveView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI
import Combine

struct UserRegisterApproveView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: UserRegisterApproveViewModel
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("가입승인")
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            Picker("UserType", selection: $viewModel.selectedUserTypeSegment) {
                ForEach(AdminUserType.allCases) { segment in
                    Text(segment.rawValue).tag(segment)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            List(viewModel.users, id: \.self) { user in
                UserRegisterApproveCell(user: user)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        logger.printOnDebug("가입 승인 선택")
                        userRegisterApproveAlert(user: user)
                    }
            }
            .listStyle(.plain)
            
        }
        .onAppear {
            viewModel.loadUserList()
        }
        .onChange(of: viewModel.selectedUserTypeSegment) { _, _ in
            viewModel.loadUserList()
        }
    }
    
    private func userRegisterApproveAlert(user: UnApprovedUser) {
        mainViewManager.infoAlertViewModel = .init(
            title: "\(viewModel.selectedUserTypeSegment.rawValue) 승인",
            description: "",
            cancelAction: {
                logger.printOnDebug("승인 취소")
            },
            confirmAction: {
                logger.printOnDebug("승인 시도")
                viewModel.approve(user: user)
            }
        )
    }
}

