//
//  ClientFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI
import SwiftData

struct ClientFormView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FieldFocusEnum?
    @ObservedObject var errorHandler = ErrorHandler.shared

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("generally_")) {
                    HStack {
                        Text("client_name")
                        TextField("z. B. ACME GmbH", text: $viewModel.clientName, prompt: Text("e_g_ACM_GmbH"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .clientName)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .email }
                        
                        if viewModel.showAttentionIcon && viewModel.clientName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("E-Mail:")
                        TextField("z. B. info@acme.de", text: $viewModel.email, prompt: Text("e_g_info@acme_de"))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.emailAddress)
                            .textCase(.lowercase)
                            .focused($focusedField, equals: .email)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .website }
                        
                        if viewModel.showAttentionIcon && viewModel.email.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("website_")
                        TextField("z. B. acme.de", text: $viewModel.website, prompt: Text("e_g_acme_de"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .website)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .contactName }
                    }
                }
                Section(header: Text("contact_person")) {
                    HStack {
                        Text("Name:")
                        TextField("z. B. Max Mustermann", text: $viewModel.contactName, prompt: Text("e_g_max_mustermann"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .contactName)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .phoneNumber }
                        
                        if viewModel.showAttentionIcon && viewModel.contactName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("telefonnumber_")
                        TextField("z. B. +49 123 456789", text: $viewModel.phoneNumber, prompt: Text("telefonnumber_e_g_"))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .phoneNumber)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .street }
                        
                        if viewModel.showAttentionIcon && viewModel.phoneNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Section(header: Text("adress_")) {
                    HStack {
                        Text("street_")
                        TextField("z. B. Musterstraße", text: $viewModel.street, prompt: Text("e_g_street"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .street)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .houseNumber }
                        
                        if viewModel.showAttentionIcon && viewModel.street.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    HStack {
                        Text("housenumber_")
                        TextField("z. B. 12a", text: $viewModel.houseNumber, prompt: Text("e_g_house_number"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .houseNumber)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .postalCode }
                        
                        if viewModel.showAttentionIcon && viewModel.houseNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("postal_code")
                        TextField("z. B. 12345", text: $viewModel.postalCode, prompt: Text("e_g_postal_code"))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .postalCode)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .city }
                        
                        if viewModel.showAttentionIcon && viewModel.postalCode.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("city_")
                        TextField("z. B. Berlin", text: $viewModel.city, prompt: Text("e_g_city"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .city)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .country }
                        
                        if viewModel.showAttentionIcon && viewModel.city.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("country_")
                        TextField("z. B. Deutschland", text: $viewModel.country, prompt: Text("e_g_country"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .country)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .companyRegistrationNumber }
                        
                        if viewModel.showAttentionIcon && viewModel.country.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Section(header: Text("tax_information")) {
                    HStack {
                        Text("Co_Reg_No_")
                        TextField("z. B. HRB 123456", text: $viewModel.companyRegistrationNumber, prompt: Text("e_g_co_reg_no"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .companyRegistrationNumber)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .ustIdNr }
                    }
                    HStack {
                        Text("VAT_Reg_No_")
                        TextField("z. B. DE123456789", text: $viewModel.ustIdNr, prompt: Text("e_g_iban"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .ustIdNr)
                            .submitLabel(.done)
                            .onSubmit { focusedField = nil }
                    }
                }
                Section {
                        Button("save_client_button") {
                            if viewModel.newClient() != nil {
                                context.insert(viewModel.newClient()!)
                                try? context.save()
                                viewModel.resetInputsClientAndBusiness()
                                dismiss()
                            } else {
                                withAnimation {
                                    viewModel.showAttentionIcon = true
                                }
                            }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .onDisappear{
                viewModel.showAttentionIcon = false
            }
            .toolbar {
                if focusedField != nil {
                    Button {
                        focusedField = nil
                    } label: {
                        HStack {
                            Text("Hide")
                            Image(systemName: "keyboard.chevron.compact.down.fill")
                        }
                    }
                }
            }
            .alert(item: $errorHandler.currentError) { appError in
                Alert(
                    title: Text(appError.title),
                    message: Text(appError.errorDescription ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationTitle("add_client")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    ClientFormView(viewModel: viewModel)
}
