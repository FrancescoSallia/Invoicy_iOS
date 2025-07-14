//
//  CustomerView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI
import SwiftData

struct ClientsView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Query private var clients: [Client]

    var body: some View {
        NavigationStack {
            Divider()
            ZStack(alignment: .bottomTrailing) {
                if clients.isEmpty {
                    VStack(alignment: .center) {
                        Spacer()
                        Image("customer_icon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)

                        Text("Fügen Sie ihren ersten Kunden hinzu")
                            .font(.title2)
                            .padding(.bottom, 4)
                            .bold()

                        Text("Beginnen Sie, Ihre Kundenbasis aufzubauen und erstellen Sie in wenigen Minuten professionelle Rechnungen.")
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
                            ForEach(clients, id: \.email) { client in
                                let initialColor = Color.color(for: client.email) //Dank der extension generiert es zufälligen Farben für den Hintergrund
                                NavigationLink {
//                                    BusinessDetailView(viewModel: viewModel, businessDetail: business)
                                } label: {
                                HStack {
                                    Spacer()
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
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(client.clientName)
                                            .font(.headline)
                                        Text("Telefon: \(client.phoneNumber)")
                                        Text("Adresse: \(client.street) \(client.houseNumber), \(client.postalCode) \(client.city), \(client.country)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                .padding()
                                Divider()
                                    .padding(.horizontal)
                            }
                            }
                        }
                    }
                }

                NavigationLink {
                    ClientFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Client")
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
            .navigationTitle("Client's")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}


#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    ClientsView(viewModel: viewModel)
}


//                Button {
//                    //TODO: Logic
//                } label: {
//                    HStack {
//                        Image(systemName: "plus")
//                            .bold()
//                        Text("Add Client")
//                            .bold()
//                    }
//                    .padding(4)
//                }
//                .buttonStyle(.borderedProminent)
//                .clipShape(RoundedRectangle(cornerRadius: 40))
//                .padding()
//                .padding(.bottom)
//                .shadow(radius: 8)


//ClientFormView(viewModel: viewModel)
