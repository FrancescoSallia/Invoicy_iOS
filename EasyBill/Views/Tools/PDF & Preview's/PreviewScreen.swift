//
//  PreviewScreen.swift
//  EasyBill
//
//  Created by Francesco Sallia on 30.07.25.
//

import SwiftUI

struct PreviewScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    let invoice: Invoice
    let viewModel: BillViewModel

    var body: some View {
        Spacer()

        let pdfData = PDFHelper.generatePDF(from: invoice, with: viewModel)
        PDFPreviewView(pdfData: pdfData)
            .edgesIgnoringSafeArea(.all)
        
        ScrollView(.horizontal) {
            HStack {
                Button {
                    PDFHelper.printPDF(data: pdfData)
                } label: {
                    Image(systemName: "printer.fill")
                }
                
                Button {
                    context.delete(invoice)
                    try? context.save()
                    dismiss()
                } label: {
                    Image(systemName: "trash.fill")
                }
                Button {
                   //LOGIK Einbauen
                } label: {
                    Image(systemName: "pencil.and.scribble")
                }
                .tint(.primary)
            }
        }
        Spacer()
    }
}
