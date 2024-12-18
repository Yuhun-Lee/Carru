//
//  String+Date_ISO_8601.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

extension String {
    /// admin 가입승인에서 Date가 소숫점까지 나옴으로 잘라서 사용
    func toISO8601Date() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        
        // 소수점 이하 초 제거
        let cleanedString = self.split(separator: ".").first.map { String($0) + "Z" } ?? self
        return formatter.date(from: cleanedString)
    }
    
    /// ISO 8601 스타일 String을 Date로 변환 (리턴값마다 값이 달라서 위 함수와 비슷하지만 변형)
    func toDateFromISO8601() -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600) // KST (UTC+9)
        return formatter.date(from: self)
    }
    
    /// AI 서버 시간 포멧을 String으로 변경
    func aiServerDateToISOString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600) // KST (UTC+9)
        
        guard let date = inputFormatter.date(from: self) else {
            return nil // 변환 실패 시 nil 반환
        }
        
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600) // KST (UTC+9)
        
        return isoFormatter.string(from: date)
    }
    
    func toDeadlineFormat() -> String? {
        // ISO8601DateFormatter를 사용해 입력 문자열을 Date 객체로 변환
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = isoFormatter.date(from: self) else {
            // DateFormatter를 사용해 다시 시도
            let fallbackFormatter = DateFormatter()
            fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            fallbackFormatter.locale = Locale(identifier: "en_US_POSIX")
            fallbackFormatter.timeZone = TimeZone(secondsFromGMT: 0) // 입력 값이 UTC 기준
            
            guard let fallbackDate = fallbackFormatter.date(from: self) else {
                return nil // 변환 실패
            }
            return formatToKoreanDateString(from: fallbackDate)
        }
        
        return formatToKoreanDateString(from: date)
    }
    
    private func formatToKoreanDateString(from date: Date) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600) // KST (UTC+9)
        
        return outputFormatter.string(from: date)
    }
}
