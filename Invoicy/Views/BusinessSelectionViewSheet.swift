//
//  BusinessSelectionViewSheet.swift
//  EasyBill
//
//  Created by Francesco Sallia on 17.07.25.
//

import SwiftUI
import SwiftData

struct BusinessSelectionViewSheet: View {
    
    @ObservedObject var viewModel: BillViewModel
//    @Query private var businesses: [Business]
    @Query(filter: #Predicate<Business> { !$0.isArchived })
    private var businesses: [Business]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            
            if businesses.isEmpty {
                VStack {
                    Spacer()
                    Text("no_businesses_create_first")
                        .bold()
                        .padding()
                    NavigationLink {
                        BusinessFormView(viewModel: viewModel)
                    } label: {
                        Text("create_new_company")
                            .padding()
                    }
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack {
                        ForEach(businesses, id: \.email) { business in
                            VStack {
                                Button {
                                    viewModel.selectedBusinessFromSheet = business.email
                                    viewModel.businessItemSelected = business
                                    dismiss()
                                } label: {
                                    HStack {
                                        VStack {
                                            Image(systemName: viewModel.selectedBusinessFromSheet == business.email ? "largecircle.fill.circle" : "circle")
                                        }
                                    }
                                    .padding(.horizontal)
                                    VStack(alignment: .leading) {
                                        Text(business.businessName)
                                        Text(business.phoneNumber)
                                        Text("\(business.street) \(business.houseNumber), \(business.postalCode) \(business.city)")
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
                    .navigationTitle("title_select_business")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("cancel_") {
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
    BusinessSelectionViewSheet(viewModel: viewModel)
}
