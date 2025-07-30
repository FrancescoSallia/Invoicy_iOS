//
//  HomeView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//


import SwiftUI
import SwiftData

struct HomeView: View {

    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var invoices: [Invoice]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if invoices.isEmpty {
                        VStack {
                            Spacer()

                            Image("bill_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)

                            Text("Erstellen Sie ihre erste Rechnung")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 4)

                            Text("Beginnen Sie, Zahlungen zu verfolgen und ihr Geschäftseinkommen zu verwalten")
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
                                ForEach(invoices, id: \.self) { invoice in
                                    NavigationLink {
//                                        InvoiceDetailView(viewModel: viewModel)
                                        PreviewScreen(invoice: invoice, viewModel: viewModel)
                                    } label: {
                                        HStack(alignment: .top, spacing: 12) {
                                            Image(systemName: "doc.text")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .padding(8)
                                                .background(Color.gray.opacity(0.2))
                                                .clipShape(Circle())

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(invoice.invoiceName)
                                                    .font(.headline)
                                                Text("Datum: \(invoice.issuedOn)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                Text(invoice.invoiceNumber)
                                            }

                                            Spacer()
                                        }
                                        .padding()
                                    }
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                            .padding(.bottom, 100) // Abstand zum Button unten
                        }
                    }
                }

                // ✅ Floating Action Button
                NavigationLink {
                    InvoiceFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Invoice")
                            .bold()
                    }
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 40)
            }
            .navigationTitle("Invoices")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                HStack {
                    Image(systemName: "gift.fill")
                    Button("Upgrade") {
                        // TODO: Upgrade Logic
                    }
                }
                .foregroundStyle(.white)
                .padding(6)
                .background(Color.yellow)
                .clipShape(.capsule)
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    HomeView(viewModel: viewModel)
}
