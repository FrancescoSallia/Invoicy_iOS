//
//  Business.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftData
import UIKit

@Model
class Business {
    
    var businessName: String
    var email: String
    var website: String? = nil
    
    //Kontaktinformation
    var contactName: String? = nil
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
    var vatApplicable: String? = nil // VAT Applicable“ bedeutet auf Deutsch: „Mehrwertsteuer anwendbar“ oder „Umsatzsteuerpflichtig“
    
    //Zahlungsdetails
    var bankPayment: BankPayment? = nil
    var logoImgData: Data? = nil
    var signatureImgData: Data? = nil
    
    init(businessName: String, email: String, website: String? = nil, contactName: String? = nil, phoneNumber: String, street: String, houseNumber: String, postalCode: String, city: String, country: String, companyRegistrationNumber: String? = nil, ustIdNr: String? = nil, vatApplicable: String? = nil, bankPayment: BankPayment? = nil, logoImgData: Data? = nil, signatureImgData: Data? = nil) {
        self.businessName = businessName
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
        self.vatApplicable = vatApplicable
        self.bankPayment = bankPayment
        self.logoImgData = logoImgData
        self.signatureImgData = signatureImgData
    }
    
    //FIXME: Diesen teil unten erstmal ausprobieren
    @Relationship(deleteRule: .cascade, inverse: \Invoice.business)
        var invoices: [Invoice] = []
}
