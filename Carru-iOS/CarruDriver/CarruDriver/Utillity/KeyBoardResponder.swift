//
//  KeyBoardResponder.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/3/24.
//

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        // 키보드가 나타날 때
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.height
                }
            }
            .store(in: &cancellableSet)
        
        // 키보드가 사라질 때
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                self.keyboardHeight = 0
            }
            .store(in: &cancellableSet)
    }
}
