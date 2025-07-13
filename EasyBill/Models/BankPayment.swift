//
//  BankPayment.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftData

@Model
class BankPayment {
    
    var accountHolder: String
    var bankName: String
    var iban: String
    var accountNumber: String
    var bic: String
    
    init(accountHolder: String, bankName: String, iban: String, accountNumber: String, bic: String) {
        self.accountHolder = accountHolder
        self.bankName = bankName
        self.iban = iban
        self.accountNumber = accountNumber
        self.bic = bic
    }
    
}
