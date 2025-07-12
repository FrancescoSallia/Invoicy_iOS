//
//  SignaturView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

// MARK: - SignatureView.swift – Geänderte Version

import SwiftUI

struct SignatureView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var drawing: Drawing
    @Binding var signatureImage: UIImage?

    @State private var drawings: [Drawing] = []

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Löschen") {
                    drawings = []
                }
                .tint(.red)

                Spacer()

                Text("Signatur")
                    .bold()

                Spacer()

                Button("Speichern") {
                    signatureImage = renderImage()
                    dismiss()
                }
                .buttonStyle(.borderless)
            }
            .padding()
            .padding(.top, 20)

            ZStack {
                Rectangle()
                    .strokeBorder(Color.gray, lineWidth: 4)
                    .background(Color.white)
                    .frame(height: 200)
                    .padding(.horizontal)

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
                .frame(height: 200)
            }
            .padding(.vertical)

            Text("Hier unterschreiben")
                .padding(.bottom)

            Spacer()
        }
    }

    private func renderImage() -> UIImage? {
        let renderer = ImageRenderer(content:
            ZStack {
                Color.white
                Canvas { context, size in
                    for drawing in drawings {
                        context.stroke(drawing.path, with: .color(.black), lineWidth: 2)
                    }
                }
            }
            .frame(width: 300, height: 200)
        )
        return renderer.uiImage
    }
}
//#Preview {
//    SignatureView()
//}
