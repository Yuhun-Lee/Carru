//
//  MatchLogisticsViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation

@Observable
class MatchLogisticsViewModel {
    var maxWeight: String = ""
    var minWeight: String = ""
    
    var maxWeightInt: Int {
        return Int(maxWeight) ?? 0
    }
    
    var minWeightInt: Int {
        return Int(minWeight) ?? 0
    }
}
