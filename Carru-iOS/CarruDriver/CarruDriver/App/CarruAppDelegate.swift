//
//  CarruAppDelegate.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import UIKit
import SwiftUI
import KakaoMapsSDK

let appType: AppType = .owner

class CarruAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let kakaoMapAPIKey = InfoManager.kakaoMapAPIKey
        SDKInitializer.InitSDK(appKey: kakaoMapAPIKey)
        
        switch appType {
        case .driver:
            configTabView()
        case .owner:
            ownerConfigTabView()
        case .admin:
            adminConfigTabView()
        }
        
        return true
    }
}

extension CarruAppDelegate {
    private func configTabView() {
        let appearance = UITabBarAppearance()
        
        // 활성화 색상 설정
        appearance.stackedLayoutAppearance.selected.iconColor = .appTypeColor
        // 선택 텍스트 색상
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.appTypeColor]
        
        // 비활성화 색상 설정
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        // 미선택 텍스트 색상
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        // 배경색 설정
        appearance.backgroundColor = .white

        // 구분선 제거
        appearance.shadowImage = UIImage() // 구분선을 투명 이미지로 설정하여 제거
        appearance.backgroundImage = UIImage() // 그림자를 투명 이미지로 설정하여 제거
        
        // Tab Bar Appearance 설정 적용
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func ownerConfigTabView() {
        let appearance = UITabBarAppearance()
        
        // 활성화 색상 설정
        appearance.stackedLayoutAppearance.selected.iconColor = .crRed
        // 선택 텍스트 색상
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.crRed]
        
        // 비활성화 색상 설정
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        // 미선택 텍스트 색상
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        // 배경색 설정
        appearance.backgroundColor = .white

        // 구분선 제거
        appearance.shadowImage = UIImage() // 구분선을 투명 이미지로 설정하여 제거
        appearance.backgroundImage = UIImage() // 그림자를 투명 이미지로 설정하여 제거
        
        // Tab Bar Appearance 설정 적용
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func adminConfigTabView() {
        let appearance = UITabBarAppearance()
        
        // 활성화 색상 설정
        appearance.stackedLayoutAppearance.selected.iconColor = .crGreen
        // 선택 텍스트 색상
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.crGreen]
        
        // 비활성화 색상 설정
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        // 미선택 텍스트 색상
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        // 배경색 설정
        appearance.backgroundColor = .white

        // 구분선 제거
        appearance.shadowImage = UIImage() // 구분선을 투명 이미지로 설정하여 제거
        appearance.backgroundImage = UIImage() // 그림자를 투명 이미지로 설정하여 제거
        
        // Tab Bar Appearance 설정 적용
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
