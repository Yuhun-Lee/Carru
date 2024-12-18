//
//  LogisticProgressView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct LogisticProgressView: View {
    let type: ProgressType
    
    var body: some View {
        HStack() {
            Text("TODO")
                .font(.pretendard(size: 12, weight: .bold))
                .frame(maxWidth: .infinity)
                .frame(width: 70, height: 30)
                .foregroundStyle(textColorCheck(type: .todo))
                .background(backgroundColorCheck(type: .todo))
                .clipShape(.rect(cornerRadius: 10))
            
            Text("IN PROGRESS")
                .font(.pretendard(size: 12, weight: .bold))
                .frame(maxWidth: .infinity)
                .frame(width: 100, height: 30)
                .foregroundStyle(textColorCheck(type: .inProgress))
                .background(backgroundColorCheck(type: .inProgress))
                .clipShape(.rect(cornerRadius: 10))
            
            Text("FINISHED")
                .font(.pretendard(size: 12, weight: .bold))
                .frame(maxWidth: .infinity)
                .frame(width: 70, height: 30)
                .foregroundStyle(textColorCheck(type: .finished))
                .background(backgroundColorCheck(type: .finished))
                .clipShape(.rect(cornerRadius: 10))
        }
    }
    
    private func textColorCheck(type: ProgressType) -> Color {
        if self.type == type {
            return Color.white
        } else {
            return Color.appTypeColor
        }
    }
    
    private func backgroundColorCheck(type: ProgressType) -> Color {
        if self.type == type {
            return Color.appTypeColor
        } else {
            return Color.appTypeBackgroundColor
        }
    }
}

#Preview {
    LogisticProgressView(type: .inProgress)
}
