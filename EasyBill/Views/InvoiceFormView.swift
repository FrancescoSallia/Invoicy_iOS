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
                                    Text(viewModel.clientItemSelected?.clientName ?? "Auswählen")
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
//                                TextField("Rechnungsnummer", text: $viewModel.invoiceNumber)
                                TextField("Rechnungsnummer", text: $viewModel.invoiceNumber)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Picker("Währung", selection: $viewModel.currency) {
                                    ForEach(CurrencyEnum.allCases.sorted(by: { $0.code < $1.code }), id: \.self) { currency in
                                            Text("\(currency.symbol) (\(currency.code))").tag(currency)
                                        }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                        Section(header: Text("Invoice Items")) {
                            ForEach(viewModel.invoiceItems, id: \.self) { item in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.itemName)
                                        .font(.headline)
                                    HStack {
                                        Text("\(item.quantity) × \(viewModel.currency.symbol)\(String(format: "%.2f", item.price))/\(item.unit)")
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Text("\(viewModel.currency.symbol)\(String(format: "%.2f", Double(item.quantity) * item.price))")
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
                        
                        Section(header: Text("MwSt. & Rabatt")) {
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
                        }

                        Section(header: Text("Zusammenfassung")) {
                            HStack {
                                Text("Zwischensumme")
                                Spacer()
                                Text("\(viewModel.currency.symbol)")
                                Text(viewModel.calculateSubtotal(viewModel.invoiceItems))
                            }
                            if viewModel.discount != nil && viewModel.discount! > 0 {
                                HStack {
                                    Text("Rabatt (\(String(format: "%.0f", viewModel.discount ?? 0.0))%)")
                                    Spacer()
                                    Text("€")
                                    Text( "-\(viewModel.calculateDiscountAmount(viewModel.invoiceItems))")
                                }
                            }
                            if viewModel.tax != nil && viewModel.tax! > 0 {
                                HStack {
                                    Text("MwSt (\(String(format: "%.0f", viewModel.tax ?? 0.0))%)")
                                    Spacer()
                                    Text("\(viewModel.currency.symbol)")
                                    Text("\(viewModel.calculateTaxAmount(viewModel.invoiceItems))")
                                }
                            }
                            HStack {
                                Text("Gesamt (inkl.MwSt):")
                                Spacer()
                                Text("\(viewModel.currency.symbol)")
                                Text("\(viewModel.calculateTotal(viewModel.invoiceItems,discount: viewModel.discount))")
                            }
                        }

                        Section {
                            Button("Rechnung speichern") {
                                if let invoice = viewModel.newInvoice() {
                                        // Füge jedes Item dem Kontext hinzu
                                        for item in invoice.items {
                                            context.insert(item)
                                        }

                                        // Füge auch die Rechnung ein
                                        context.insert(invoice)
                                        try? context.save()

                                        viewModel.resetInputsInvoiceFrom()
                                        dismiss()
                                    }
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(viewModel.newInvoice() == nil)
                            
                        }
                    }
                    .toolbar {
                        Button {
                            if viewModel.newInvoice() != nil {
                                InvoicePrinter(viewModel: viewModel).druckeRechnung(invoice: viewModel.newInvoice()!)
                            }
                        } label: {
                            Image(systemName: "printer.fill")
                        }
                        .disabled(viewModel.newInvoice() == nil)
                    }
                    .navigationTitle("Rechnung erstellen")
                    .navigationBarTitleDisplayMode(.inline)
                    .onDisappear {
                        var invoiceNumberToInt = Int(viewModel.invoiceNumber)
                        if invoiceNumberToInt != nil, invoiceNumberToInt ?? 0 > 0 {
                            invoiceNumberToInt! -= 1
                        }
                        
                        //TODO: teste die diappear funktion wenn man immer wieder neue invoices erstellt ob die generierte zahl sich so verhält wie es sich verhalten sollte!
//                        
//                        for item in invoiceItems {
//                            context.delete(item)
//                            try? context.save()
//                        }
                    }
                    .sheet(isPresented: $showBusinessSheet) {
                        BusinessSelectionViewSheet(viewModel: viewModel)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                    .sheet(isPresented: $showClientSheet) {
                        ClientSelectionViewSheet(viewModel: viewModel)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                    .sheet(isPresented: $showObjectSheet) {
                        ObjectViewSheet(viewModel: viewModel)
                            .presentationDetents([.height(600), .large])
                            .presentationDragIndicator(.visible)
                      }
                    }
        .onAppear {
            viewModel.invoiceNumber = viewModel.generateInvoiceNumber()
            viewModel.resetInputsInvoiceFrom()
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    InvoiceFormView(viewModel: viewModel)
}
