//
//  ObjectViewSheet.swift
//  EasyBill
//
//  Created by Francesco Sallia on 16.07.25.
//

import SwiftUI
import SwiftData

struct ObjectViewSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @ObservedObject var viewModel: BillViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Produktinformationen")) {
                    HStack {
                        Text("Name:")
                        Spacer()
                        TextField("Item Name", text: $viewModel.itemName)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Beschreibung:")
                        Spacer()
                        TextField("Beschreibung", text: $viewModel.itemDescription)
                            .multilineTextAlignment(.trailing)
                    }
                }
                Section(header: Text("Menge & Einheit")) {
                    Stepper(value: $viewModel.quantity, in: 1...100) {
                        HStack {
                            Text("Anzahl:")
                            Spacer()
                            Text("\(viewModel.quantity)")
                            Spacer()
                        }
                    }
                    HStack {
                        Text("Unit:")
                        Spacer()
                        TextField("Unit", text: $viewModel.unit, prompt: Text("Stück, Liter, kg"))
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Preis")) {
                    HStack {
                        Text("Preis pro Einheit:")
                        Spacer()
                        TextField("Preis pro Einheit", value: $viewModel.price, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                Section {
                    HStack {
                        Button(viewModel.currentInvoiceItem == nil ? "Speichern" : "Aktualisieren") {
                            if viewModel.currentInvoiceItem == nil {
                                // Neues Item hinzufügen
                                viewModel.invoiceItems.append(viewModel.newInvoiceItem())
                            } else {
                                // Vorhandenes Item aktualisieren
                                if let oldItem = viewModel.currentInvoiceItem,
                                   let index = viewModel.invoiceItems.firstIndex(where: { $0.id == oldItem.id }) {
                                    let updatedItem = viewModel.newInvoiceItem()
                                    viewModel.invoiceItems[index] = updatedItem
                                }
                            }
                            
                            viewModel.resetInvoiceItems()
                            dismiss()
                        }
                        .disabled(viewModel.itemName.isEmpty || viewModel.price <= 0)
                        .buttonStyle(.borderedProminent)

                        Spacer()

                        if let currentItem = viewModel.currentInvoiceItem,
                           let index = viewModel.invoiceItems.firstIndex(where: { $0.id == currentItem.id }) {
                            Button {
                                viewModel.invoiceItems.remove(at: index)
                                viewModel.resetInvoiceItems()
                                dismiss()
                            } label: {
                                HStack {
                                    Text("Löschen")
                                    Image(systemName: "trash.circle")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("Neues Objekt")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        dismiss()
                    }
                }
            }
            .onDisappear{
                viewModel.currentInvoiceItem = nil
                viewModel.resetInvoiceItems()
                
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    ObjectViewSheet(viewModel: viewModel)
}
