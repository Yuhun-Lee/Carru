//
//  DatePickerView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import SwiftUI

struct CarruDatePickerView: View {
    @Binding var targetDate: Date
    
    var body: some View {
        HStack(spacing: 8) {
//            Text("날짜 입력")
//                .font(.pretendardBody)
//                .padding(.horizontal, 20)
            
            DatePicker("", selection: $targetDate, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .padding(.horizontal, 20)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    @Previewable @State var a = Date()
    
    CarruDatePickerView(targetDate: $a)
}
