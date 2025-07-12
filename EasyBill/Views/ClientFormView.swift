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
                    HStack {
                        Text("Firmenname")
                        TextField("z. B. ACME GmbH", text: $clientName, prompt: Text("z. B. ACME GmbH"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("E-Mail")
                        TextField("z. B. info@acme.de", text: $email, prompt: Text("z. B. info@acme.de"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Website")
                        TextField("z. B. acme.de", text: $website, prompt: Text("z. B. acme.de"))
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("Kontaktperson")) {
                    HStack {
                        Text("Name")
                        TextField("z. B. Max Mustermann", text: $contactName, prompt: Text("z. B. Max Mustermann"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Telefonnummer")
                        TextField("z. B. +49 123 456789", text: $phoneNumber, prompt: Text("z. B. +49 123 456789"))
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("Adresse")) {
                    HStack {
                        Text("Straße")
                        TextField("z. B. Musterstraße 1", text: $street, prompt: Text("z. B. Musterstraße 1"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Postleitzahl")
                        TextField("z. B. 12345", text: $postalCode, prompt: Text("z. B. 12345"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Stadt")
                        TextField("z. B. Berlin", text: $city, prompt: Text("z. B. Berlin"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Land")
                        TextField("z. B. Deutschland", text: $country, prompt: Text("z. B. Deutschland"))
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("Steuerinformationen")) {
                    HStack {
                        Text("Handelsregisternummer")
                        TextField("z. B. HRB 123456", text: $companyRegistrationNumber, prompt: Text("z. B. HRB 123456"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("USt-IdNr.")
                        TextField("z. B. DE123456789", text: $ustIdNr, prompt: Text("z. B. DE123456789"))
                            .multilineTextAlignment(.trailing)
                    }
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
