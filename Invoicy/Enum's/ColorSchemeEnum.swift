//
//  ColorSchemeEnum.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftUICore

enum ColorSchemeEnum: String, CaseIterable, Identifiable {
    case system, light, dark
    var id: String { rawValue }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
