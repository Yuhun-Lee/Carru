//
//  OwnerMainView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import SwiftUI

struct OwnerMainView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    
    var body: some View {
        
        ZStack {
            if mainViewManager.isLoggedIn {
                OwnerMainTabView()
            } else {
                SignInView(viewModel: .init())
            }
            
            // 커스텀 알림창 최상단 사용
            if let infoAlertViewModel = mainViewManager.infoAlertViewModel {
                InfoAlertView(viewModel: infoAlertViewModel) {
                    mainViewManager.infoAlertViewModel = nil
                }
            }
            
            // 커스텀 인풋 최상단 사용
            if let inputAlertViewModel = mainViewManager.inputAlertViewModel {
                InputAlertView(viewModel: inputAlertViewModel) {
                    mainViewManager.inputAlertViewModel = nil
                }
            }
            
            if mainViewManager.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            guard let _ = try? Keychain.searchToken(kind: .accessToken) else { return }
            mainViewManager.isLoggedIn = true
        }
    }
}

