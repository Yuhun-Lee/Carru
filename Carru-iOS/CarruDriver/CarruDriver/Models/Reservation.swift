//
//  Reservation.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/13/24.
//

import Foundation

struct Reservation: Hashable {
    var id: String
    var logistics: [Logistic]
}
