//
//  PreviewScreen.swift
//  EasyBill
//
//  Created by Francesco Sallia on 30.07.25.
//

import SwiftUI

struct PreviewScreen: View {
    let invoice: Invoice

    var body: some View {
        let pdfData = PDFHelper.generatePDF(from: invoice)
        PDFPreviewView(pdfData: pdfData)
            .edgesIgnoringSafeArea(.all)
    }
}
