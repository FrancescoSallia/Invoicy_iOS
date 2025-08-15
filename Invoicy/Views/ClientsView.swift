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
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if clients.isEmpty {
                        VStack {
                            Spacer()
                            Image("customer_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)

                            Text("add_your_first_client")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 4)

                            Text("add_your_first_client_description")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            Spacer()
                        }
                        .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(clients, id: \.email) { client in
                                    let initialColor = Color.color(for: client.email)
                                    NavigationLink {
                                        ClientDetailView(viewModel: viewModel, client: client)
                                    } label: {
                                        HStack(alignment: .top, spacing: 12) {
                                            Text(client.clientName.prefix(2).uppercased())
                                                .frame(width: 60, height: 60)
                                                .background(initialColor.opacity(0.2))
                                                .foregroundStyle(initialColor)
                                                .clipShape(Circle())
                                                .overlay(
                                                    Circle()
                                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                                        .foregroundStyle(initialColor)
                                                )
                                            
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(client.clientName)
                                                    .font(.headline)
                                                Text("telefon_ \(client.phoneNumber)")
                                                Text("adress_ \(client.street) \(client.houseNumber), \(client.postalCode) \(client.city), \(client.country)")
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
                            .padding(.top)
                        }
                    }
                }

                // ✅ Floating Action Button
                NavigationLink {
                    ClientFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("add_client")
                            .bold()
                    }
                    .padding()
                    .background(Color.primaryApp)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 40) // Abstand zur TabView / Home Indicator
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
            .navigationTitle("clients_")
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
