//
//  ClientSelectionView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 18.07.25.
//

import SwiftUI
import SwiftData

struct ClientSelectionViewSheet: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Query private var clients: [Client]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            
            if clients.isEmpty {
                Text("No businesses yet. Create one first.")
            } else {
                ScrollView {
                    VStack {
                        ForEach(clients, id: \.email) { client in
                            VStack {
                                Button {
                                    viewModel.selectedClientFromSheet = client.email
                                    viewModel.clientItemSelected = client
                                    dismiss()
                                } label: {
                                    HStack {
                                        VStack {
                                            Image(systemName: viewModel.selectedClientFromSheet == client.email ? "largecircle.fill.circle" : "circle")
                                        }
                                    }
                                    .padding(.horizontal)
                                    VStack(alignment: .leading) {
                                        Text(client.clientName)
                                        Text(client.phoneNumber)
                                        Text("\(client.street) \(client.houseNumber), \(client.postalCode) \(client.city)")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .tint(.primary)
                            }
                            Divider()
                        }
                    }
                    .padding(.top)
                    .navigationTitle("Client auswählen")
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

    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    ClientSelectionViewSheet(viewModel: viewModel)
}
