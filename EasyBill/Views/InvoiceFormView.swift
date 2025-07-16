//
//  InvoiceFormView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 16.07.25.
//

import SwiftUI
import SwiftData

struct InvoiceFormView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query private var invoiceItems: [InvoiceItem]

    @ObservedObject var viewModel: BillViewModel

    @State private var showBusinessSheet = false
    @State private var showClientSheet = false
    @State private var showObjectSheet = false

    
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
                                    Text(viewModel.businessItemSelected?.businessName ?? "Auswählen")
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
                        Section(header: Text("Invoice Items")) {
                            ForEach(invoiceItems, id: \.self) { item in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.itemName)
                                        .font(.headline)
                                    HStack {
                                        Text("\(item.quantity) × €\(String(format: "%.2f", item.price))/\(item.unit)")
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Text("€\(String(format: "%.2f", Double(item.quantity) * item.price))")
                                            .bold()
                                        Button {
                                            viewModel.currentInvoiceItem = item
                                            viewModel.getEditableInvoiceItem(invoiceItem: item)
                                            showObjectSheet.toggle()
                                        } label: {
                                            Image(systemName: "pencil.and.scribble")
                                        }
                                        .tint(.primary)
                                    }
                                }
                                .padding()
                                .listRowInsets(EdgeInsets())
                            }

                            Button {
                                // TODO: Logik zum Hinzufügen eines neuen Items
                                showObjectSheet.toggle()
                            } label: {
                                HStack {
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                    Text("Objekt hinzufügen")
                                    Spacer()
                                }
                                .padding()
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets())
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
                                Text(viewModel.calculateSubtotal(invoiceItems))
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
                        BusinessSelectionViewSheet(viewModel: viewModel)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                    .sheet(isPresented: $showClientSheet) {
//                        ClientSelectionView(selectedClient: $viewModel.client)
                    }
                    .sheet(isPresented: $showObjectSheet) {
                        ObjectViewSheet(viewModel: viewModel)
                            .presentationDetents([.height(600), .large])
                            .presentationDragIndicator(.visible)
                      }
                    }
                }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    InvoiceFormView(viewModel: viewModel)
}
