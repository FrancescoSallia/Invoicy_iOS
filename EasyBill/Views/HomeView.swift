//
//  HomeView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            Divider()
                .padding(.top, 4)
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .center) {
                    Spacer()
                    Image("bill_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    
                    Text("Erstellen Sie ihre erste Rechnung")
                        .font(.title2)
                        .padding(.bottom, 4)
                        .bold()
                    
                    Text("Beginnen Sie, Zahlungen zu verfolgen und ihr Geschäftseinkommen zu verwalten")
                        .padding(.horizontal)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                    Spacer()
                }
                .navigationTitle("Invoices")
                .navigationBarTitleDisplayMode(.inline)
                
                
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
                
                NavigationLink {
//                    ClientFormView() //TODO: Hier muss noch die InvoiceFormView rein!!
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Invoice")
                            .bold()
                    }
                    .padding(4)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .padding()
                .padding(.bottom)
                .shadow(radius: 4)

            }
        }
    }
}

#Preview {
    HomeView()
}
