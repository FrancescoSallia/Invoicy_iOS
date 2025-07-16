//
//  EditClientView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 15.07.25.
//

import SwiftUI
import SwiftData

struct EditClientView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    var clientDetail: Client

    var body: some View {
        NavigationStack {
            Form {
                // Allgemein
                Section(header: Text("Allgemein")) {
                    HStack {
                        Text("Kundenname:")
                        TextField("z. B. ACME GmbH", text: $viewModel.clientName)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.clientName.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("E-Mail:")
                        TextField("z. B. info@acme.de", text: $viewModel.email)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.email.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Website:")
                        TextField("z. B. acme.de", text: $viewModel.website)
                            .multilineTextAlignment(.trailing)
                    }
                }

                // Kontakt
                Section(header: Text("Kontakt")) {
                    HStack {
                        Text("Name:")
                        TextField("z. B. Max Mustermann", text: $viewModel.contactName)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.contactName.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Telefonnummer:")
                        TextField("z. B. +49 123 456789", text: $viewModel.phoneNumber)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.phoneNumber.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                }

                // Adresse
                Section(header: Text("Adresse")) {
                    HStack {
                        Text("Straße:")
                        TextField("z. B. Musterstraße", text: $viewModel.street)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.street.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Hausnummer:")
                        TextField("z. B. 12a", text: $viewModel.houseNumber)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.houseNumber.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Postleitzahl:")
                        TextField("z. B. 12345", text: $viewModel.postalCode)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.postalCode.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Stadt:")
                        TextField("z. B. Berlin", text: $viewModel.city)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.city.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Land:")
                        TextField("z. B. Deutschland", text: $viewModel.country)
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.country.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
                        }
                    }
                }

                // Steuerinformationen
                Section(header: Text("Steuerinformationen")) {
                    HStack {
                        Text("Handelsregister-Nummer:")
                        TextField("z. B. HRB 123456", text: $viewModel.companyRegistrationNumber)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("UST-ID-Nummer:")
                        TextField("z. B. DE123456789", text: $viewModel.ustIdNr)
                            .multilineTextAlignment(.trailing)
                    }
                }

                // Speichern
                Section {
                    Button("Kunde aktualisieren") {
                        if let _ = viewModel.newClient() {
                            viewModel.updateClient(clientDetail)
                            try? context.save()
                            viewModel.resetInputsClientAndBusiness()
                            dismiss()
                        } else {
                            withAnimation {
                                viewModel.showAttentionIcon = true
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Client")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.getEditableClient(client: clientDetail)
            }
            .onDisappear {
                viewModel.showAttentionIcon = false
                viewModel.resetInputsClientAndBusiness()
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    let client = Client(
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
    return EditClientView(viewModel: viewModel, clientDetail: client)
}
