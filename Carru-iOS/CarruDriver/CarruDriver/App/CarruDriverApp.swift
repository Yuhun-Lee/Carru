//
//  CarruDriverApp.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/1/24.
//

import SwiftUI

@main
struct CarruDriverApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: CarruAppDelegate
    @StateObject private var mainViewManager = MainViewManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appType == .driver {
                    MainView()
                        .preferredColorScheme(.light)
                        .environmentObject(mainViewManager)
                } else if appType == .owner {
                    OwnerMainView()
                        .preferredColorScheme(.light)
                        .environmentObject(mainViewManager)
                } else if appType == .admin {
                    AdminMainView()
                        .preferredColorScheme(.light)
                        .environmentObject(mainViewManager)
                }
            }
        }
    }
}
