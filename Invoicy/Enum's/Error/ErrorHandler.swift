//
//  ErrorHandler.swift
//  Invoicy
//
//  Created by Francesco Sallia on 10.08.25.
//

import SwiftUI

@MainActor
class ErrorHandler: ObservableObject {
    static let shared = ErrorHandler()

    @Published var currentError: ErrorEnum?

    func handle(error: Error) {
        currentError = ErrorEnum(from: error)
    }

    func showValidationError(_ message: String) {
        Task { @MainActor in
               self.currentError = .validation(message)
           }
    }
}
