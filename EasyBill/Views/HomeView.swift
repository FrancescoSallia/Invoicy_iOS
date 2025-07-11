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
            VStack(alignment: .center) {
                Spacer()
                Image("bill_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                Text("Erstellen Sie ihre erste Rechnung")
                    .font(.title2)
                    .bold()
                
                Text("Beginnen Sie, Zahlungen zu verfolgen und ihr Geschäftseinkommen zu verwalten")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .italic()
                    .multilineTextAlignment(.center)
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
    HomeView()
}
