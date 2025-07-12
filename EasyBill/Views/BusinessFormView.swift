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
    @State private var businessName = ""
    @State private var email = ""
    @State private var website = ""

    @State private var contactName = ""
    @State private var phoneNumber = ""

    @State private var street = ""
    @State private var houseNumber = ""
    @State private var postalCode = ""
    @State private var city = ""
    @State private var country = ""

    @State private var companyRegistrationNumber = ""
    @State private var ustIdNr = ""
    @State private var vatApplicable = ""

    @State private var logoImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showSignatureView = false

    @State private var showValidation = false
    @State private var drawing = Drawing()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Allgemein")) {
                    HStack {
                        Text("Firmenname:")
                        TextField("z. B. ACME GmbH", text: $businessName, prompt: Text("z. B. ACME GmbH"))
                            .multilineTextAlignment(.trailing)
                        
                        if showValidation && businessName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("E-Mail:")
                        TextField("z. B. info@acme.de", text: $email, prompt: Text("z. B. info@acme.de"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && email.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Website:")
                        TextField("z. B. acme.de", text: $website, prompt: Text("z. B. acme.de"))
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section(header: Text("Kontakt")) {
                    HStack {
                        Text("Name:")
                        TextField("z. B. Max Mustermann", text: $contactName, prompt: Text("z. B. Max Mustermann"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && contactName.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Telefonnummer:")
                        TextField("z. B. +49 123 456789", text: $phoneNumber, prompt: Text("z. B. +49 123 456789"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && phoneNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Section(header: Text("Adresse")) {
                    HStack {
                        Text("Straße:")
                        TextField("z. B. Musterstraße ", text: $street, prompt: Text("z. B. Musterstraße "))
                            .multilineTextAlignment(.trailing)
                        if showValidation && street.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("HouseNumber:")
                        TextField("z. B. 12a", text: $houseNumber, prompt: Text("z. B. 12a"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && houseNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Postleitzahl:")
                        TextField("z. B. 12345", text: $postalCode, prompt: Text("z. B. 12345"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && postalCode.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Stadt:")
                        TextField("z. B. Berlin", text: $city, prompt: Text("z. B. Berlin"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && city.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Land:")
                        TextField("z. B. Deutschland", text: $country, prompt: Text("z. B. Deutschland"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && country.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }

                Section(header: Text("Steuerdetails")) {
                    HStack {
                        Text("Handelsregister-Nummer:")
                        TextField("z. B. DE011616", text: $companyRegistrationNumber, prompt: Text("z. B. DE011616"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && companyRegistrationNumber.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("UST-ID-Nummer:")
                        TextField("z. B. 998011616", text: $ustIdNr, prompt: Text("z. B. 900011616"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && ustIdNr.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }
                    HStack {
                        Text("Umsatzsteuerpflichtig:")
                        TextField("z. B. 0", text: $vatApplicable, prompt: Text("z. B. 0"))
                            .multilineTextAlignment(.trailing)
                        if showValidation && vatApplicable.isEmpty { //Zeigt den icon nur wenn der wert nicht befüllt wurde
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundStyle(.red)
                        }
                    }

                }
                
                
                
                Section(header: Text("Signatur")) {
                    
                    HStack {
                        Text("Signatur:")
                        Spacer()
                        Button {
                            showSignatureView = true
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
                            
                            
                            
                Section(header: Text("Logo")) {
                    Button{
                        showImagePicker = true
                    } label: {
                        
                        if let image = logoImage {
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
                        showValidation = true
                        // Validierung oder Speicherung
                    }
                }
            }
            .navigationTitle("Neues Business")
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $logoImage)
                    .presentationDragIndicator(.visible)

            }
            .sheet(isPresented: $showSignatureView) {
                SignatureView(drawing: $drawing)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }

//    @ViewBuilder
//    private func formRow(_ label: String, text: Binding<String>, required: Bool = false) -> some View {
//        HStack {
//            Text(label)
//            TextField("", text: text)
//                .multilineTextAlignment(.trailing)
//            if required && showValidation && text.wrappedValue.trimmingCharacters(in: .whitespaces).isEmpty {
//                Image(systemName: "exclamationmark.triangle.fill")
//                    .foregroundColor(.red)
//            }
//        }
//    }
}



#Preview {
    BusinessFormView()
}
