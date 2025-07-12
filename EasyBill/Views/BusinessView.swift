//
//  BusinessView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct BusinessView: View {
    
    @ObservedObject var viewModel: BillViewModel

    var body: some View {
        NavigationStack {
            Divider()
                .padding(.top, 4)
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .center) {
                    Spacer()
                    Image("business_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                    
                    Text("Starten Sie Ihre Unternehmsreise")
                        .font(.title2)
                        .padding(.bottom, 4)
                        .bold()
                    
                    Text("Fügen Sie Ihr erstes Unternehmen hinzu, um Ihre Finanzen zu verwalten und Rechnungen zu erstellen.")
                        .padding(.horizontal)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                    Spacer()
                    Spacer()
                }
                .navigationTitle("Business")
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
                    BusinessFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Business")
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
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessView(viewModel: viewModel)
}
