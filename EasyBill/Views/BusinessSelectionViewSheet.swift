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
    @Query private var businesses: [Business]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if businesses.isEmpty {
            Text("No businesses yet. Create one first.")
        } else {
            ForEach(businesses, id: \.email) { business in
                VStack {
                    Button {
                        viewModel.selectedBusiness = business.email
                        dismiss()
                    } label: {
                        HStack {
                            VStack {
                                Image(systemName: viewModel.selectedBusiness == business.email ? "largecircle.fill.circle" : "circle")
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
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    BusinessSelectionViewSheet(viewModel: viewModel)
}
