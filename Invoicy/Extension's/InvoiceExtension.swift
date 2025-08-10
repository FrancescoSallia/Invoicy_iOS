//
//  InvoiceExtension.swift
//  EasyBill
//
//  Created by Francesco Sallia on 08.08.25.
//

import Foundation

extension Invoice {
    static var previewInvoice: Invoice {
        // Beispiel BankPayment
        let bankPayment = BankPayment(
            accountHolder: "Musterfirma GmbH",
            bankName: "Deutsche Bank",
            iban: "DE89 3704 0044 0532 0130 00",
            accountNumber: "532013000",
            bic: "DEUTDEDBXXX"
        )
        
        // Beispiel Business
        let business = Business(
            businessName: "Musterfirma GmbH",
            email: "info@musterfirma.de",
            website: "www.musterfirma.de",
            contactName: "Erika Musterfrau",
            phoneNumber: "+49 30 123456",
            street: "Hauptstraße",
            houseNumber: "123",
            postalCode: "10115",
            city: "Berlin",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 123456",
            ustIdNr: "DE123456789",
            vatApplicable: "Ja",
            bankPayment: bankPayment
        )
        
        // Beispiel Client
        let client = Client(
            clientName: "Max Mustermann",
            email: "max@example.com",
            contactName: "Max Mustermann",
            phoneNumber: "+49 40 987654",
            street: "Nebenstraße",
            houseNumber: "45",
            postalCode: "20095",
            city: "Hamburg",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 987654",
            ustIdNr: "DE987654321"
        )
        
        // Beispiel Items
        let items = [
            InvoiceItem(itemName: "Webdesign", itemDescription: "Erstellung einer Firmenwebsite", quantity: 1, unit: "Stück", price: 1200),
            InvoiceItem(itemName: "Hosting", itemDescription: "12 Monate Hosting", quantity: 1, unit: "Paket", price: 120),
            InvoiceItem(itemName: "Wartung", itemDescription: "Monatliche Wartung für 6 Monate", quantity: 6, unit: "Monat", price: 50)
        ]
        
        // Summen berechnen
        let subtotal = items.reduce(0) { $0 + (Double($1.quantity) * $1.price) }
        let discount = 50.0
        let taxRate = 0.19
        let tax = (subtotal - discount) * taxRate
        let total = subtotal - discount + tax
        
        // Invoice zurückgeben
        return Invoice(
            business: business,
            client: client,
            invoiceName: "Rechnung Juli 2025",
            invoiceNumber: "INV/07/25/0002",
            currency: "EUR",
            issuedOn: Date(),
            dueDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
            items: items,
            discount: discount,
            tax: tax,
            totalSummery: total
        )
    }
}
