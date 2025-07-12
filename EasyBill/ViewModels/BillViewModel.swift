//
//  BillViewModel.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import Foundation
import UIKit

@MainActor
class BillViewModel: ObservableObject {
    
    @Published var clientName = ""
    @Published var businessName = ""
    @Published var email = ""
    @Published var website = ""

    @Published var contactName = ""
    @Published var phoneNumber = ""

    @Published var street = ""
    @Published var houseNumber = ""
    @Published var postalCode = ""
    @Published var city = ""
    @Published var country = ""

    @Published var companyRegistrationNumber = ""
    @Published var ustIdNr = ""
    
    @Published var showAttentionIcon = false
    
    @Published var vatApplicable = ""
    @Published var logoImage: UIImage? = nil
    @Published var showImagePicker = false
    @Published var showSignatureView = false

    @Published var drawing = Drawing()
    
    @Published var selectedTheme: ColorSchemeEnum = .system
    @Published var signatureImage: UIImage? = nil

    
    
    func newClient() {
        guard !self.clientName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty else { return }
        
        
        let client = Client(
            clientName: self.clientName,
            email: self.email,
            website: self.website.isEmpty ? nil : self.website,
            contactName: self.contactName,
            phoneNumber: self.phoneNumber,
            street: self.street,
            houseNumber: self.houseNumber,
            postalCode: self.postalCode,
            city: self.city,
            country: self.country,
            companyRegistrationNumber: self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber,
            ustIdNr: self.ustIdNr.isEmpty ? nil : self.ustIdNr
        )
        print("Kunde gespeichert: \(client)")
        resetInputs()
    }
    
    func newBusiness() {
        guard !self.businessName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.houseNumber.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty else { return }
        
        
        let business = Business(
            businessName: self.businessName,
            email: self.email,
            website: self.website.isEmpty ? nil : self.website,
            contactName: self.contactName,
            phoneNumber: self.phoneNumber,
            street: self.street,
            houseNumber: self.houseNumber,
            postalCode: self.postalCode,
            city: self.city,
            country: self.country,
            companyRegistrationNumber: self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber,
            ustIdNr: self.ustIdNr.isEmpty ? nil : self.ustIdNr
        )
        print("Unternehmer gespeichert: \(business)")
        resetInputs()
    }
    
   private func resetInputs() {
        self.clientName = ""
        self.businessName = ""
        self.email = ""
        self.website = ""
        self.contactName = ""
        self.phoneNumber = ""
        self.street = ""
        self.houseNumber = ""
        self.postalCode = ""
        self.city = ""
        self.country = ""
        self.companyRegistrationNumber = ""
        self.ustIdNr = ""
        self.vatApplicable = ""
        self.showAttentionIcon = false

    }

    
}
