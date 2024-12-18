//
//  CommonResponse.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/19/24.
//

import Foundation

struct CommonResponse: Decodable {
    let resultCode: String
    let message: String
    let data: String?
}
