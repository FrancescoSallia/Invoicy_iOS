//
//  SignatureCanvas.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftUICore
import SwiftUI


// MARK: - Signature Canvas Helper

struct SignatureCanvas: View {
    //    @State private var drawing = Drawing()
    @Binding var drawing: Drawing
    @State private var drawings: [Drawing] = []
    
    var body: some View {
        Canvas { context, size in
            for drawing in drawings {
                context.stroke(drawing.path, with: .color(.black), lineWidth: 2)
            }
            context.stroke(drawing.path, with: .color(.black), lineWidth: 2)
        }
        .gesture(DragGesture(minimumDistance: 0.1)
            .onChanged { value in
                drawing.points.append(value.location)
            }
            .onEnded { _ in
                drawings.append(drawing)
                drawing = Drawing()
            }
        )
//        .onReceive(NotificationCenter.default.publisher(for: .clearSignature)) { _ in
//            drawings = []
//        }
    }
    
    
//    extension Notification.Name {
//        static let clearSignature = Notification.Name("clearSignature")
//    }
}
