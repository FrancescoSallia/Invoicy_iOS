//
//  BillViewModel.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI
import SwiftUICore
import WebKit

@MainActor
class BillViewModel: ObservableObject {
    @Published var clientName = ""
    @Published var businessName = ""
    @Published var email = ""
    @Published var website = ""

    @Published var contactName = ""
    @Published var phoneNumber = ""

    @Published var street = ""
    @Published var houseNumber = ""
    @Published var postalCode = ""
    @Published var city = ""
    @Published var country = ""

    @Published var companyRegistrationNumber = ""
    @Published var ustIdNr = ""
    
    @Published var showAttentionIcon = false
    @Published var showAlert = false
    
    @Published var vatApplicable = ""
    @Published var showSignatureView = false

    @Published var drawing = Drawing()
    
    @Published var selectedTheme: ColorSchemeEnum = .system
    @Published var signatureImage: UIImage? = nil
    @Published var selectedImageItem: PhotosPickerItem? = nil
    
    //PhotoPicker
    @Published var photosPickerItem: PhotosPickerItem? = nil
    @Published var logoImage: UIImage? = nil
    
    //BANK-TextFieldInputs
    @Published var isToggledBank: Bool = false

    @Published var accountHolder: String = ""
    @Published var bankName: String = ""
    @Published var iban: String = ""
    @Published var accountNumber: String = ""
    @Published var bic: String = ""
    
    @Published var focusedField: FieldFocusEnum?

    //Invoice
    @Published var invoiceName: String = ""
    @Published var invoiceNumber: String = ""
    @Published var currency: CurrencyEnum = .euro
    @Published var discount: Double? = nil
    @Published var tax: Double? = nil
    @Published var totalSummery: Double = 0.0
    
    //Invoice Item
    @Published var itemName: String = ""
    @Published var itemDescription: String = ""
    @Published var quantity: Int = 1
    @Published var unit: String = ""
    @Published var price: Double = 0.0
    
    @Published var currentInvoiceItem: InvoiceItem? = nil
    
    @Published var businessItemSelected: Business? = nil
    @Published var clientItemSelected: Client? = nil
    
    @Published var selectedBusinessFromSheet: String? = nil
    @Published var selectedClientFromSheet: String? = nil
    
    @Published var currentInvoiceCount = 0
    
    @Published var showBusinessSheet = false
    @Published var showClientSheet = false
    @Published var showObjectSheet = false
    @Published var showShareSheet = false


    
    
    
    var selectedClient: Client? = Client(
        clientName: "ACME GmbH",
        email: "info@acme.de",
        website: "www.acme.de",
        contactName: "Max Mustermann",
        phoneNumber: "+49 123 456789",
        street: "Musterstraße",
        houseNumber: "1a",
        postalCode: "12345",
        city: "Berlin",
        country: "Deutschland",
        companyRegistrationNumber: "HRB 98765",
        ustIdNr: "DE123456789"
    )
    
    var selectedIssuedOn: Date = Date.now
    var selectedDueDate: Date = Date.now.addingTimeInterval(86400)
    
    
    @Published var invoiceItems: [InvoiceItem] = [
//        InvoiceItem(
//            itemName: "Pizza Margherita",
//            itemDescription: "mit Mozzarella, Tomatensauce, Basilikum",
//            quantity: 2,
//            unit: "Stück",
//            price: 12.50
//        ),
//        InvoiceItem(
//            itemName: "Pizza Tonno",
//            itemDescription: "mit Mozzarella, Tomatensauce, Basilikum und Thunfisch",
//            quantity: 4,
//            unit: "Stück",
//            price: 15.50
//        )
    ]
  
    var dummyBusinesses: [Business] = [
        Business(
            businessName: "TechNova GmbH",
            email: "info@technova.de",
            website: "www.technova.de",
            contactName: "Max Mustermann",
            phoneNumber: "+49 123 4567890",
            street: "Hauptstraße",
            houseNumber: "12A",
            postalCode: "10115",
            city: "Berlin",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 123456",
            ustIdNr: "DE123456789",
            vatApplicable: "Ja",
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "GreenSolutions AG",
            email: "kontakt@greensolutions.de",
            website: "https://greensolutions.de",
            contactName: "Erika Musterfrau",
            phoneNumber: "+49 987 654321",
            street: "Marktplatz",
            houseNumber: "7",
            postalCode: "80331",
            city: "München",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 789101",
            ustIdNr: "DE987654321",
            vatApplicable: "Nein",
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "BauTech Solutions",
            email: "service@bautech.com",
            website: nil,
            contactName: nil,
            phoneNumber: "+49 222 333444",
            street: "Industriestraße",
            houseNumber: "15",
            postalCode: "50667",
            city: "Köln",
            country: "Deutschland",
            companyRegistrationNumber: nil,
            ustIdNr: nil,
            vatApplicable: nil,
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "TochNova GmbH",
            email: "ha@technova.de",
            website: "www.technova.de",
            contactName: "Max Mustermann",
            phoneNumber: "+49 123 4567890",
            street: "Hauptstraße",
            houseNumber: "12A",
            postalCode: "10115",
            city: "Berlin",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 123456",
            ustIdNr: "DE123456789",
            vatApplicable: "Ja",
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "SaeenSolutions AG",
            email: "see@greensolutions.de",
            website: "https://greensolutions.de",
            contactName: "Erika Musterfrau",
            phoneNumber: "+49 987 654321",
            street: "Marktplatz",
            houseNumber: "7",
            postalCode: "80331",
            city: "München",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 789101",
            ustIdNr: "DE987654321",
            vatApplicable: "Nein",
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "ZyuTech Solutions",
            email: "services@bautech.com",
            website: nil,
            contactName: nil,
            phoneNumber: "+49 222 333444",
            street: "Industriestraße",
            houseNumber: "15",
            postalCode: "50667",
            city: "Köln",
            country: "Deutschland",
            companyRegistrationNumber: nil,
            ustIdNr: nil,
            vatApplicable: nil,
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "Solut Solutions",
            email: "info@bautech2.com",
            website: nil,
            contactName: nil,
            phoneNumber: "+49 222 333444",
            street: "Industriestraße",
            houseNumber: "15",
            postalCode: "50667",
            city: "Köln",
            country: "Deutschland",
            companyRegistrationNumber: nil,
            ustIdNr: nil,
            vatApplicable: nil,
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "RechSpide backpack",
            email: "Rech@bautech.com",
            website: nil,
            contactName: nil,
            phoneNumber: "+49 222 333444",
            street: "Industriestraße",
            houseNumber: "15",
            postalCode: "50667",
            city: "Köln",
            country: "Deutschland",
            companyRegistrationNumber: nil,
            ustIdNr: nil,
            vatApplicable: nil,
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        )
    ]
    
    func textFieldsAreEmpty() -> Bool {
        let hasIBAN = !self.iban.isEmpty
        let hasAccountNumberAndBIC = !self.accountNumber.isEmpty && !self.bic.isEmpty
        
        guard !self.businessName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.houseNumber.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty, signatureImage != nil else {
            ErrorHandler.shared.showValidationError("Überprüfe deine Eingaben!")
            return false
        }
        
        if isToggledBank {
            guard !self.accountHolder.isEmpty,  hasIBAN || hasAccountNumberAndBIC else { return false }
        }
        return true
    }
    
    func updateBusiness(_ business: Business) {
        business.businessName = self.businessName
        business.email = self.email
        business.website = self.website.isEmpty ? nil : self.website
        business.contactName = self.contactName
        business.phoneNumber = self.phoneNumber
        business.street = self.street
        business.houseNumber = self.houseNumber
        business.postalCode = self.postalCode
        business.city = self.city
        business.country = self.country
        business.companyRegistrationNumber = self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber
        business.ustIdNr = self.ustIdNr.isEmpty ? nil : self.ustIdNr
        business.vatApplicable = self.vatApplicable.isEmpty ? nil : self.vatApplicable
        business.logoImgData = self.logoImage?.pngData()
        business.signatureImgData = self.signatureImage?.pngData()

        if self.isToggledBank {
            business.bankPayment = BankPayment(
                accountHolder: self.accountHolder,
                bankName: self.bankName,
                iban: self.iban,
                accountNumber: self.accountNumber,
                bic: self.bic
            )
        } else {
            business.bankPayment = nil
        }
    }
    
    func updateClient(_ client: Client) {
        client.clientName = self.clientName
        client.email = self.email
        client.website = self.website.isEmpty ? nil : self.website
        client.contactName = self.contactName
        client.phoneNumber = self.phoneNumber
        client.street = self.street
        client.houseNumber = self.houseNumber
        client.postalCode = self.postalCode
        client.city = self.city
        client.country = self.country
        client.companyRegistrationNumber = self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber
        client.ustIdNr = self.ustIdNr.isEmpty ? nil : self.ustIdNr
    }
    
    func updateInvoiceItem(_ invoiceItem: InvoiceItem) {
        invoiceItem.itemName = self.itemName
        invoiceItem.itemDescription = self.itemDescription
        invoiceItem.quantity = self.quantity
        invoiceItem.unit = self.unit
        invoiceItem.price = self.price
    }
    
    func updateInvoice(_ invoice: Invoice) {
        // Business und Client dürfen nicht geändert werden, falls du das nicht möchtest,
        // sonst kannst du sie hier auch updaten:
        invoice.business = self.businessItemSelected!
        invoice.client = self.clientItemSelected!
        
        invoice.invoiceName = self.invoiceName
        invoice.invoiceNumber = self.invoiceNumber
        invoice.currency = self.currency.rawValue
        invoice.issuedOn = self.selectedIssuedOn
        invoice.dueDate = self.selectedDueDate
        
        // InvoiceItems updaten – hier kommt’s darauf an, ob du die Liste komplett ersetzen
        // oder die einzelnen Items bearbeiten willst:
        invoice.items = self.invoiceItems
        
        invoice.discount = self.discount ?? 0
        invoice.tax = self.tax ?? 0
        invoice.totalSummery = self.totalSummery
    }
    
    func getEditableBusiness(business: Business) {
        self.businessName = business.businessName
        self.email = business.email
        self.website = business.website ?? ""
        self.contactName = business.contactName ?? ""
        self.phoneNumber = business.phoneNumber
        self.street = business.street
        self.houseNumber = business.houseNumber
        self.postalCode = business.postalCode
        self.city = business.city
        self.country = business.country
        self.companyRegistrationNumber = business.companyRegistrationNumber ?? ""
        self.ustIdNr = business.ustIdNr ?? ""
        
        self.accountHolder = business.bankPayment?.accountHolder ?? ""
        self.bankName = business.bankPayment?.bankName ?? ""
        self.iban = business.bankPayment?.iban ?? ""
        self.accountNumber = business.bankPayment?.accountNumber ?? ""
        self.bic = business.bankPayment?.bic ?? ""
        
        self.logoImage = business.logoImg
        self.signatureImage = business.signatureImg
    }

    func getEditableClient(client: Client) {
        self.clientName = client.clientName
        self.email = client.email
        self.website = client.website ?? ""
        self.contactName = client.contactName
        self.phoneNumber = client.phoneNumber
        self.street = client.street
        self.houseNumber = client.houseNumber
        self.postalCode = client.postalCode
        self.city = client.city
        self.country = client.country
        self.companyRegistrationNumber = client.companyRegistrationNumber ?? ""
        self.ustIdNr = client.ustIdNr ?? ""
    }
    
    func getEditableInvoiceItem(invoiceItem: InvoiceItem) {
        self.itemName = invoiceItem.itemName
        self.itemDescription = invoiceItem.itemDescription
        self.quantity = invoiceItem.quantity
        self.unit = invoiceItem.unit
        self.price = invoiceItem.price
    }
    
    func loadUIImageLogo() async {
        let photoItem = self.photosPickerItem
           if let photoItem,
              let data = try? await photoItem.loadTransferable(type: Data.self) {
               if let image = UIImage(data: data){
                   self.logoImage = image
               }
           }
    }
    
    func newClient() -> Client? {
        guard !self.clientName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty else {
            ErrorHandler.shared.showValidationError("Bitte überprüfe deine Eingaben. Der Kunde konnte nicht gespeichert werden.")
            return nil
        }
        
        let client = Client(
            clientName: self.clientName,
            email: self.email,
            website: self.website.isEmpty ? nil : self.website,
            contactName: self.contactName,
            phoneNumber: self.phoneNumber,
            street: self.street,
            houseNumber: self.houseNumber,
            postalCode: self.postalCode,
            city: self.city,
            country: self.country,
            companyRegistrationNumber: self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber,
            ustIdNr: self.ustIdNr.isEmpty ? nil : self.ustIdNr
        )
        print("Kunde gespeichert: \(client)")
        return client
    }
    
    func newBusiness() -> Business?{
        let hasIBAN = !self.iban.isEmpty
        let hasAccountNumberAndBIC = !self.accountNumber.isEmpty && !self.bic.isEmpty
        
        guard !self.businessName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.houseNumber.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty, signatureImage != nil else {
            ErrorHandler.shared.showValidationError("Bitte überprüfe deine Eingaben. Der Geschäftskontakt konnte nicht gespeichert werden.")
            return nil
        }
        
        if isToggledBank {
            guard !self.accountHolder.isEmpty,  hasIBAN || hasAccountNumberAndBIC else { return nil }
        }
        let bank = BankPayment(
            accountHolder: self.accountHolder,
            bankName: self.bankName,
            iban: self.iban,
            accountNumber: self.accountNumber,
            bic: self.bic
        )
        
        let business = Business(
            businessName: self.businessName,
            email: self.email,
            website: self.website.isEmpty ? nil : self.website,
            contactName: self.contactName,
            phoneNumber: self.phoneNumber,
            street: self.street,
            houseNumber: self.houseNumber,
            postalCode: self.postalCode,
            city: self.city,
            country: self.country,
            companyRegistrationNumber: self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber,
            ustIdNr: self.ustIdNr.isEmpty ? nil : self.ustIdNr,
            bankPayment: isToggledBank ? bank : nil,
            logoImgData: self.logoImage?.pngData(),
            signatureImgData: self.signatureImage?.pngData()
        )
        print("Unternehmer gespeichert: \(business)")
//        self.dummyBusinesses.append(business)
        return business
    }
    
    func newInvoiceItem() -> InvoiceItem {
        return InvoiceItem(
            id: currentInvoiceItem?.id ?? UUID(),
            itemName: self.itemName,
            itemDescription: self.itemDescription,
            quantity: self.quantity,
            unit: self.unit,
            price: self.price
        )
    }
    
    func newInvoice() -> Invoice? {
        guard
            self.businessItemSelected != nil,
            self.clientItemSelected != nil,
            !self.invoiceName.isEmpty,
            !self.invoiceNumber.isEmpty,
            !self.invoiceItems.isEmpty,
            self.tax != nil || self.tax ?? 0 <= 0
        else { return nil }
        
        let itemsAdded = self.invoiceItems
        
        let newInvoice = Invoice(
            business: self.businessItemSelected!,
            client: self.clientItemSelected!,
            invoiceName: self.invoiceName,
            invoiceNumber: self.invoiceNumber,
            currency: self.currency.rawValue,
            issuedOn: self.selectedIssuedOn,
            dueDate: self.selectedDueDate,
            items: itemsAdded,
            discount: self.discount ?? 0,
            tax: self.tax ?? 0,
            totalSummery: self.totalSummery
        )
        return newInvoice
    }
    
    func loadInvoice(_ invoice: Invoice) {
        self.invoiceName = invoice.invoiceName
        self.invoiceNumber = invoice.invoiceNumber
        self.businessItemSelected = invoice.business
        self.clientItemSelected = invoice.client
        self.currency = CurrencyEnum(rawValue: invoice.currency) ?? .euro
        self.selectedIssuedOn = invoice.issuedOn
        self.selectedDueDate = invoice.dueDate
        self.invoiceItems = invoice.items
        self.discount = invoice.discount
        self.tax = invoice.tax
        self.totalSummery = invoice.totalSummery
    }
    
    func resetInputsInvoiceFrom() {
        self.businessItemSelected = nil
        self.clientItemSelected = nil
        self.invoiceName = ""
        self.invoiceItems = []
        self.discount = nil
        self.tax = nil
    }
    
     func resetInputsClientAndBusiness() {
        self.clientName = ""
        self.businessName = ""
        self.email = ""
        self.website = ""
        self.contactName = ""
        self.phoneNumber = ""
        self.street = ""
        self.houseNumber = ""
        self.postalCode = ""
        self.city = ""
        self.country = ""
        self.companyRegistrationNumber = ""
        self.ustIdNr = ""
        self.vatApplicable = ""
        self.showAttentionIcon = false
        self.signatureImage = nil
        self.logoImage = nil
        self.photosPickerItem = nil
        self.accountHolder = ""
        self.bankName = ""
        self.iban = ""
        self.accountNumber = ""
        self.bic = ""
    }
    
    func resetInvoiceItems() {
        self.itemName = ""
        self.itemDescription = ""
        self.quantity = 1
        self.unit = ""
        self.price = 0.0
        self.currentInvoiceItem = nil
        
    }
    
    func calculateSubtotal(_ invoiceItems: [InvoiceItem]) -> String {
        let totalWithoutDiscount = invoiceItems.reduce(0.0) { result, item in
            result + item.price * Double(item.quantity)
        }
        return String(format: "%.2f", totalWithoutDiscount)
    }
    
    func calculateTotal(_ invoiceItems: [InvoiceItem], discount: Double?) -> String {
        let totalWithoutDiscount = invoiceItems.reduce(0.0) { result, item in
            result + item.price * Double(item.quantity)
        }
        
        // Wenn Rabatt vorhanden, wende ihn auf den Gesamtbetrag an
        let total: Double
        if let discount = discount {
            total = totalWithoutDiscount * (1 - (discount / 100))
        } else {
            total = totalWithoutDiscount
        }
        return String(format: "%.2f", total)
    }
    
    func calculateDiscountAmount(_ invoiceItems: [InvoiceItem], discounT: Double?) -> String {
        guard let discount = discounT, discount > 0 else {
            return "0.00"
        }
        let totalWithoutDiscount = invoiceItems.reduce(0.0) { result, item in
            result + item.price * Double(item.quantity)
        }
        let discountAmount = totalWithoutDiscount * ((discounT ?? 0) / 100)
        return String(format: "%.2f", discountAmount)
    }
    
    func calculateTaxAmount(_ invoiceItems: [InvoiceItem], taX: Double?, discounT: Double?) -> String {
        guard let tax = taX, tax > 0 else {
            return "0.00"
        }

        // 1. Zwischensumme
        let subtotal = invoiceItems.reduce(0.0) { result, item in
            result + item.price * Double(item.quantity)
        }

        // 2. Rabatt anwenden (falls vorhanden)
        let discountedSubtotal: Double
        if let discount = discounT, discount > 0 {
            discountedSubtotal = subtotal * (1 - discount / 100)
        } else {
            discountedSubtotal = subtotal
        }

        // 3. Steuer auf rabattierten Betrag berechnen
        let taxAmount = discountedSubtotal * (tax / 100)

        return String(format: "%.2f", taxAmount)
    }
 
    // Diese Funktion könnte den letzten Zählerwert ermitteln und um 1 erhöhen.
    func generateInvoiceNumber(existingInvoices: [Invoice]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let dateString = dateFormatter.string(from: self.selectedIssuedOn)

        // Zähle vorhandene Rechnungen an dem Tag (oder insgesamt, je nach Wunsch)
        let countForToday = existingInvoices.filter {
            Calendar.current.isDate($0.issuedOn, inSameDayAs: self.selectedIssuedOn)
        }.count

        let newNumber = String(format: "%03d", countForToday + 1)
        let invoiceNum = "INV-\(dateString)-\(newNumber)"
        self.invoiceNumber = invoiceNum
        return invoiceNum
    }
    
    
//HTML Invoice
    func htmlInvoiceContent(invoice: Invoice) -> String {
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
        
        return html
    }

    private func formatPrice(_ price: Double, currency: String) -> String {
        return String(format: "\(currency) %.2f", price)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func renderHTMLToPDF(html: String, completion: @escaping (URL?) -> Void) {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 595, height: 842)) // A4 size in points (72 dpi)
        webView.loadHTMLString(html, baseURL: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // warten bis geladen
            let config = WKPDFConfiguration()
            config.rect = CGRect(x: 0, y: 0, width: 595, height: 842) // A4

            webView.createPDF(configuration: config) { result in
                switch result {
                case .success(let data):
                    let url = FileManager.default.temporaryDirectory.appendingPathComponent("RechnungPreview.pdf")
                    try? data.write(to: url)
                    completion(url)
                case .failure(let error):
                    ErrorHandler.shared.showValidationError("Fehler beim PDF-Rendern: \(error)")
                    print("Fehler beim PDF-Rendern: \(error)")
                    completion(nil)
                }
            }
        }
    }

    
}
