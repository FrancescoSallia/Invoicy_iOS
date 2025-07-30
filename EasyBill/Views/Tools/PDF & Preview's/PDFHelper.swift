//
//  PDFHelper.swift
//  EasyBill
//
//  Created by Francesco Sallia on 30.07.25.
//

import SwiftUI
import PDFKit

// PDF-Helfer zur Erzeugung aus HTML
struct PDFHelper {
    static func generatePDF(from invoice: Invoice, with viewModel: BillViewModel) -> Data {
        return InvoicePrinter(viewModel: viewModel).generateInvoicePDF(invoice)
    }
}
