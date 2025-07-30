//
//  PreviewScreen.swift
//  EasyBill
//
//  Created by Francesco Sallia on 30.07.25.
//

import SwiftUI

struct PreviewScreen: View {
    let invoice: Invoice
    let viewModel: BillViewModel

    var body: some View {
        let pdfData = PDFHelper.generatePDF(from: invoice, with: viewModel)
        PDFPreviewView(pdfData: pdfData)
            .edgesIgnoringSafeArea(.all)
    }
}
