//
//  CustomerView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct CustomerView: View {
    var body: some View {
        NavigationStack {
            Divider()
                .padding(.top, 4)
            Spacer()
            VStack {
                Spacer()
                Image("customer_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
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
        }

    }
}

#Preview {
    CustomerView()
}
