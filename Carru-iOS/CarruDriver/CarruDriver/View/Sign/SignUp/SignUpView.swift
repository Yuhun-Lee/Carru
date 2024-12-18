//
//  SignUpView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [SignScreen]
    @Bindable var signUpViewModel: SignUpViewModel
    @State private var cancellables = Set<AnyCancellable>()
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case email
        case phone
        case password
        case passwordCheck
        case name
        case warehouseName
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 18) {
                    VStack(alignment: .leading) {
                        Text("이메일주소")
                            .font(.pretendardCaption)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $signUpViewModel.email,
                            placeholder: "example@email.com"
                        )
                        .focused($focusedField, equals: .email)
                        .id(Field.email)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("전화번호")
                            .font(.pretendardCaption)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $signUpViewModel.phone,
                            placeholder: "010-1234-5678",
                            keyboardType: .numberPad
                        )
                        .focused($focusedField, equals: .phone)
                        .id(Field.phone)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("비밀번호")
                            .font(.pretendardCaption)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $signUpViewModel.password,
                            placeholder: "비밀번호",
                            isSecure: true
                        )
                        .focused($focusedField, equals: .password)
                        .id(Field.password)
                        CarruTextField(
                            text: $signUpViewModel.passwordCheck,
                            placeholder: "비밀번호 확인",
                            isSecure: true
                        )
                        .focused($focusedField, equals: .passwordCheck)
                        .id(Field.passwordCheck)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("이름")
                            .font(.pretendardCaption)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $signUpViewModel.name,
                            placeholder: "이름"
                        )
                        .focused($focusedField, equals: .name)
                        .id(Field.name)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("주소")
                            .font(.pretendardCaption)
                            .padding(.horizontal, 20)
                        CarruTextView(
                            text: $signUpViewModel.address,
                            placeholder: "주소",
                            icon: "magnifyingglass"
                        )
                        .onTapGesture {
                            focusedField = nil
                            signUpViewModel.isAddressSelectPresent.toggle()
                        }
                    }
                    
                    if appType == .owner {
                        VStack(alignment: .leading) {
                            Text("창고 이름")
                                .font(.pretendardCaption)
                                .padding(.horizontal, 20)
                            CarruTextField(
                                text: $signUpViewModel.warehouseName,
                                placeholder: "창고 이름"
                            )
                            .focused($focusedField, equals: .warehouseName)
                            .id(Field.warehouseName)
                        }
                    }
                    
                    CarruButton {
                        signUpViewModel.signUp()
                            .sink(receiveCompletion: {
                                logger.checkComplition(message: "회원가입", complition: $0)
                            }, receiveValue: { isSigned in
                                path.removeAll()
                            })
                            .store(in: &cancellables)
                    } label: {
                        Text("회원가입")
                            .font(.pretendard(size: 16, weight: .bold))
                    }
                    
                    Spacer()
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
        }
        .navigationTitle("회원가입")
        .sheet(isPresented: $signUpViewModel.isAddressSelectPresent) {
            AddressView(
                title: "주소 선택",
                viewModel: .init()
            ) { newAddress in
                signUpViewModel.address = newAddress
                signUpViewModel.isAddressSelectPresent.toggle()
                signUpViewModel.getAddress()
            }
        }
    }
}
