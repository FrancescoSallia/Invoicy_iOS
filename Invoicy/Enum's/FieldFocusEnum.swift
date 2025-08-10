//
//  FieldFocusEnum.swift
//  EasyBill
//
//  Created by Francesco Sallia on 15.07.25.
//

import Foundation

enum FieldFocusEnum: Hashable {
    case businessName, clientName, email, website,
         contactName, phoneNumber,
         street, houseNumber, postalCode, city, country,
         companyRegistrationNumber, ustIdNr, vatApplicable,
         accountHolder, bankName, iban, accountNumber, bic
}
