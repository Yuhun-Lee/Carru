//
//  Color+CarruDriver.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI
import UIKit

import SwiftUI

extension Color {
    static let CRBackground = Color("CRBackground")
    static let CRBlue = Color("CRBlue")
    static let CRGray = Color("CRGray")
    static let CRGray2 = Color("CRGray2")
    static let CRText = Color("CRText")
    static let CRGreen = Color("CRGreen")
    static let CRGreenBackground = Color("CRGreenBackground")
    static let CRRed = Color("CRRed")
    static let CRRedBackground = Color("CRRedBackground")
    
    static var appTypeColor: Color {
        switch appType {
        case .driver:
            return .crBlue
        case .owner:
            return .crRed
        case .admin:
            return .crGreen
        }
    }
    
    static var appTypeBackgroundColor: Color {
        switch appType {
        case .driver:
            return .crBackground
        case .owner:
            return .crRedBackground
        case .admin:
            return .crGreenBackground
        }
    }
}

extension UIColor {
    static let CRBackground = UIColor(named: "CRBackground") ?? .systemBlue
    static let CRBlue = UIColor(named: "CRBlue") ?? .systemBlue
    static let CRGray = UIColor(named: "CRGray") ?? .systemBlue
    static let CRGray2 = UIColor(named: "CRGray2") ?? .systemBlue
    static let CRText = UIColor(named: "CRText") ?? .systemBlue
    static let CRGreen = UIColor(named: "CRGreen") ?? .systemBlue
    static let CRGreenBackground = UIColor(named: "CRGreenBackground") ?? .systemBlue
    static let CRRed = UIColor(named: "CRRed") ?? .systemBlue
    static let CRRedBackground = UIColor(named: "CRRedBackground") ?? .systemBlue
    
    static var appTypeColor: UIColor {
        switch appType {
        case .driver:
            return .crBlue
        case .owner:
            return .crRed
        case .admin:
            return .crGreen
        }
    }
    
    static var appTypeBackgroundColor: UIColor {
        switch appType {
        case .driver:
            return .crBackground
        case .owner:
            return .crRedBackground
        case .admin:
            return .crGreenBackground
        }
    }
}
