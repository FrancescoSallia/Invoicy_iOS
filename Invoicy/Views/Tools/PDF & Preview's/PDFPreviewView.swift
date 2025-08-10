//
//  PDFPreviewView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 30.07.25.
//

import SwiftUI
import PDFKit

// Vorschau einer PDF mit PDFKit
struct PDFPreviewView: UIViewRepresentable {
    let pdfData: Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: pdfData)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(data: pdfData)
    }
}
