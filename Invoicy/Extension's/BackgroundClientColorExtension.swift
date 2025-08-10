//
//  BackgroundClientColorExtension.swift
//  EasyBill
//
//  Created by Francesco Sallia on 14.07.25.
//

import Foundation
import SwiftUICore

extension Color {
    static func color(for string: String) -> Color {
        let hash = abs(string.hashValue)
        let hue = Double(hash % 256) / 255.0
        return Color(hue: hue, saturation: 0.6, brightness: 0.8)
    }
}
