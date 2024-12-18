//
//  UserRegisterApproveCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct UserRegisterApproveCell: View {
    var user: UnApprovedUser
    
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
                    Text("회원가입 요청일: \(user.createdAt.toString())")
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
