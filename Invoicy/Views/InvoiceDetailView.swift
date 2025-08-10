//
//  InvoiceDetailView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 28.07.25.
//

import SwiftUI
import SwiftData

struct InvoiceDetailView: View {
    
    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    InvoiceDetailView(viewModel: viewModel)
}
