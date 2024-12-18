//
//  AdminTotalDriverCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct AdminTotalDriverCell: View {
    var user: ApprovedUser
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.pretendardTitle)
                    Text("전화번호: \(user.phoneNumber)")
                        .font(.pretendardDescription)
                        .foregroundStyle(.crGray2)
                    Text("이메일: \(user.email)")
                        .font(.pretendardDescription)
                        .foregroundStyle(.crGray2)
                    Text("차고지: \(user.location)")
                        .font(.pretendardDescription)
                        .foregroundStyle(.crGray2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)

        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}

