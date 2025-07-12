//
//  ClientFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct ClientFormView: View {
    @State private var clientName = ""
    @State private var email = ""
    @State private var website = ""

    @State private var contactName = ""
    @State private var phoneNumber = ""

    @State private var street = ""
    @State private var postalCode = ""
    @State private var city = ""
    @State private var country = ""

    @State private var companyRegistrationNumber = ""
    @State private var ustIdNr = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Allgemein")) {
                    TextField("Firmenname", text: $clientName)
                    TextField("E-Mail", text: $email)
                    TextField("Website", text: $website)
                }

                Section(header: Text("Kontaktperson")) {
                    TextField("Name", text: $contactName)
                    TextField("Telefonnummer", text: $phoneNumber)
                }

                Section(header: Text("Adresse")) {
                    TextField("Straße", text: $street)
                    TextField("Postleitzahl", text: $postalCode)
                    TextField("Stadt", text: $city)
                    TextField("Land", text: $country)
                }

                Section(header: Text("Steuerinformationen")) {
                    TextField("Handelsregisternummer (Co. Reg. No.)", text: $companyRegistrationNumber)
                    TextField("USt-IdNr. (VAT Reg. No.)", text: $ustIdNr)
                }

                Section {
                    Button("Kunde speichern") {
                        let client = Client(
                            clientName: clientName,
                            email: email,
                            website: website.isEmpty ? nil : website,
                            contactName: contactName,
                            phoneNumber: phoneNumber,
                            street: street,
                            postalCode: postalCode,
                            city: city,
                            country: country,
                            companyRegistrationNumber: companyRegistrationNumber.isEmpty ? nil : companyRegistrationNumber,
                            ustIdNr: ustIdNr.isEmpty ? nil : ustIdNr
                        )
                        print("Kunde gespeichert: \(client)")
                    }
                }
            }
        }
    }
}

#Preview {
    ClientFormView()
}
