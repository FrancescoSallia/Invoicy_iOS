//
//  BusinessDetailView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 13.07.25.
//

import SwiftUI
import SwiftData

struct BusinessDetailView: View {
    
    @ObservedObject var viewModel: BillViewModel

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var business: [Business]

    var businessDetail: Business

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // Logo-Bild oben
                if let image = businessDetail.logoImg {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                        .padding(.top)
                } else {
                    Image("test_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                        .padding(.top)
                }
                
                // Unternehmensdaten
                VStack(alignment: .leading, spacing: 8) {
                    Group {
                        Text("🧾 **Unternehmen**")
                        Text("• Name: \(businessDetail.businessName)")
                        Text("• E-Mail: \(businessDetail.email)")
                        if let website = businessDetail.website {
                            Text("• Website: \(website)")
                        }
                    }
                    
                    Group {
                        Text("👤 **Kontakt**")
                        Text("• Ansprechpartner: \(businessDetail.contactName ?? "–")")
                        Text("• Telefon: \(businessDetail.phoneNumber)")
                    }
                    
                    Group {
                        Text("🏠 **Adresse**")
                        Text("• Straße: \(businessDetail.street) \(businessDetail.houseNumber)")
                        Text("• PLZ/Ort: \(businessDetail.postalCode) \(businessDetail.city)")
                        Text("• Land: \(businessDetail.country)")
                    }
                    
                    Group {
                        Text("💼 **Steuernummern**")
                        if let reg = businessDetail.companyRegistrationNumber {
                            Text("• Registernummer: \(reg)")
                        }
                        if let ust = businessDetail.ustIdNr {
                            Text("• USt-ID: \(ust)")
                        }
                        if let vat = businessDetail.vatApplicable {
                            Text("• Umsatzsteuerpflichtig: \(vat)")
                        }
                    }
                    
                    // Zahlungsdetails (optional)
                    if let payment = businessDetail.bankPayment {
                        Group {
                            Text("🏦 **Bankverbindung**")
                            Text("• Kontoinhaber: \(payment.accountHolder)")
                            Text("• Bank: \(payment.bankName)")
                            if !payment.iban.isEmpty {
                                Text("• IBAN: \(payment.iban)")
                            } else {
                                Text("• Konto: \(payment.accountNumber)")
                                Text("• BIC: \(payment.bic)")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // Unterschrift (optional)
                if let sign = businessDetail.signatureImg {
                    VStack(alignment: .leading) {
                        Text("✍️ Unterschrift:")
                            .font(.subheadline)
                        Image(uiImage: sign)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .padding(.vertical, 4)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Action Buttons
                HStack(spacing: 12) {
                    Button {
                        
                    } label: {
                        
                        Label("Bearbeiten", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(role: .destructive) {
                        context.delete(businessDetail)
                        try? context.save()
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .frame(width: 44, height: 44)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    var business =  Business(
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
                )
    BusinessDetailView(viewModel: viewModel, businessDetail: business)
}
