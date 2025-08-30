//
//  ErrorEnum.swift
//  Invoicy
//
//  Created by Francesco Sallia on 10.08.25.
//

import Foundation

enum ErrorEnum: Error, Identifiable, LocalizedError {
    var id: String { localizedDescription }

    case validation(String)    // z.B. Pflichtfeld fehlt
    case network(String)       // z.B. Server nicht erreichbar
    case unknown(String)       // z.B. unerwarteter Fehler

    init(from error: Error) {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            self = .network("Network error: \(nsError.localizedDescription)")
        } else {
            self = .unknown(error.localizedDescription)
        }
    }

    var errorDescription: String? {
        switch self {
        case .validation(let message):
            return message
        case .network(let message):
            return message
        case .unknown(let message):
            return message
        }
    }

    var title: String {
        switch self {
        case .validation:
            return NSLocalizedString("error_title_validation", comment: "Title for validation errors")
        case .network:
            return NSLocalizedString("error_title_network", comment: "Title for network errors")
        case .unknown:
            return NSLocalizedString("error_title_unknown", comment: "Title for unknown errors")
        }
    }
}
