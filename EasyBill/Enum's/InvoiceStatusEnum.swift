//
//  InvoiceStatusEnum.swift
//  EasyBill
//
//  Created by Francesco Sallia on 08.08.25.
//

import Foundation

enum InvoiceStatusEnum: String, Codable {
    case Open
    case Paid
}

enum InvoiceFilter: String, CaseIterable {
    case all = "All"
    case Open = "Open"
    case Paid = "Paid"
}
