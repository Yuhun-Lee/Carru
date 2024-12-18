//
//  AddressCellView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI

struct AddressCellView: View {
    let isSelected: Bool
    let address: String
    
    var icon: String? = "checkmark.circle.fill"
    var iconColor: Color = .gray
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                Text(address)
                    .font(.pretendardCaption)
            }
            
            Spacer()
            
            if let icon = icon {
                Image(systemName: icon)
                    .padding(.trailing, 10)
                    .foregroundColor(isSelected ? iconColor : .gray)
            }
        }
    }
}
