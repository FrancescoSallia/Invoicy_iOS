//
//  Business.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation

struct Business {
    
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
    var logoUrl: URL? = nil
    var signatureUrl: URL? = nil
}
