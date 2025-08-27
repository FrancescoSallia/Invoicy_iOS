//
//  Client.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftData

@Model
class Client {
    
    var clientName: String
    var email: String
    var website: String? = nil
    
    //Kontaktinformation
    var contactName: String
    var phoneNumber: String
    
    //Adressedetails
    var street: String
    var houseNumber: String
    var postalCode: String
    var city: String
    var country: String
    
    //tax details
    var companyRegistrationNumber : String? = nil // Co. Reg. No. = Company Registration Number
    var ustIdNr: String? = nil //  VAT Reg. No. = Umsatzsteuer-Identifikationsnummer (USt-IdNr.)
    
    var isArchived: Bool = false
    
    init(clientName: String, email: String, website: String? = nil, contactName: String, phoneNumber: String, street: String, houseNumber: String, postalCode: String, city: String, country: String, companyRegistrationNumber: String? = nil, ustIdNr: String? = nil, isArchived: Bool = false) {
        self.clientName = clientName
        self.email = email
        self.website = website
        self.contactName = contactName
        self.phoneNumber = phoneNumber
        self.street = street
        self.houseNumber = houseNumber
        self.postalCode = postalCode
        self.city = city
        self.country = country
        self.companyRegistrationNumber = companyRegistrationNumber
        self.ustIdNr = ustIdNr
        self.isArchived = isArchived
    }
    
    @Relationship(deleteRule: .noAction, inverse: \Invoice.client)
    var invoices: [Invoice] = []
    
}
