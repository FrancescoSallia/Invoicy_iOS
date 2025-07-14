//
//  TestView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 14.07.25.
//

import SwiftUI

struct TestView: View {
    
    @StateObject var viewModel: BillViewModel = BillViewModel()
    
    var body: some View {
        
        ForEach(viewModel.dummyBusinesses, id: \.email) { client in
            let initialColor = Color.color(for: client.email)
            HStack {
                Spacer()
                Text(client.businessName.prefix(2).uppercased())
                    .frame(width: 60, height: 60)
                    .background(initialColor.opacity(0.2))
                    .foregroundStyle(initialColor)
                    .clipShape(Circle())
                    .clipped()
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundStyle(initialColor)
                    }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text(client.businessName)
                        .font(.headline)
                    Text("Telefon: \(client.phoneNumber)")
                    Text("Adresse: \(client.street) \(client.houseNumber), \(client.postalCode) \(client.city), \(client.country)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            Divider()
                .padding(.horizontal)
        }
    }
}

#Preview {
    TestView()
}
