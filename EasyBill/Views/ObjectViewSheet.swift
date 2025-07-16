//
//  ObjectViewSheet.swift
//  EasyBill
//
//  Created by Francesco Sallia on 16.07.25.
//

import SwiftUI

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
                    Button("Hinzufügen") {
                        let newItem = InvoiceItem(
                            itemName: viewModel.itemName,
                            itemDescription: viewModel.itemDescription,
                            quantity: viewModel.quantity,
                            unit: viewModel.unit,
                            price: viewModel.price
                        )
                        viewModel.invoiceItems.append(newItem)
                        dismiss()
                    }
                    .disabled(viewModel.itemName.isEmpty || viewModel.price <= 0)
                    .buttonStyle(.borderedProminent)
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
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()

    ObjectViewSheet(viewModel: viewModel)
}
