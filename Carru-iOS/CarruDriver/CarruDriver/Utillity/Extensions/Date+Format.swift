//
//  Date+Format.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import Foundation

extension Date {
    
    /// AI, AM,PM 포멧
    func toString() -> String {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy년 MM월 dd일 h:mm a" // 12시간 체제와 AM/PM 포함 포맷
        formatter.locale = Locale(identifier: "en_US_POSIX") // 일관된 결과를 위해 설정
        formatter.timeZone = TimeZone.current // 현지 시간대 설정

        let formattedDate = formatter.string(from: self)
        
        return formattedDate
    }

    
    func diffFromNow() -> String {
        let now = Date()
        let difference = abs(self.timeIntervalSince(now))
        
        let hours = Int(difference) / 3600
        let minutes = (Int(difference) % 3600) / 60
        let seconds = Int(difference) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func formatToKoreanDateString() -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600) // KST (UTC+9)
        
        return outputFormatter.string(from: self)
    }
}
