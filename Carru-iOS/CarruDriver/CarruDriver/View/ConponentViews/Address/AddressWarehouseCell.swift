//
//  AddressWarehouseCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/29/24.
//

import SwiftUI

struct AddressWarehouseCell: View {
    let isSelected: Bool
    let warehouse: Warehouse
    
    var icon: String? = "checkmark.circle.fill"
    var iconColor: Color = .gray
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(warehouse.name)
                    .font(.pretendardCaption)
                Text(warehouse.location)
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
