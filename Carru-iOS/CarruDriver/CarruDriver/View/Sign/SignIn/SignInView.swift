//
//  ContentView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/1/24.
//

import SwiftUI
import Combine

struct SignInView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Bindable var viewModel: SignInViewModel
    @State private var path: [SignScreen] = []
    @State private var cancellables = Set<AnyCancellable>()
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case id
        case password
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        VStack {
                            Image("truck")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(80)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.appTypeBackgroundColor)
                        
                        VStack(alignment: .leading) {
                            Text("Carru 카루 서비스에 오신 것을")
                                .font(.pretendardBody)
                            Text("환영합니다!")
                                .font(.pretendardExtraBoldTitle)
                        }
                        .padding(.horizontal, 20)
                        
                        VStack(spacing: 18) {
                            CarruTextField(
                                text: $viewModel.id,
                                placeholder: "아이디"
                            )
                            .focused($focusedField, equals: .id)
                            .id(Field.id)
                            
                            CarruTextField(
                                text: $viewModel.password,
                                placeholder: "비밀번호",
                                isSecure: true
                            )
                            .focused($focusedField, equals: .password)
                            .id(Field.password)
                            
                            CarruButton() {
                                
                                viewModel.signIn()
                                    .sink(receiveCompletion: {
                                        switch $0 {
                                        case .finished: break
                                        case .failure(let error):
                                            mainViewManager.infoAlertViewModel = .init(title: "로그인 실패", description: "\(error.localizedDescription)", cancelAction: nil, confirmAction: nil, isOnlyConfirm: true
                                            )
                                        }
                                        
                                    }, receiveValue: { _ in
                                        mainViewManager.isLoggedIn = true
                                    })
                                    .store(in: &cancellables)
                                
                            } label: {
                                Text("로그인")
                            }
                            
                            if appType != .admin {
                                HStack {
                                    Text("아직 회원이 아니신가요?")
                                    Text("회원가입")
                                        .foregroundStyle(Color.appTypeColor)
                                        .onTapGesture {
                                            path.append(.signUp)
                                        }
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .navigationDestination(for: SignScreen.self) { scr in
                        switch scr {
                        case .signUp:
                            SignUpView(
                                path: $path,
                                signUpViewModel: SignUpViewModel()
                            )
                        default:
                            DefaultView()
                        }
                    }
                    .onChange(of: focusedField) { _, newValue in
                        if let field = newValue {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                                withAnimation {
                                    proxy.scrollTo(field, anchor: .center)
                                }
                            }
                        }
                    }
                }
                .onTapGesture {
                    focusedField = nil
                }
                .onAppear {

                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
