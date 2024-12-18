//
//  mainViewManager.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI
import Combine

// 로그인 상태 관리 객체
@Observable
class MainViewManager: ObservableObject {
    var isLoggedIn: Bool = false
    var infoAlertViewModel: InfoAlertViewModel? = nil
    var inputAlertViewModel: InputAlertViewModel? = nil
    
    var isLoading: Bool = false
}

