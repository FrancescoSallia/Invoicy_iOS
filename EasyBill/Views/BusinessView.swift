//
//  BusinessView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI
import SwiftData

struct BusinessView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var business: [Business]


    var body: some View {
        NavigationStack {
            Divider()

            ZStack(alignment: .bottomTrailing) {
                if business.isEmpty {
                    VStack(alignment: .center) {
                        Spacer()
                        Image("business_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)

                        Text("Starten Sie Ihre Unternehmsreise")
                            .font(.title2)
                            .padding(.bottom, 4)
                            .bold()

                        Text("Fügen Sie Ihr erstes Unternehmen hinzu, um Ihre Finanzen zu verwalten und Rechnungen zu erstellen.")
                            .padding(.horizontal)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .padding()
                } else {
                    ScrollView {
                        VStack {
                            ForEach(business, id: \.email) { business in
                                NavigationLink {
                                    BusinessDetailView(viewModel: viewModel, businessDetail: business)
                                } label: {
                                    HStack(alignment: .top, spacing: 12) {
                                        (business.logoImg ?? UIImage(named: "test_logo"))
                                            .map { Image(uiImage: $0) }?
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                            .clipped()
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(business.businessName)
                                                .font(.headline)
                                            Text("Telefon: \(business.phoneNumber)")
                                            Text("Adresse: \(business.street) \(business.houseNumber), \(business.postalCode) \(business.city), \(business.country)")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer(minLength: 0)
                                    }
                                    .padding()
                                }
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                    }
                }

                NavigationLink {
                    BusinessFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Business")
                            .bold()
                    }
                    .padding(4)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding()
                .shadow(radius: 4)
            }
            .toolbar {
                HStack {
                    Image(systemName: "gift.fill")
                    Button("Upgrade") {
                        //TODO: Logic
                    }
                }
                .foregroundStyle(.white)
                .padding(5)
                .background(Color.yellow)
                .clipShape(.buttonBorder)
            }
            .navigationTitle("Business")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessView(viewModel: viewModel)
}

//#Preview {
//    @Previewable @State var viewModel: BillViewModel = BillViewModel()
//
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Business.self, configurations: config)
//
//   let business = Business(
//        businessName: "BauTech Solutions",
//        email: "service@bautech.com",
//        website: nil,
//        contactName: nil,
//        phoneNumber: "+49 222 333444",
//        street: "Industriestraße",
//        houseNumber: "15",
//        postalCode: "50667",
//        city: "Köln",
//        country: "Deutschland",
//        companyRegistrationNumber: nil,
//        ustIdNr: nil,
//        vatApplicable: nil,
//        bankPayment: nil,
//        logoImgData: nil,
//        signatureImgData: nil
//    )
//        BusinessView(viewModel: viewModel)
//            .modelContainer(container)
//}
