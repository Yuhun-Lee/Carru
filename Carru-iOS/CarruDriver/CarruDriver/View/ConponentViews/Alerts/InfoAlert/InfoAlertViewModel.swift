//
//  InfoAlertViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation

@Observable
class InfoAlertViewModel {
    var title: String
    var description: String
    var cancelAction: (() -> ())?
    var confirmAction: (() -> ())?
    var isOnlyConfirm: Bool
    
    init(
        title: String = "제목",
        description: String = "상세",
        cancelAction: (() -> Void)? = nil,
        confirmAction: (() -> Void)? = nil,
        isOnlyConfirm: Bool = false
    ) {
        self.title = title
        self.description = description
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
        self.isOnlyConfirm = isOnlyConfirm
    }
}
