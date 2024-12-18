//
//  RouteMatchingListCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/21/24.
//

import SwiftUI

struct RouteMatchingListCell: View {
    var reservation: RouteReservation
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    // 출발 시간 표시
                    Text("출발 예정 시간: \(formattedStartTime(reservation.startTime))")
                        .font(.pretendardTitle)
                    
                    // 출발지와 도착지 표시
                    Text(reservation.title)
                        .font(.pretendardTitle)
                    
                    // 총 운송 정보 표시
                    Text(reservation.description)
                        .font(.pretendardDescription)
                        .foregroundStyle(.crGray2)
                }
                
                Spacer()
                
                // 우측 화살표 아이콘
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)
        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    /// 출발 시간을 포맷팅하는 함수
    private func formattedStartTime(_ iso8601String: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
        if let date = formatter.date(from: iso8601String) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "yyyy년 M월 d일 HH시 mm분"
            return displayFormatter.string(from: date)
        }
        return iso8601String // 포맷팅 실패 시 원본 반환
    }
}
