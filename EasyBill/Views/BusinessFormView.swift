//
//  BusinessFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI
import SwiftUICore
import PhotosUI

// MARK: - BusinessFormView

struct BusinessFormView: View {
    
    @ObservedObject var viewModel: BillViewModel
   

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Allgemein")) {
                    HStack {
                        Text("Firmenname:")
                        TextField("z. B. ACME GmbH", text: $viewModel.businessName, prompt: Text("z. B. ACME GmbH"))
                            .multilineTextAlignment(.trailing)
                        
                        if viewModel.showAttentionIcon && viewModel.businessName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
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

                Section(header: Text("Kontakt")) {
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
                        TextField("z. B. Musterstraße ", text: $viewModel.street, prompt: Text("z. B. Musterstraße "))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.street.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("HouseNumber:")
                        TextField("z. B. 12a", text: $viewModel.houseNumber, prompt: Text("z. B. 12a"))
                            .multilineTextAlignment(.trailing)
                        if viewModel.showAttentionIcon && viewModel.houseNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
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

                Section(header: Text("Steuerdetails")) {
                    HStack {
                        Text("Handelsregister-Nummer:")
                        TextField("z. B. DE011616", text: $viewModel.companyRegistrationNumber, prompt: Text("z. B. DE011616"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("UST-ID-Nummer:")
                        TextField("z. B. 998011616", text: $viewModel.ustIdNr, prompt: Text("z. B. 900011616"))
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Umsatzsteuerpflichtig:")
                        TextField("z. B. 0", text: $viewModel.vatApplicable, prompt: Text("z. B. 0"))
                            .multilineTextAlignment(.trailing)
                    }

                }
                
                Section(header: Text("Signatur")) {
                    if let image = viewModel.signatureImage {
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .padding(.vertical, 4)

                            Button("Signatur löschen", role: .destructive) {
//                                viewModel.signatureImage = nil
                                viewModel.showSignatureView = true

                            }
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
                        }
                        .padding(.horizontal)
                    }
                }
                            
                            
                            
                Section(header: Text("Logo")) {
                    Button{
                        viewModel.showImagePicker = true
                    } label: {
                        
                        if let image = viewModel.logoImage {
                            Image(uiImage: image)
                                .resizable()
                                .frame(maxWidth: 100, maxHeight: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        } else {
                            Label("Logo hinzufügen", systemImage: "photo")
                        }
                    }
                }

                Section {
                    Button("Business erstellen") {
                        viewModel.showAttentionIcon = true
                        viewModel.newBusiness()
                    }
                }
            }
            .navigationTitle("Neues Business")
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(image: $viewModel.logoImage)
                    .presentationDragIndicator(.visible)

            }
            .sheet(isPresented: $viewModel.showSignatureView) {
                SignatureView(drawing: $viewModel.drawing, signatureImage: $viewModel.signatureImage)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}



#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessFormView(viewModel: viewModel)
}
