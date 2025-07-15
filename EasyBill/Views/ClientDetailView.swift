//
//  ClientDetailView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 15.07.25.
//

import SwiftUI
import SwiftData

struct ClientDetailView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let client: Client

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                let initialColor = Color.color(for: client.email)
                Text(client.clientName.prefix(2).uppercased())
                    .frame(width: 60, height: 60)
                    .background(initialColor.opacity(0.2))
                    .foregroundStyle(initialColor)
                    .clipShape(Circle())
                    .clipped()
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundStyle(initialColor)
                    }
                
                // Firmenname
                Text(client.clientName)
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
                            Text(client.contactName)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("E-Mail")
                            Spacer()
                            Text(client.email)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("Telefon")
                            Spacer()
                            Text(client.phoneNumber)
                                .foregroundColor(.primary)
                        }
                        if let website = client.website {
                            HStack {
                                Text("Website")
                                Spacer()
                                Text(website)
                                    .foregroundColor(.primary)
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
                            Text(client.street)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("Hausnummer")
                            Spacer()
                            Text(client.houseNumber)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("Postleitzahl")
                            Spacer()
                            Text(client.postalCode)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("Stadt")
                            Spacer()
                            Text(client.city)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("Land")
                            Spacer()
                            Text(client.country)
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
                            Text(client.companyRegistrationNumber ?? "–")
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Text("VAT Reg. No.")
                            Spacer()
                            Text(client.ustIdNr ?? "–")
                                .foregroundColor(.primary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                HStack(spacing: 12) {
                    NavigationLink {
                        EditClientView(viewModel: viewModel, clientDetail: client)
                    } label: {
                        Label("Bearbeiten", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button(role: .destructive) {
                        context.delete(client)
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
        .navigationTitle("Client details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    let sampleClient = Client(
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

    return ClientDetailView(viewModel: viewModel ,client: sampleClient)
}
