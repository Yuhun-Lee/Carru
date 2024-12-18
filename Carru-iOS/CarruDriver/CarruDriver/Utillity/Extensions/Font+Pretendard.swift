//
//  Font+Pretendard.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI

extension Font {
    enum PretendardWeight {
        case black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin
    }
    
    static func pretendard(size: CGFloat, weight: PretendardWeight = .regular) -> Font {
        let fontName: String
        switch weight {
        case .black:
            fontName = "Pretendard-Black"
        case .bold:
            fontName = "Pretendard-Bold"
        case .extraBold:
            fontName = "Pretendard-ExtraBold"
        case .extraLight:
            fontName = "Pretendard-ExtraLight"
        case .light:
            fontName = "Pretendard-Light"
        case .medium:
            fontName = "Pretendard-Medium"
        case .regular:
            fontName = "Pretendard-Regular"
        case .semiBold:
            fontName = "Pretendard-SemiBold"
        case .thin:
            fontName = "Pretendard-Thin"
        }
        
        return Font.custom(fontName, size: size)
    }
    
    // 미리 정의된 예시 폰트 스타일
    static var pretendardTitle: Font { pretendard(size: 15, weight: .bold) }
    static var pretendardDescription: Font { pretendard(size: 13, weight: .light) }
    
    
    static var pretendardExtraBoldTitle: Font { pretendard(size: 24, weight: .extraBold) }
    static var pretendardBody: Font { pretendard(size: 16, weight: .regular) }
    static var pretendardCaption: Font { pretendard(size: 16, weight: .bold) }
}

