//
//  AddressDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation

struct AddressResponseDTO: Decodable {
    let results: Results
    
    struct Results: Decodable {
        let common: Common
        let juso: [Juso]
        
        struct Common: Decodable {
            let errorMessage: String
            let countPerPage: String
            let totalCount: String
            let errorCode: String
            let currentPage: String
        }
        
        struct Juso: Decodable {
            let detBdNmList: String
            let engAddr: String
            let rn: String
            let emdNm: String
            let zipNo: String
            let roadAddrPart2: String
            let emdNo: String
            let sggNm: String
            let jibunAddr: String
            let siNm: String
            let roadAddrPart1: String
            let bdNm: String
            let admCd: String
            let udrtYn: String
            let lnbrMnnm: String
            let roadAddr: String
            let lnbrSlno: String
            let buldMnnm: String
            let bdKdcd: String
            let liNm: String
            let rnMgtSn: String
            let mtYn: String
            let bdMgtSn: String
            let buldSlno: String
        }
    }
    
    func toAddresses() -> [String] {
        return results.juso.map {
            return $0.roadAddrPart1
//            Address(
//                streetAddress: $0.roadAddrPart1,
//                lotAddress: $0.jibunAddr
//            )
        }
    }
}
