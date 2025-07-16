//
//  InvoiceFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 16.07.25.
//

import SwiftUI

struct InvoiceFormView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @ObservedObject var viewModel: BillViewModel

    @State private var showBusinessSheet = false
    @State private var showClientSheet = false

    
    var body: some View {
        NavigationStack {
                    Form {
                        Section(header: Text("Allgemein")) {
                            Button {
                                showBusinessSheet = true
                            } label: {
                                HStack {
                                    Text("Business")
                                    Spacer()
                                    Text(viewModel.selectedBusiness?.businessName ?? "Auswählen")
                                        .foregroundColor(.gray)
                                }
                            }

                            Button {
                                showClientSheet = true
                            } label: {
                                HStack {
                                    Text("Kunde")
                                    Spacer()
                                    Text(viewModel.selectedClient?.clientName ?? "Auswählen")
                                        .foregroundColor(.gray)
                                }
                            }

                            HStack {
                                Text("Rechnungsname:")
                                TextField("Rechnungsname", text: $viewModel.invoiceName)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Rechnungsnummer:")
                                TextField("Rechnungsnummer", text: $viewModel.invoiceNumber)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Währung:")
                                TextField("Währung", text: $viewModel.currency)
                                    .multilineTextAlignment(.trailing)
                            }
                        }

                        Section(header: Text("Datum")) {
                            DatePicker("Ausgestellt am", selection: $viewModel.selectedIssuedOn, displayedComponents: .date)
                            DatePicker("Fällig am", selection: $viewModel.selectedDueDate, displayedComponents: .date)
                        }

                        Section(header: Text("Zusammenfassung")) {
                            HStack {
                                Text("MwSt (%)")
                                TextField("MwSt in %", value: $viewModel.tax, format: .number, prompt: Text("z. B. 19"))
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Discount (%)")
                                TextField("Rabatt in %", value: $viewModel.discount, format: .number, prompt: Text("z. B. 10"))
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("Zwischensumme")
                                Spacer()
                                Text("€")
                                Text("\(String(format: "%.2f", viewModel.totalSummery))")
                            }
                            HStack {
                                Text("Rabatt (\(String(format: "%.0f", viewModel.discount))%)")
                                Spacer()
                                Text("€")
                                Text("\(String(format: "%.2f", viewModel.totalSummery))")
                            }
                            HStack {
                                Text("Gesamt:")
                                Spacer()
                                Text("€")
                                Text("\(String(format: "%.2f", viewModel.totalSummery))")
                            }
                        }

                        Section {
                            Button("Rechnung speichern") {
//                                guard let invoice = viewModel.createInvoice() else {
//                                    // Fehlermeldung oder Hinweis anzeigen
//                                    return
//                                }
//
//                                context.insert(invoice)
//                                try? context.save()
//                                dismiss()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .navigationTitle("Rechnung erstellen")
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $showBusinessSheet) {
//                        BusinessSelectionView(selectedBusiness: $viewModel.business)
                    }
                    .sheet(isPresented: $showClientSheet) {
//                        ClientSelectionView(selectedClient: $viewModel.client)
                    }
                }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    InvoiceFormView(viewModel: viewModel)
}
