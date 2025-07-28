//
//  InvoiceTemplateClassicView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 28.07.25.
//

import SwiftUI
import UIKit

struct InvoicePrinter {    
    func druckeRechnung(invoice: Invoice) {
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "Rechnung \(invoice.invoiceNumber)"
        printController.printInfo = printInfo
        
        var html = """
        <html>
        <head>
            <meta charset="utf-8">
            <style>
                body {
                    font-family: -apple-system;
                    padding: 20px;
                    font-size: 14px;
                }
                h1 {
                    text-align: left;
                    font-size: 24px;
                }
                .info, .summary {
                    margin-top: 20px;
                    font-size: 13px;
                }
                .section-title {
                    font-weight: bold;
                    margin-top: 20px;
                    margin-bottom: 8px;
                    font-size: 15px;
                }
                .row {
                    display: flex;
                    justify-content: space-between;
                    padding: 4px 0;
                    border-bottom: 1px solid #eee;
                }
                .row-header {
                    font-weight: bold;
                    background: #f2f2f2;
                }
                .total {
                    font-weight: bold;
                    font-size: 16px;
                    margin-top: 10px;
                }
                .signature {
                    margin-top: 40px;
                }
                img.logo {
                    height: 60px;
                    margin-bottom: 10px;
                }
                .right {
                    text-align: right;
                }
            </style>
        </head>
        <body>
        """

        // Optional: Logo
        if let logoData = invoice.business.logoImgData,
           let base64 = logoData.base64EncodedString(options: .lineLength64Characters) as String? {
            html += "<img class=\"logo\" src=\"data:image/png;base64,\(base64)\">"
        }

        html += """
            <h1>RECHNUNG</h1>
            <div class="info">
                <div>Rechnungsnr.: \(invoice.invoiceNumber)</div>
                <div>Ausgestellt am: \(formatDate(invoice.issuedOn))</div>
                <div>Fällig am: \(formatDate(invoice.dueDate))</div>
            </div>

            <div class="section-title">Kunde</div>
            <div>\(invoice.client.clientName)</div>
            <div>\(invoice.client.contactName)</div>
            <div>\(invoice.client.street) \(invoice.client.houseNumber)</div>
            <div>\(invoice.client.postalCode) \(invoice.client.city)</div>

            <div class="section-title">Leistungen</div>
            <div class="row row-header">
                <div style="flex: 1;">Beschreibung</div>
                <div class="right" style="width: 60px;">Menge</div>
                <div class="right" style="width: 80px;">Preis</div>
                <div class="right" style="width: 80px;">Gesamt</div>
            </div>
        """

        for item in invoice.items {
            let lineTotal = Double(item.quantity) * item.price
            html += """
                <div class="row">
                    <div style="flex: 1;">\(item.itemName)<br><small>\(item.itemDescription)</small></div>
                    <div class="right" style="width: 60px;">\(item.quantity)</div>
                    <div class="right" style="width: 80px;">\(formatPrice(item.price, currency: invoice.currency))</div>
                    <div class="right" style="width: 80px;">\(formatPrice(lineTotal, currency: invoice.currency))</div>
                </div>
            """
        }

        let subtotal = invoice.items.reduce(0) { $0 + (Double($1.quantity) * $1.price) }

        html += """
            <div class="summary">
                <div class="row"><div>Zwischensumme</div><div>\(formatPrice(subtotal, currency: invoice.currency))</div></div>
                <div class="row"><div>Rabatt</div><div>-\(formatPrice(invoice.discount, currency: invoice.currency))</div></div>
                <div class="row"><div>Steuer</div><div>\(formatPrice(invoice.tax, currency: invoice.currency))</div></div>
                <div class="row total"><div>Gesamt</div><div>\(formatPrice(invoice.totalSummery, currency: invoice.currency))</div></div>
            </div>
        """

        // Unterschrift
        if let signatureData = invoice.business.signatureImgData,
           let base64 = signatureData.base64EncodedString(options: .lineLength64Characters) as String? {
            html += """
                <div class="signature">
                    <div>Unterschrift:</div>
                    <img src="data:image/png;base64,\(base64)" style="height: 60px;">
                </div>
            """
        }

        html += "</body></html>"

        let formatter = UIMarkupTextPrintFormatter(markupText: html)
        printController.printFormatter = formatter

        DispatchQueue.main.async {
            printController.present(animated: true, completionHandler: nil)
        }
    }

    private func formatPrice(_ price: Double, currency: String) -> String {
        return String(format: "\(currency) %.2f", price)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

//#Preview {
//    InvoicePrinter()
//}
