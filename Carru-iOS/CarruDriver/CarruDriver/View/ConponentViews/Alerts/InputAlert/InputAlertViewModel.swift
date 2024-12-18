//
//  InputAlertViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation
import SwiftUI

@Observable
class InputAlertViewModel: ObservableObject {
    var text: String
    var title: String
    var cancelAction: (() -> ())?
    var confirmAction: ((String) -> ())?
    
    init(
        text: String = "",
        title: String = "제목",
        cancelAction: (() -> Void)? = nil,
        confirmAction: ((String) -> Void)? = nil
    ) {
        self.text = text
        self.title = title
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
}
