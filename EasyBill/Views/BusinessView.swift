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
    @Query private var business: [Business]


    var body: some View {
        NavigationStack {
            Divider()

            ZStack(alignment: .bottomTrailing) {
                if viewModel.dummyBusinesses.isEmpty {
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
                            ForEach(viewModel.dummyBusinesses, id: \.email) { business in
                                HStack {
                                    (business.logoImg ?? UIImage(named: "test_logo"))
                                        .map { Image(uiImage: $0) }?
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 64)
                                        .clipShape(Circle())
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(business.businessName)
                                            .font(.headline)
                                        Text("Telefon: \(business.phoneNumber)")
                                        Text("Adresse: \(business.street) \(business.houseNumber), \(business.postalCode) \(business.city), \(business.country)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.trailing)
                                }
                                .padding()
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
            
            .onAppear {
                viewModel.dummyBusinesses = business
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessView(viewModel: viewModel)
}
