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
    
    //BANK-TextFieldInputs
    @Published var isToggledBank: Bool = false

    @Published var accountHolder: String = ""
    @Published var bankName: String = ""
    @Published var iban: String = ""
    @Published var accountNumber: String = ""
    @Published var bic: String = ""
    
    @Published var focusedField: FieldFocusEnum?

    //Invoice
    @Published var invoiceName: String = ""
    @Published var invoiceNumber: String = ""
    @Published var currency: CurrencyEnum = .euro
    @Published var discount: Double = 0.0
    @Published var tax: Double = 0.0
    @Published var totalSummery: Double = 0.0
    
    //Invoice Item
    @Published var itemName: String = ""
    @Published var itemDescription: String = ""
    @Published var quantity: Int = 1
    @Published var unit: String = ""
    @Published var price: Double = 0.0
    
    @Published var currentInvoiceItem: InvoiceItem? = nil
    
    @Published var businessItemSelected: Business? = nil
    @Published var clientItemSelected: Client? = nil
    
    @Published var selectedBusinessFromSheet: String? = nil
    @Published var selectedClientFromSheet: String? = nil
    
    
    
    var selectedClient: Client? = Client(
        clientName: "ACME GmbH",
        email: "info@acme.de",
        website: "www.acme.de",
        contactName: "Max Mustermann",
        phoneNumber: "+49 123 456789",
        street: "Musterstraße",
        houseNumber: "1a",
        postalCode: "12345",
        city: "Berlin",
        country: "Deutschland",
        companyRegistrationNumber: "HRB 98765",
        ustIdNr: "DE123456789"
    )
    
    var selectedIssuedOn: Date = Date.now
    var selectedDueDate: Date = Date.now.addingTimeInterval(86400)
    
    
    @Published var invoiceItems: [InvoiceItem] = [
        InvoiceItem(
            itemName: "Pizza Margherita",
            itemDescription: "mit Mozzarella, Tomatensauce, Basilikum",
            quantity: 2,
            unit: "Stück",
            price: 12.50
        ),
        InvoiceItem(
            itemName: "Pizza Tonno",
            itemDescription: "mit Mozzarella, Tomatensauce, Basilikum und Thunfisch",
            quantity: 4,
            unit: "Stück",
            price: 15.50
        )
    ]
  
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
        ),
        Business(
            businessName: "TochNova GmbH",
            email: "ha@technova.de",
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
            businessName: "SaeenSolutions AG",
            email: "see@greensolutions.de",
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
            businessName: "ZyuTech Solutions",
            email: "services@bautech.com",
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
        ),
        Business(
            businessName: "Solut Solutions",
            email: "info@bautech2.com",
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
        ),
        Business(
            businessName: "RechSpide backpack",
            email: "Rech@bautech.com",
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
    
    func textFieldsAreEmpty() -> Bool {
        let hasIBAN = !self.iban.isEmpty
        let hasAccountNumberAndBIC = !self.accountNumber.isEmpty && !self.bic.isEmpty
        
        guard !self.businessName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.houseNumber.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty, signatureImage != nil else { return false }
        
        if isToggledBank {
            guard !self.accountHolder.isEmpty,  hasIBAN || hasAccountNumberAndBIC else { return false }
        }
        return true
    }
    
    func updateBusiness(_ business: Business) {
        business.businessName = self.businessName
        business.email = self.email
        business.website = self.website.isEmpty ? nil : self.website
        business.contactName = self.contactName
        business.phoneNumber = self.phoneNumber
        business.street = self.street
        business.houseNumber = self.houseNumber
        business.postalCode = self.postalCode
        business.city = self.city
        business.country = self.country
        business.companyRegistrationNumber = self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber
        business.ustIdNr = self.ustIdNr.isEmpty ? nil : self.ustIdNr
        business.vatApplicable = self.vatApplicable.isEmpty ? nil : self.vatApplicable
        business.logoImgData = self.logoImage?.pngData()
        business.signatureImgData = self.signatureImage?.pngData()

        if self.isToggledBank {
            business.bankPayment = BankPayment(
                accountHolder: self.accountHolder,
                bankName: self.bankName,
                iban: self.iban,
                accountNumber: self.accountNumber,
                bic: self.bic
            )
        } else {
            business.bankPayment = nil
        }
    }
    
    func updateClient(_ client: Client) {
        client.clientName = self.clientName
        client.email = self.email
        client.website = self.website.isEmpty ? nil : self.website
        client.contactName = self.contactName
        client.phoneNumber = self.phoneNumber
        client.street = self.street
        client.houseNumber = self.houseNumber
        client.postalCode = self.postalCode
        client.city = self.city
        client.country = self.country
        client.companyRegistrationNumber = self.companyRegistrationNumber.isEmpty ? nil : self.companyRegistrationNumber
        client.ustIdNr = self.ustIdNr.isEmpty ? nil : self.ustIdNr
    }
    
    func updateInvoiceItem(_ invoiceItem: InvoiceItem) {
        invoiceItem.itemName = self.itemName
        invoiceItem.itemDescription = self.itemDescription
        invoiceItem.quantity = self.quantity
        invoiceItem.unit = self.unit
        invoiceItem.price = self.price
    }
    
    func getEditableBusiness(business: Business) {
        self.businessName = business.businessName
        self.email = business.email
        self.website = business.website ?? ""
        self.contactName = business.contactName ?? ""
        self.phoneNumber = business.phoneNumber
        self.street = business.street
        self.houseNumber = business.houseNumber
        self.postalCode = business.postalCode
        self.city = business.city
        self.country = business.country
        self.companyRegistrationNumber = business.companyRegistrationNumber ?? ""
        self.ustIdNr = business.ustIdNr ?? ""
        
        self.accountHolder = business.bankPayment?.accountHolder ?? ""
        self.bankName = business.bankPayment?.bankName ?? ""
        self.iban = business.bankPayment?.iban ?? ""
        self.accountNumber = business.bankPayment?.accountNumber ?? ""
        self.bic = business.bankPayment?.bic ?? ""
        
        self.logoImage = business.logoImg
        self.signatureImage = business.signatureImg
    }

    func getEditableClient(client: Client) {
        self.clientName = client.clientName
        self.email = client.email
        self.website = client.website ?? ""
        self.contactName = client.contactName
        self.phoneNumber = client.phoneNumber
        self.street = client.street
        self.houseNumber = client.houseNumber
        self.postalCode = client.postalCode
        self.city = client.city
        self.country = client.country
        self.companyRegistrationNumber = client.companyRegistrationNumber ?? ""
        self.ustIdNr = client.ustIdNr ?? ""
    }
    
    func getEditableInvoiceItem(invoiceItem: InvoiceItem) {
        self.itemName = invoiceItem.itemName
        self.itemDescription = invoiceItem.itemDescription
        self.quantity = invoiceItem.quantity
        self.unit = invoiceItem.unit
        self.price = invoiceItem.price
    }
    
    
    func loadUIImageLogo() async {
        let photoItem = self.photosPickerItem
           if let photoItem,
              let data = try? await photoItem.loadTransferable(type: Data.self) {
               if let image = UIImage(data: data){
                   self.logoImage = image
               }
           }
    }
    
    func newClient() -> Client? {
        guard !self.clientName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty else { return nil }
        
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
        return client
    }
    
    func newBusiness() -> Business?{
        let hasIBAN = !self.iban.isEmpty
        let hasAccountNumberAndBIC = !self.accountNumber.isEmpty && !self.bic.isEmpty
        
        guard !self.businessName.isEmpty, !self.email.isEmpty, !self.phoneNumber.isEmpty, !self.street.isEmpty, !self.houseNumber.isEmpty, !self.postalCode.isEmpty, !self.city.isEmpty, !self.country.isEmpty, !contactName.isEmpty, signatureImage != nil else { return nil }
        
        if isToggledBank {
            guard !self.accountHolder.isEmpty,  hasIBAN || hasAccountNumberAndBIC else { return nil }
        }
        let bank = BankPayment(
            accountHolder: self.accountHolder,
            bankName: self.bankName,
            iban: self.iban,
            accountNumber: self.accountNumber,
            bic: self.bic
        )
        
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
            bankPayment: isToggledBank ? bank : nil,
            logoImgData: self.logoImage?.pngData(),
            signatureImgData: self.signatureImage?.pngData()
        )
        print("Unternehmer gespeichert: \(business)")
//        self.dummyBusinesses.append(business)
        return business
    }
    
    func newInvoiceItem() -> InvoiceItem {
        let newItem = InvoiceItem(
            itemName: self.itemName,
            itemDescription: self.itemDescription,
            quantity: self.quantity,
            unit: self.unit,
            price: self.price
        )
        return newItem
    }
    
     func resetInputsClientAndBusiness() {
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
        self.accountHolder = ""
        self.bankName = ""
        self.iban = ""
        self.accountNumber = ""
        self.bic = ""
    }
    
    func resetInvoiceItems() {
        self.itemName = ""
        self.itemDescription = ""
        self.quantity = 1
        self.unit = ""
        self.price = 0.0
        self.currentInvoiceItem = nil
        
    }
    
    func calculateSubtotal(_ invoiceItems: [InvoiceItem]) -> String {
        var total: Double = 0.0
        
        invoiceItems.forEach { item in
          total += item.price * Double(item.quantity)
        }
        
        return String(format: "%.2f", total)
    }
    


    
}
