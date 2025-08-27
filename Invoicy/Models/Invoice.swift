//
//  Invoice.swift
//  EasyBill
//
//  Created by Francesco Sallia on 16.07.25.
//

import Foundation
import SwiftData

@Model
class Invoice {
    
    @Relationship(deleteRule: .noAction)
    var business: Business? = nil

    @Relationship(deleteRule: .noAction)
    var client: Client? = nil
    
    //Invoice Details
    var invoiceName: String
    var invoiceNumber: String // INV/07/25/0002
    var currency: String
    var issuedOn: Date //Herausgegeben am
    var dueDate: Date // Fälligkeitsdatum
    
    //Invoice Items
    @Relationship(deleteRule: .cascade)
    var items: [InvoiceItem]
    
    //Amounts Summary
    var discount: Double
    var tax: Double
    var totalSummery: Double
    var status: InvoiceStatusEnum
    
    init(business: Business? = nil, client: Client? = nil, invoiceName: String, invoiceNumber: String, currency: String, issuedOn: Date, dueDate: Date, items: [InvoiceItem], discount: Double, tax: Double, totalSummery: Double, status: InvoiceStatusEnum = .Open ) {
        self.business = business
        self.client = client
        self.invoiceName = invoiceName
        self.invoiceNumber = invoiceNumber
        self.currency = currency
        self.issuedOn = issuedOn
        self.dueDate = dueDate
        self.items = items
        self.discount = discount
        self.tax = tax
        self.totalSummery = totalSummery
        self.status = status
    }
}
