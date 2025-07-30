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
    
    //Generiert eine PDF Vorschau
    static func generatePDF(from invoice: Invoice, with viewModel: BillViewModel) -> Data {
        return InvoicePrinter(viewModel: viewModel).generateInvoicePDF(invoice)
    }
    
    // Diese Funktion dient dazu das man die ganze PDF Datei denn auch drucken kann.
    static func printPDF(data: Data) {
          let printController = UIPrintInteractionController.shared
          let printInfo = UIPrintInfo(dictionary: nil)
          printInfo.jobName = "Rechnung drucken"
          printInfo.outputType = .general
          printController.printInfo = printInfo
          printController.printingItem = data

          DispatchQueue.main.async {
              printController.present(animated: true, completionHandler: nil)
          }
      }
}
