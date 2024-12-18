//
//  SettingView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI
import Combine

struct SettingView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: SettingViewModel
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                VStack(spacing: 16) {
                    Image("truck")
                        .resizable() // 크기 조정을 가능하게 함
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                    
                    Text(viewModel.profile.name)
                        .font(.pretendardTitle)
                        .tint(.black)
                    Text(viewModel.profile.email)
                        .font(.pretendardDescription)
                        .tint(.gray)
                }
                .padding(.top, 50)
                
                if appType != .admin {
                    HStack {
                        Text("차고지 변경")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal, 24)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.isFindAddressPresent.toggle()
                    }
                    
                    Divider()
                }
                
                HStack {
                    Text("이름 변경")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding(.horizontal, 24)
                .contentShape(Rectangle())
                .onTapGesture {
                    userNameChangeAlert()
                }
                
                Divider()
                
                HStack {
                    Text("로그아웃")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 24)
                .onTapGesture {
                    signOutAlert()
                }
                
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isFindAddressPresent) {
            AddressView(
                title: "차고지 변경",
//                path: $path,
                viewModel: .init(searchKey: viewModel.garageAddress),
                confirmAction: {
                    viewModel.changeWarehouse(newAddress: $0)
                        .sink(
                            receiveCompletion: {
                                logger.checkComplition(message: "차고지 주소 변경", complition: $0)
                            },
                            receiveValue: { isSuccess in
                                viewModel.isFindAddressPresent = false // 주소창 닫기
                                mainViewManager.infoAlertViewModel = .init(
                                    title: "차고지 변경 \(isSuccess ? "성공" : "실패")",
                                    description: "",
                                    cancelAction: nil,
                                    confirmAction: nil,
                                    isOnlyConfirm: true
                                )
                        })
                        .store(in: &cancellables)
                }
            )
        }
        .onAppear {
            viewModel.loadUser()
            viewModel.loadGarage()
        }
        .dismissKeyboardOnTap()
    }
}

extension SettingView {
    private func userNameChangeAlert() {
        mainViewManager.inputAlertViewModel = .init(
            text: viewModel.profile.name,
            title: "이름 변경",
            cancelAction: {
                logger.printOnDebug("이름 변경 취소")
            },
            confirmAction: { newName in
                viewModel.userNameChange(newName: newName)
                    .sink(
                        receiveValue: { isSuccess in
                            mainViewManager.infoAlertViewModel = .init(
                                title: "알림",
                                description: "이름 변경에 \(isSuccess ? "성공" : "실패")했습니다!",
                                cancelAction: nil,
                                confirmAction: nil,
                                isOnlyConfirm: true
                            )
                    })
                    .store(in: &cancellables)
            }
        )
    }
    
    private func signOutAlert() {
        mainViewManager.infoAlertViewModel = .init(
            title: "로그아웃",
            description: "정말로 로그아웃을 하시겠습니까?\n다시 앱을 사용하려면 재로그인을 해야 합니다.",
            cancelAction: {
                logger.printOnDebug("로그아웃 취소")
            },
            confirmAction: {
                viewModel.signOut()
                    .sink { isSuccess in
                        mainViewManager.isLoggedIn = !isSuccess
                        do {
                            try Keychain.deleteToken(kind: .accessToken)
                        } catch {
                            logger.printOnDebug(error.localizedDescription)
                        }
                    }
                    .store(in: &cancellables)
            })
    }
}


#Preview {
    @Previewable @State var path: [MainScreen] = []
    
    SettingView(path: $path, viewModel: SettingViewModel())
}
