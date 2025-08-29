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
    @Query private var invoices: [Invoice]
    @ObservedObject var errorHandler = ErrorHandler.shared

    @ObservedObject var viewModel: BillViewModel

    var body: some View {
        NavigationStack {
                    Form {
                        Section(header: Text("generally_")) {
                            Button {
                                viewModel.showBusinessSheet = true
                            } label: {
                                HStack {
                                    Text("business_")
                                    Spacer()
                                    Text(viewModel.businessItemSelected?.businessName ??  NSLocalizedString("choose_", comment: ""))
                                        .foregroundColor(.gray)
                                }
                            }
                            Button {
                                viewModel.showClientSheet = true
                            } label: {
                                HStack {
                                    Text("client_")
                                    Spacer()
                                    Text(viewModel.clientItemSelected?.clientName ?? NSLocalizedString("choose_", comment: ""))
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack {
                                Text("invoice_name")
                                TextField("invoice_name", text: $viewModel.invoiceName)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("invoice_number")
                                TextField("invoice_number", text: $viewModel.invoiceNumber)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Picker("currency_", selection: $viewModel.currency) {
                                    ForEach(CurrencyEnum.allCases.sorted(by: { $0.code < $1.code }), id: \.self) { currency in
                                            Text("\(currency.symbol) (\(currency.code))").tag(currency)
                                        }
                                }
                                .pickerStyle(.menu)
                            }
                        }
                        Section(header: Text("object_")) {
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
                                            viewModel.showObjectSheet.toggle()
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
                                viewModel.showObjectSheet.toggle()
                            } label: {
                                HStack {
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                    Text("add_objects")
                                    Spacer()
                                }
                                .padding()
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity)
                            .listRowInsets(EdgeInsets())
                        }
                        Section(header: Text("date_")) {
                            DatePicker("issued_on", selection: $viewModel.selectedIssuedOn, displayedComponents: .date)
                            DatePicker("due_on", selection: $viewModel.selectedDueDate, displayedComponents: .date)
                        }
                        
                        Section(header: Text("VAT_and_discount")) {
                            HStack {
                                Text("VAT_")
                                TextField("MwSt in %", value: $viewModel.tax, format: .number, prompt: Text("e.g_19"))
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack {
                                Text("discount_")
                                TextField("Rabatt in %", value: $viewModel.discount, format: .number, prompt: Text("e.g_10"))
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                            }
                        }

                        Section(header: Text("summery_")) {
                            HStack {
                                Text("sub_total")
                                Spacer()
                                Text("\(viewModel.currency.symbol)")
                                Text(viewModel.calculateSubtotal(viewModel.invoiceItems))
                            }
                            if viewModel.discount != nil && viewModel.discount! > 0 {
                                HStack {
                                    Text(String(format: NSLocalizedString("discount_percent", comment: ""), String(format: "%.0f", viewModel.discount ?? 0.0)))
                                    Spacer()
                                    Text("\(viewModel.currency.symbol)")
                                    Text( "-\(viewModel.calculateDiscountAmount(viewModel.invoiceItems, discounT: viewModel.discount))")
                                }
                            }
                            if viewModel.tax != nil && viewModel.tax! > 0 {
                                HStack {
                                    Text( String(format: NSLocalizedString("VAT_percent", comment: ""), String(format: "%.0f", viewModel.tax ?? 0.0)
                                        )
                                    )
                                    Spacer()
                                    Text("\(viewModel.currency.symbol)")
                                    Text("\(viewModel.calculateTaxAmount(viewModel.invoiceItems, taX: viewModel.tax, discounT: viewModel.discount))")
                                }
                            }
                            HStack {
                                Text("total_inclusive_tax")
                                Spacer()
                                Text("\(viewModel.currency.symbol)")
                                Text("\(viewModel.calculateTotal(viewModel.invoiceItems,discount: viewModel.discount))")
                            }
                        }

                        Section {
                            Button("save_invoice") {
                                if let invoice = viewModel.newInvoice() {
                                        // Füge jedes Item dem Kontext hinzu
                                        for item in invoice.items {
                                            context.insert(item)
                                        }

                                        // Füge auch die Rechnung ein
                                        context.insert(invoice)
                                        try? context.save()

                                        viewModel.resetInputsInvoiceFrom()
                                        viewModel.requestReview() // Aufruf der Spontane Bewertung von Apple
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
                                let pdfData = PDFHelper.generatePDF(from: viewModel.newInvoice()!, with: viewModel)
                                PDFHelper.printPDF(data: pdfData)

//                                InvoicePrinter(viewModel: viewModel).druckeRechnung(invoice: viewModel.newInvoice()!)
                            }
                        } label: {
                            Image(systemName: "printer.fill")
                        }
                        .disabled(viewModel.newInvoice() == nil)
                    }
                    .navigationTitle("create_invoice")
                    .navigationBarTitleDisplayMode(.inline)
                    .onDisappear {
                        var invoiceNumberToInt = Int(viewModel.invoiceNumber)
                        if invoiceNumberToInt != nil, invoiceNumberToInt ?? 0 > 0 {
                            invoiceNumberToInt! -= 1
                        }
                    }
                    .sheet(isPresented: $viewModel.showBusinessSheet) {
                        BusinessSelectionViewSheet(viewModel: viewModel)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                    .sheet(isPresented: $viewModel.showClientSheet) {
                        ClientSelectionViewSheet(viewModel: viewModel)
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                    }
                    .sheet(isPresented: $viewModel.showObjectSheet) {
                        ObjectViewSheet(viewModel: viewModel)
                            .presentationDetents([.height(600), .large])
                            .presentationDragIndicator(.visible)
                      }
                    .alert(item: $errorHandler.currentError) { appError in
                        Alert(
                            title: Text(appError.title),
                            message: Text(appError.errorDescription ?? ""),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    }
        .onAppear {
            viewModel.invoiceNumber = viewModel.generateInvoiceNumber(existingInvoices: invoices)
            viewModel.resetInputsInvoiceFrom()
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    let invoice: Invoice = .init(
        business: viewModel.dummyBusinesses.first!,
        client: viewModel.selectedClient!,
        invoiceName: "",
        invoiceNumber: "",
        currency: "",
        issuedOn: Date(),
        dueDate: Date(),
        items: [],
        discount: 0,
        tax: 0,
        totalSummery: 0
    )

    InvoiceFormView(viewModel: viewModel)
}
