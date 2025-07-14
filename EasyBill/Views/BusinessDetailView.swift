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
            VStack(spacing: 24) {

                // Logo oben
                if let image = businessDetail.logoImg {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 4)
                } else {
                    Image("test_logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 4)
                }

                // Firmenname
                Text(businessDetail.businessName)
                    .font(.title)
                    .bold()

                // Kontaktinformationen
                VStack(alignment: .leading, spacing: 8) {
                    Text("Kontaktinformationen")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    VStack(spacing: 6) {
                        HStack {
                            Text("Kontaktperson:")
                            Spacer()
                            Text(businessDetail.contactName ?? "")
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.trailing)
                        }
                        HStack {
                            Text("E-Mail")
                            Spacer()
                            Text(businessDetail.email)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.trailing)
                        }

                        HStack {
                            Text("Telefon")
                            Spacer()
                            Text(businessDetail.phoneNumber)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.trailing)
                        }

                        if let website = businessDetail.website {
                            HStack {
                                Text("Website")
                                Spacer()
                                Text(website)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                // Adresse
                VStack(alignment: .leading, spacing: 8) {
                    Text("Adresse")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    VStack(spacing: 6) {
                        HStack {
                            Text("Straße")
                            Spacer()
                            Text(businessDetail.street)
                                .foregroundColor(.primary)
                        }

                        HStack {
                            Text("Wohnung, Suite")
                            Spacer()
                            Text(businessDetail.houseNumber)
                                .foregroundColor(.primary)
                        }

                        HStack {
                            Text("PLZ")
                            Spacer()
                            Text(businessDetail.postalCode)
                                .foregroundColor(.primary)
                        }

                        HStack {
                            Text("Stadt")
                            Spacer()
                            Text(businessDetail.city)
                                .foregroundColor(.primary)
                        }

                        HStack {
                            Text("Land")
                            Spacer()
                            Text(businessDetail.country)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)

                // Identifikation
                VStack(alignment: .leading, spacing: 8) {
                    Text("Identifikation")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    VStack(spacing: 6) {
                        HStack {
                            Text("Co. Reg. No.")
                            Spacer()
                            Text(businessDetail.companyRegistrationNumber ?? "–")
                                .foregroundColor(.primary)
                        }

                        HStack {
                            Text("VAT Reg. No.")
                            Spacer()
                            Text(businessDetail.ustIdNr ?? "–")
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // BankInformation
                if businessDetail.bankPayment != nil {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bank-Daten")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        VStack(spacing: 6) {
                            HStack {
                                Text("Kontoinhaber")
                                Spacer()
                                Text(businessDetail.bankPayment?.accountHolder ?? "")
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.trailing)
                            }

                            HStack {
                                Text("Bankname")
                                Spacer()
                                Text(businessDetail.bankPayment?.bankName ?? "")
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("IBAN")
                                Spacer()
                                Text(businessDetail.bankPayment?.iban ?? "")
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Kontonummer")
                                Spacer()
                                Text(businessDetail.bankPayment?.accountNumber ?? "")
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("BIC")
                                Spacer()
                                Text(businessDetail.bankPayment?.bic ?? "")
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.trailing)
                            }

                         
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }

                // Unterschrift
                if let sign = businessDetail.signatureImg {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Unterschrift")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Image(uiImage: sign)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2)))
                    }
                    .padding(.horizontal)
                }

                // Buttons
                HStack(spacing: 12) {
                    NavigationLink {
                        EditBusinessView(viewModel: viewModel, businessDetail: businessDetail)
                    } label: {
                        Label("Bearbeiten", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
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
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Business details")
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
