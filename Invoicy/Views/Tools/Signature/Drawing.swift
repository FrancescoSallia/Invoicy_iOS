//
//  Drawing.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftUICore

struct Drawing {
    var points: [CGPoint] = []

    var path: Path {
        var path = Path()
        guard let first = points.first else { return path }
        path.move(to: first)
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        return path
    }
}
