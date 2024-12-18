//
//  CommonResponse.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct CommonErrorResponse: Decodable {
    let resultCode: String
    let message : String
    let data: String?
//    let data: EmptyData?
}

struct EmptyData: Codable {}


