//
//  HomeView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: BillViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Divider()
                        .padding(.top, 4)
                    
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
                .padding(.bottom, 40) // 🟡 Abstand zur TabView oder Bildschirmrand
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    HomeView(viewModel: viewModel)
}
