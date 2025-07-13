//
//  BillViewModel.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI
import SwiftUICore

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
    @Published var showSignatureView = false

    @Published var drawing = Drawing()
    
    @Published var selectedTheme: ColorSchemeEnum = .system
    @Published var signatureImage: UIImage? = nil
    @Published var selectedImageItem: PhotosPickerItem? = nil
    
    //PhotoPicker
    @Published var photosPickerItem: PhotosPickerItem? = nil
    @Published var logoImage: UIImage? = nil
    
    @Environment(\.modelContext) var context

    
    var dummyBusinesses: [Business] = [
        Business(
            businessName: "TechNova GmbH",
            email: "info@technova.de",
            website: "www.technova.de",
            contactName: "Max Mustermann",
            phoneNumber: "+49 123 4567890",
            street: "Hauptstraße",
            houseNumber: "12A",
            postalCode: "10115",
            city: "Berlin",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 123456",
            ustIdNr: "DE123456789",
            vatApplicable: "Ja",
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "GreenSolutions AG",
            email: "kontakt@greensolutions.de",
            website: "https://greensolutions.de",
            contactName: "Erika Musterfrau",
            phoneNumber: "+49 987 654321",
            street: "Marktplatz",
            houseNumber: "7",
            postalCode: "80331",
            city: "München",
            country: "Deutschland",
            companyRegistrationNumber: "HRB 789101",
            ustIdNr: "DE987654321",
            vatApplicable: "Nein",
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        ),
        Business(
            businessName: "BauTech Solutions",
            email: "service@bautech.com",
            website: nil,
            contactName: nil,
            phoneNumber: "+49 222 333444",
            street: "Industriestraße",
            houseNumber: "15",
            postalCode: "50667",
            city: "Köln",
            country: "Deutschland",
            companyRegistrationNumber: nil,
            ustIdNr: nil,
            vatApplicable: nil,
            bankPayment: nil,
            logoImgData: nil,
            signatureImgData: nil
        )
    ]

    
    func loadUIImageLogo() async {
        let photoItem = self.photosPickerItem
           if let photoItem,
              let data = try? await photoItem.loadTransferable(type: Data.self) {
               if let image = UIImage(data: data){
                   self.logoImage = image
               }
           }
    }
    
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
    
    func newBusiness() -> Business?{
        guard !self.businessName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.houseNumber.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty, signatureImage != nil else { return nil }
        
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
            ustIdNr: self.ustIdNr.isEmpty ? nil : self.ustIdNr,
            logoImgData: self.logoImage?.pngData(),
            signatureImgData: self.signatureImage?.pngData()
        )
        print("Unternehmer gespeichert: \(business)")
//        self.dummyBusinesses.append(business)
        return business
    }
    
     func resetInputs() {
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
        self.signatureImage = nil
        self.logoImage = nil
        self.photosPickerItem = nil
    }
    


    
}
