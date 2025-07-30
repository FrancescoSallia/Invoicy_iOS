//
//  InvoiceItem.swift
//  EasyBill
//
//  Created by Francesco Sallia on 16.07.25.
//

import Foundation
import SwiftData

@Model
class InvoiceItem: Identifiable {
    var id : UUID = UUID()
    var itemName: String
    var itemDescription: String
    var quantity: Int
    var unit: String // e.g hour, kg
    var price: Double
    
    @Relationship(inverse: \Invoice.items)
    var invoice: Invoice?
    
    init(id: UUID = UUID(), itemName: String, itemDescription: String, quantity: Int, unit: String, price: Double) {
        self.id = id
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.quantity = quantity
        self.unit = unit
        self.price = price
    }
}
