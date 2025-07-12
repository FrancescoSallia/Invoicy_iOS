//
//  CustomerView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct ClientsView: View {
    
    @ObservedObject var viewModel: BillViewModel

    var body: some View {
        NavigationStack {
            Divider()
                .padding(.top, 4)
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .center) {
                    Spacer()
                    Image("customer_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                    
                    Text("Fügen Sie ihren ersten Kunden hinzu")
                        .font(.title2)
                        .padding(.bottom, 4)
                        .bold()
                    
                    Text("Beginnen Sie, Ihre Kundenbasis aufzubauen und erstellen Sie in wenigen Minuten professionelle Rechnungen.")
                        .padding(.horizontal)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                    Spacer()
                    Spacer()
                }
            
            .navigationBarTitle("Client's")
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
                    ClientFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Client")
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
    ClientsView(viewModel: viewModel)
}


//                Button {
//                    //TODO: Logic
//                } label: {
//                    HStack {
//                        Image(systemName: "plus")
//                            .bold()
//                        Text("Add Client")
//                            .bold()
//                    }
//                    .padding(4)
//                }
//                .buttonStyle(.borderedProminent)
//                .clipShape(RoundedRectangle(cornerRadius: 40))
//                .padding()
//                .padding(.bottom)
//                .shadow(radius: 8)
