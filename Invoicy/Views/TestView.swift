//
//  TestView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 14.07.25.
//

import SwiftUI

struct TestView: View {
    @State private var showPreview = false
    @State private var pdfURL: URL?

    var body: some View {
        VStack {
            Button("Klick me") {
                let url = generatePDF()
                self.pdfURL = url
                self.showPreview = true
            }
        }
        .sheet(isPresented: $showPreview) {
            if let pdfURL = pdfURL {
            } else {
                Text("Fehler beim Laden der PDF-Datei")
            }
        }
    }
}

func generatePDF() -> URL {
    let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842)) // A4 @ 72 DPI
    let url = FileManager.default.temporaryDirectory.appendingPathComponent("Rechnung.pdf")

    try? renderer.writePDF(to: url, withActions: { context in
        context.beginPage()

        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18)
        ]
        let text = "Rechnung\n\nKunde: Max Mustermann\nLeistung: Design\nBetrag: 150,00 €"
        text.draw(at: CGPoint(x: 50, y: 50), withAttributes: attributes)
    })

    return url
}


#Preview {
    TestView()
}
