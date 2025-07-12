//
//  Client.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation

struct Client {
    
    var clientName: String
    var email: String
    var website: String? = nil
    
    //Kontaktinformation
    var contactName: String
    var phoneNumber: String
    
    //Adressedetails
    var street: String
    var postalCode: String
    var city: String
    var country: String
    
    //tax details
    var companyRegistrationNumber : String? = nil // Co. Reg. No. = Company Registration Number
    var ustIdNr: String? = nil //  VAT Reg. No. = Umsatzsteuer-Identifikationsnummer (USt-IdNr.)
    
}
