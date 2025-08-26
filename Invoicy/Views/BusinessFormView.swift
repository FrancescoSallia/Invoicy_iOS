//
//  BusinessFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI
import SwiftUICore
import PhotosUI
import SwiftData

struct BusinessFormView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FieldFocusEnum?
    @ObservedObject var errorHandler = ErrorHandler.shared

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("generally_")) {
                    HStack {
                        Text("business_name_")
                        TextField("z. B. ACME GmbH", text: $viewModel.businessName, prompt: Text("e_g_ACM_GmbH"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .businessName)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .email }
                        
                        if viewModel.showAttentionIcon && viewModel.businessName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
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
                        
                        if viewModel.showAttentionIcon && viewModel.email.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("website_")
                        TextField("z. B. acme.de", text: $viewModel.website, prompt: Text("e_g_acme_de"))
                            .multilineTextAlignment(.trailing)
                            .textCase(.lowercase)
                            .focused($focusedField, equals: .website)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .contactName }
                    }
                }
                
                Section(header: Text("contact_")) {
                    HStack {
                        Text("Name:")
                        TextField("z. B. Max Mustermann", text: $viewModel.contactName, prompt: Text("e_g_max_mustermann"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .contactName)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .phoneNumber }
                        
                        if viewModel.showAttentionIcon && viewModel.contactName.isEmpty {
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
                        
                        if viewModel.showAttentionIcon && viewModel.phoneNumber.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
                
                Section(header: Text("adress_")) {
                    HStack {
                        Text("street_")
                        TextField("z. B. Musterstraße ", text: $viewModel.street, prompt: Text("e_g_street"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .street)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .houseNumber }
                        
                        if viewModel.showAttentionIcon && viewModel.street.isEmpty {
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
                        
                        if viewModel.showAttentionIcon && viewModel.houseNumber.isEmpty {
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
                        
                        if viewModel.showAttentionIcon && viewModel.postalCode.isEmpty {
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
                        
                        if viewModel.showAttentionIcon && viewModel.city.isEmpty {
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
                        
                        if viewModel.showAttentionIcon && viewModel.country.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
                
                Section(header: Text("tax_information")) {
                    HStack {
                        Text("Co_Reg_No_")
                        TextField("z. B. DE011616", text: $viewModel.companyRegistrationNumber, prompt: Text("e_g_co_reg_no"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .companyRegistrationNumber)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .ustIdNr }
                    }
                    HStack {
                        Text("VAT_Reg_No_")
                        TextField("z. B. 998011616", text: $viewModel.ustIdNr, prompt: Text("e_g_vat_reg_no"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .ustIdNr)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .vatApplicable }
                    }
                    HStack {
                        Text("subject_to_VAT")
                        TextField("z. B. 0", text: $viewModel.vatApplicable, prompt: Text("e_g_subject_to_VAT"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .vatApplicable)
                            .submitLabel(.done)
                            .onSubmit { focusedField = nil }
                    }
                    
                }
                
                //TODO: Hier weiter machen mit dem translaten!!!
                
                Toggle("bank_connection", isOn: $viewModel.isToggledBank)
                if viewModel.isToggledBank {
                    HStack {
                        Text("account_holder")
                        TextField("Kontoinhaber", text: $viewModel.accountHolder, prompt: Text("e_g_max_mustermann"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.accountHolder.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Bank-Name:")
                        TextField("Bank-Name", text: $viewModel.bankName, prompt: Text("Sparkasse"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.bankName.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("IBAN:")
                        TextField("Iban", text: $viewModel.iban, prompt: Text("DE09 22 1234 1234 45"))
                            .multilineTextAlignment(.trailing)
                            .textCase(.uppercase)
                        if viewModel.showAttentionIcon && viewModel.iban.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("account_number")
                        TextField("Kontonummer", text: $viewModel.accountNumber, prompt: Text("1234 1234 45"))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        if viewModel.showAttentionIcon && viewModel.accountNumber.isEmpty && viewModel.iban.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("BIC:")
                        TextField("bic", text: $viewModel.bic, prompt: Text("BELADEBEXX"))
                            .multilineTextAlignment(.trailing)
                            .textCase(.uppercase)
                        if viewModel.showAttentionIcon && viewModel.bic.isEmpty && viewModel.iban.isEmpty {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
                
                Section(header: Text("Signatur")) {
                    if let image = viewModel.signatureImage {
                        HStack {
                            Text("Signatur:")
                            Spacer()
                            Button {
                                viewModel.showSignatureView = true
                            } label: {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .padding(.vertical, 4)
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        HStack {
                            Text("signature_")
                            Spacer()
                            Button {
                                viewModel.showSignatureView = true
                            } label: {
                                Image(systemName: "signature")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 82)
                                    .tint(.primary)
                            }
                            if viewModel.showAttentionIcon && viewModel.signatureImage == nil {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundStyle(.red)
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                }
                Section(header: Text("Logo")) {
                    HStack {
                        Text("Logo:")
                        Spacer()
                        PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                            Image(uiImage: (viewModel.logoImage ?? UIImage(systemName: "photo"))!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }
                        .tint(.primary)
                    }
                    .padding(.horizontal)
                }
                
                Section {
                    Button("create_business") {
                        if viewModel.newBusiness() != nil {
                            context.insert(viewModel.newBusiness()!)
                            try? context.save()
                            viewModel.resetInputsClientAndBusiness()
                            dismiss()
                        } else {
                            viewModel.showAlert = true
                            viewModel.showAttentionIcon = true
                        }
                    }
                }
            }
            .navigationTitle("new_business")
            .sheet(isPresented: $viewModel.showSignatureView) {
                SignatureView(drawing: $viewModel.drawing, signatureImage: $viewModel.signatureImage)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
            .onChange(of: viewModel.photosPickerItem) { _, _ in
                Task {
                    await viewModel.loadUIImageLogo()
                }
            }
            .onDisappear{
                viewModel.showAttentionIcon = false
                viewModel.logoImage = nil
                viewModel.photosPickerItem = nil
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
//            .alert("Error", isPresented: $viewModel.showAlert) {
//                Button("OK", role: .cancel) { }
//            } message: {
//                Text("Something went wrong. Probably you forgot to fill in some fields.")
//            }
            .alert(item: $errorHandler.currentError) { appError in
                Alert(
                    title: Text(appError.title),
                    message: Text(appError.errorDescription ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessFormView(viewModel: viewModel)
}
