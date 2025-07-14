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
    @FocusState private var focusedField: Field?

    enum Field: Hashable { //TODO: Enum auslagern, erst bei ClientFormView die onSubmit funktion einfügen wie auf dieser View
        case businessName, email, website,
             contactName, phoneNumber,
             street, houseNumber, postalCode, city, country,
             companyRegistrationNumber, ustIdNr, vatApplicable,
             accountHolder, bankName, iban, accountNumber, bic
    }
    
   
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Allgemein")) {
                    HStack {
                        Text("Firmenname:")
                        TextField("z. B. ACME GmbH", text: $viewModel.businessName, prompt: Text("z. B. ACME GmbH"))
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
                        TextField("z. B. info@acme.de", text: $viewModel.email, prompt: Text("z. B. info@acme.de"))
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
                        Text("Website:")
                        TextField("z. B. acme.de", text: $viewModel.website, prompt: Text("z. B. acme.de"))
                            .multilineTextAlignment(.trailing)
                            .textCase(.lowercase)
                            .focused($focusedField, equals: .website)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .contactName }
                    }
                }
                
                Section(header: Text("Kontakt")) {
                    HStack {
                        Text("Name:")
                        TextField("z. B. Max Mustermann", text: $viewModel.contactName, prompt: Text("z. B. Max Mustermann"))
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
                        Text("Telefonnummer:")
                        TextField("z. B. +49 123 456789", text: $viewModel.phoneNumber, prompt: Text("z. B. +49 123 456789"))
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
                
                Section(header: Text("Adresse")) {
                    HStack {
                        Text("Straße:")
                        TextField("z. B. Musterstraße ", text: $viewModel.street, prompt: Text("z. B. Musterstraße "))
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
                        Text("HouseNumber:")
                        TextField("z. B. 12a", text: $viewModel.houseNumber, prompt: Text("z. B. 12a"))
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
                        Text("Postleitzahl:")
                        TextField("z. B. 12345", text: $viewModel.postalCode, prompt: Text("z. B. 12345"))
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
                        Text("Stadt:")
                        TextField("z. B. Berlin", text: $viewModel.city, prompt: Text("z. B. Berlin"))
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
                        Text("Land:")
                        TextField("z. B. Deutschland", text: $viewModel.country, prompt: Text("z. B. Deutschland"))
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
                
                Section(header: Text("Steuerdetails")) {
                    HStack {
                        Text("Handelsregister-Nummer:")
                        TextField("z. B. DE011616", text: $viewModel.companyRegistrationNumber, prompt: Text("z. B. DE011616"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .companyRegistrationNumber)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .ustIdNr }
                    }
                    HStack {
                        Text("UST-ID-Nummer:")
                        TextField("z. B. 998011616", text: $viewModel.ustIdNr, prompt: Text("z. B. 900011616"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .ustIdNr)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .vatApplicable }
                    }
                    HStack {
                        Text("Umsatzsteuerpflichtig:")
                        TextField("z. B. 0", text: $viewModel.vatApplicable, prompt: Text("z. B. 0"))
                            .multilineTextAlignment(.trailing)
                            .focused($focusedField, equals: .vatApplicable)
                            .submitLabel(.done)
                            .onSubmit { focusedField = nil }
                    }
                    
                }
            
               
                
                Toggle("Bank-Verbindung", isOn: $viewModel.isToggledBank)
                if viewModel.isToggledBank {
                    HStack {
                        Text("Account Holder:")
                        TextField("Account Holder", text: $viewModel.accountHolder, prompt: Text("Max Mustermann"))
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
                        Text("Account Number:")
                        TextField("Account Number", text: $viewModel.accountNumber, prompt: Text("1234 1234 45"))
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
                            Text("Signatur:")
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
                    Button("Business erstellen") {
                        if viewModel.newBusiness() != nil {
                            context.insert(viewModel.newBusiness()!)
                            try? context.save()
                            viewModel.resetInputs()
                            dismiss()
                        } else {
                            viewModel.showAttentionIcon = true
                        }
                    }
                }
            }
            .navigationTitle("Neues Business")
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
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessFormView(viewModel: viewModel)
}
