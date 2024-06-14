//
//  KeyBoardResponder.swift
//  Dorae
//
//  Created by Damin on 6/12/24.
//

import SwiftUI
import Combine

@Observable
class KeyboardResponder {
    var isKeyboardVisible: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        let willShowPublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }

        let willHidePublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }

        Publishers.Merge(willShowPublisher, willHidePublisher)
            .receive(on: RunLoop.main)
            .assign(to: \.isKeyboardVisible, on: self)
            .store(in: &cancellableSet)
    }
}
