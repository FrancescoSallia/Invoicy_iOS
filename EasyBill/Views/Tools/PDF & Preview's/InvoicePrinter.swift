//
//  InvoiceTemplateClassicView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 28.07.25.
//

import SwiftUI
import UIKit
import PDFKit

struct InvoicePrinter {
    
    @ObservedObject var viewModel: BillViewModel

    /// Generates a PDF as native elements using PDFKit + UIGraphicsPDFRenderer.
    /// Returns PDF data.
    func generateInvoicePDF(_ invoice: Invoice) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "EasyBill",
            kCGPDFContextAuthor: invoice.business.businessName,
            kCGPDFContextTitle: "Rechnung \(invoice.invoiceNumber)"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth: CGFloat = 595.2
        let pageHeight: CGFloat = 841.8
        let padding: CGFloat = 30
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { context in
            context.beginPage()
            let ctx = context.cgContext
            var y: CGFloat = padding

            // MARK: - Fonts
            let titleFont = UIFont.boldSystemFont(ofSize: 24)
            let boldFont = UIFont.boldSystemFont(ofSize: 14)
            let regularFont = UIFont.systemFont(ofSize: 12)
            let footerFont = UIFont.systemFont(ofSize: 11)

            // MARK: - Draw Functions
            func drawText(_ text: String, font: UIFont, x: CGFloat, y: inout CGFloat) {
                let attrs: [NSAttributedString.Key: Any] = [.font: font]
                let size = text.size(withAttributes: attrs)
                text.draw(at: CGPoint(x: x, y: y), withAttributes: attrs)
                y += size.height + 4
            }

            func drawRightText(_ text: String, font: UIFont, y: CGFloat, inset: CGFloat = padding) {
                let attrs: [NSAttributedString.Key: Any] = [.font: font]
                let size = text.size(withAttributes: attrs)
                let x = pageWidth - inset - size.width
                text.draw(at: CGPoint(x: x, y: y), withAttributes: attrs)
            }

            func drawCenteredText(_ text: String, font: UIFont, y: CGFloat) {
                let attrs: [NSAttributedString.Key: Any] = [.font: font]
                let size = text.size(withAttributes: attrs)
                let x = (pageWidth - size.width) / 2
                text.draw(at: CGPoint(x: x, y: y), withAttributes: attrs)
            }

            func drawDivider(_ y: inout CGFloat) {
                ctx.setStrokeColor(UIColor.lightGray.cgColor)
                ctx.setLineWidth(0.5)
                ctx.move(to: CGPoint(x: padding, y: y))
                ctx.addLine(to: CGPoint(x: pageWidth - padding, y: y))
                ctx.strokePath()
                y += 10
            }

            // MARK: - Header
            let headerY = y
            drawText("RECHNUNG", font: titleFont, x: padding, y: &y)
            drawRightText("Nr.: \(invoice.invoiceNumber)", font: regularFont, y: headerY)
            drawRightText("Datum: \(formatDate(invoice.issuedOn))", font: regularFont, y: headerY + 18)
            y += 8
            drawDivider(&y)

            // MARK: - Customer + Business Info (Side by side)
            let customerX = padding
            let businessX = pageWidth / 2 + 20
            var infoY = y

            let customerLines = [
                invoice.client.clientName,
                invoice.client.contactName,
                "\(invoice.client.street) \(invoice.client.houseNumber)",
                "\(invoice.client.postalCode) \(invoice.client.city)"
            ]

            for line in customerLines {
                drawText(line, font: regularFont, x: customerX, y: &infoY)
            }

            let businessLines = [
                invoice.business.businessName,
                invoice.business.email,
                invoice.business.phoneNumber
            ]

            var rightY = y
            for line in businessLines {
                drawRightText(line, font: regularFont, y: rightY)
                rightY += regularFont.lineHeight + 4
            }

            y = max(infoY, rightY)
            
            y += 50
            
            drawDivider(&y)

            // MARK: - Items Table Header
            let leftX = padding
            let qtyX = pageWidth * 0.55
            let priceX = pageWidth * 0.70
            let totalX = pageWidth * 0.85

            // --- Begin new paginated items logic ---
            let itemLineHeight = regularFont.lineHeight + 2
            let maxY = pageHeight - 160 // reserve space for footer
            let totalItems = invoice.items.count
            var currentPage = 1
            let totalPages = Int(ceil(Double(totalItems * Int(itemLineHeight)) / Double(maxY - y)))

            func drawPageNumber() {
                let pageNumberText = "\(currentPage)/\(totalPages)"
                drawCenteredText(pageNumberText, font: footerFont, y: pageHeight - 30)
            }

            // Draw table headers
            "Beschreibung".draw(at: CGPoint(x: leftX, y: y), withAttributes: [.font: boldFont])
            "Menge".draw(at: CGPoint(x: qtyX, y: y), withAttributes: [.font: boldFont])
            "Preis".draw(at: CGPoint(x: priceX, y: y), withAttributes: [.font: boldFont])
            "Gesamt".draw(at: CGPoint(x: totalX, y: y), withAttributes: [.font: boldFont])
            y += boldFont.lineHeight + 6
            drawDivider(&y)

            // Draw items
            for (index, item) in invoice.items.enumerated() {
                if y + itemLineHeight > maxY {
                    drawPageNumber()
                    context.beginPage()
                    y = padding
                    currentPage += 1

                    // Optionally re-draw table headers on each page
                    "Beschreibung".draw(at: CGPoint(x: leftX, y: y), withAttributes: [.font: boldFont])
                    "Menge".draw(at: CGPoint(x: qtyX, y: y), withAttributes: [.font: boldFont])
                    "Preis".draw(at: CGPoint(x: priceX, y: y), withAttributes: [.font: boldFont])
                    "Gesamt".draw(at: CGPoint(x: totalX, y: y), withAttributes: [.font: boldFont])
                    y += boldFont.lineHeight + 6
                    drawDivider(&y)
                }

                let lineTotal = Double(item.quantity) * item.price
                item.itemName.draw(at: CGPoint(x: leftX, y: y), withAttributes: [.font: regularFont])
                "\(item.quantity)".draw(at: CGPoint(x: qtyX, y: y), withAttributes: [.font: regularFont])
                formatPrice(item.price, currency: CurrencyEnum.symbol(from: invoice.currency)).draw(at: CGPoint(x: priceX, y: y), withAttributes: [.font: regularFont])
                formatPrice(lineTotal, currency: CurrencyEnum.symbol(from: invoice.currency)).draw(at: CGPoint(x: totalX, y: y), withAttributes: [.font: regularFont])
                y += itemLineHeight

                // After last item, draw rest of invoice (summary, signature, footer)
                if index == totalItems - 1 {
                    y += 20
                    drawDivider(&y)

                    let subtotal = invoice.items.reduce(0) { $0 + (Double($1.quantity) * $1.price) }

                    func drawSummary(label: String, value: String, bold: Bool = false) {
                        let font = bold ? boldFont : regularFont
                        drawRightText(label, font: font, y: y, inset: 160)
                        drawRightText(value, font: font, y: y)
                        y += font.lineHeight + 4
                    }

                    drawSummary(label: "Zwischensumme:", value: formatPrice(subtotal, currency: CurrencyEnum.symbol(from: invoice.currency)))
                    if invoice.discount > 0 {
                        drawSummary(label: "Rabatt(%):", value: "-\(String(format: "%.0f", invoice.discount))")
                    }
                    drawSummary(label: "MwSt.(%):", value: String(format: "%.0f", invoice.tax))
                    drawSummary(label: "Gesamtbetrag (inkl.MwSt):", value: viewModel.calculateTotal(invoice.items, discount: invoice.discount))

                    y += 10
                    drawText("Fällig am: \(formatDate(invoice.dueDate))", font: regularFont, x: padding, y: &y)

                    if let signatureData = invoice.business.signatureImgData,
                       let signatureImage = UIImage(data: signatureData) {
                        drawText("Unterschrift:", font: regularFont, x: padding, y: &y)
                        let maxHeight: CGFloat = 50
                        let scale = maxHeight / signatureImage.size.height
                        let size = CGSize(width: signatureImage.size.width * scale, height: maxHeight)
                        signatureImage.draw(in: CGRect(x: padding, y: y, width: size.width, height: size.height))
                        y += size.height + 8
                    }

                    var footerY = pageHeight - 80
                    drawDivider(&footerY)
                    invoice.business.businessName.draw(at: CGPoint(x: leftX, y: footerY), withAttributes: [.font: boldFont])

                    if let bank = invoice.business.bankPayment {
                        var bankLines: [String] = []
                        bankLines.append(bank.accountHolder)

                        if !bank.iban.isEmpty {
                            bankLines.append("IBAN: \(bank.iban)")
                        } else {
                            if !bank.accountNumber.isEmpty {
                                bankLines.append("Konto: \(bank.accountNumber)")
                            }
                            if !bank.bic.isEmpty {
                                bankLines.append("BIC: \(bank.bic)")
                            }
                        }
                        bankLines.append(bank.bankName)

                        var centerY = footerY
                        for line in bankLines {
                            drawCenteredText(line, font: footerFont, y: centerY)
                            centerY += footerFont.lineHeight + 2
                        }
                    }

                    var contactLines: [String] = [invoice.business.email]
                    if let website = invoice.business.website {
                        contactLines.append(website)
                    }
                    contactLines.append("Tel.: \(invoice.business.phoneNumber)")

                    var contactY = footerY
                    for line in contactLines {
                        drawRightText(line, font: footerFont, y: contactY, inset: padding)
                        contactY += footerFont.lineHeight + 2
                    }

                    drawPageNumber()
                }
            }
            // --- End new paginated items logic ---
        }

        return data
    }
    
    func druckeRechnung(invoice: Invoice) {
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "Rechnung \(invoice.invoiceNumber)"
        printController.printInfo = printInfo

        // ✅ Statt doppeltem Code einfach die Methode nutzen
        let html = generateInvoiceHtml(invoice)
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
    
    func generateInvoiceHtml(_ invoice: Invoice) -> String {
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
                    <img src="data:image/png;base64,\(base64)" style="height: 60px; width: auto; display: block; margin-top: 10px;">
                </div>
            """
        }

        html += "</body></html>"
        print("Signature is \(invoice.business.signatureImgData != nil ? "available" : "nil")")
        
        return html
    }
}

//#Preview {
//    InvoicePrinter()
//}


//<img src="data:image/png;base64,\(base64)" style="height: 60px;">
