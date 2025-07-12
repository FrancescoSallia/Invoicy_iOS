//
//  ClientFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct ClientFormView: View {
    
    @ObservedObject var viewModel: BillViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Allgemein")) {
                    HStack {
                        Text("Firmenname:")
                        TextField("z. B. ACME GmbH", text: $viewModel.clientName, prompt: Text("z. B. ACME GmbH"))
                            .multilineTextAlignment(.trailing)
                        
                        if viewModel.showAttentionIcon && viewModel.clientName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("E-Mail:")
                        TextField("z. B. info@acme.de", text: $viewModel.email, prompt: Text("z. B. info@acme.de"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.email.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Website:")
                        TextField("z. B. acme.de", text: $viewModel.website, prompt: Text("z. B. acme.de"))
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("Kontaktperson")) {
                    HStack {
                        Text("Name:")
                        TextField("z. B. Max Mustermann", text: $viewModel.contactName, prompt: Text("z. B. Max Mustermann"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.contactName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Telefonnummer:")
                        TextField("z. B. +49 123 456789", text: $viewModel.phoneNumber, prompt: Text("z. B. +49 123 456789"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.phoneNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Section(header: Text("Adresse")) {
                    HStack {
                        Text("Straße:")
                        TextField("z. B. Musterstraße 1", text: $viewModel.street, prompt: Text("z. B. Musterstraße 1"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.street.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Postleitzahl:")
                        TextField("z. B. 12345", text: $viewModel.postalCode, prompt: Text("z. B. 12345"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.postalCode.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Stadt:")
                        TextField("z. B. Berlin", text: $viewModel.city, prompt: Text("z. B. Berlin"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.city.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Land:")
                        TextField("z. B. Deutschland", text: $viewModel.country, prompt: Text("z. B. Deutschland"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.country.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Section(header: Text("Steuerinformationen")) {
                    HStack {
                        Text("Handelsregisternummer:")
                        TextField("z. B. HRB 123456", text: $viewModel.companyRegistrationNumber, prompt: Text("z. B. HRB 123456"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("USt-IdNr.:")
                        TextField("z. B. DE123456789", text: $viewModel.ustIdNr, prompt: Text("z. B. DE123456789"))
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section {
                        Button("Kunde speichern") {
                        
                        withAnimation {
                            viewModel.showAttentionIcon = true
                        }
                            viewModel.newClient()
                 
                    }
                    .buttonStyle(.borderedProminent)
                }
//                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Add Client")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    ClientFormView(viewModel: viewModel)
}
