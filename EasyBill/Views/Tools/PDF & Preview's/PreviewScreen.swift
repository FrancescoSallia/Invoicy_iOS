//
//  PreviewScreen.swift
//  EasyBill
//
//  Created by Francesco Sallia on 30.07.25.
//

import SwiftUI

struct PreviewScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    let invoice: Invoice
    let viewModel: BillViewModel
    let pdfData: Data

    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
//        let pdfData = PDFHelper.generatePDF(from: invoice, with: viewModel)
        VStack {
            PDFPreviewView(pdfData: pdfData)
                .edgesIgnoringSafeArea(.all)
                .padding(.top, 40)
            
            ScrollView(.horizontal) {
                HStack {
                    Button {
                        PDFHelper.printPDF(data: pdfData)
                    } label: {
                        ButtonItemLabel(item: "printer.fill")
                    }
                    Button {
                        showDeleteAlert.toggle()
                    } label: {
                        ButtonItemLabel(item: "trash.fill", color: .red)
                    }
                    NavigationLink {
                        EditInvoiceView(viewModel: viewModel, invoice: invoice)
                    } label: {
                        ButtonItemLabel(item: "pencil.and.scribble")
                    }
                    .tint(.primary)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .alert("Delete?", isPresented: $showDeleteAlert) {
            Button("Löschen", role: .destructive) {
                context.delete(invoice)
                try? context.save()
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to delete this Invoice?")
        }
    }
}


#Preview {
    let viewModel: BillViewModel = BillViewModel()
//    Spacer()

    let pdfData = PDFHelper.generatePDF(from: .previewInvoice, with: viewModel)
    PDFPreviewView(pdfData: pdfData)
        .edgesIgnoringSafeArea(.all)
    
    ScrollView(.horizontal) {
        Group {
            HStack {
                Button {
                    PDFHelper.printPDF(data: pdfData)
                } label: {
                    ButtonItemLabel(item: "printer.fill")
                }
                
                Button {
                    //LOGIK
                } label: {
                    ButtonItemLabel(item: "trash.fill", color: .red)
                }
                Button {
                    //LOGIK Einbauen
                } label: {
                    ButtonItemLabel(item: "pencil.and.scribble")
                }
                .tint(.primary)
            }
            .padding(.horizontal)
        }
    }
//    Spacer()
}


struct ButtonItemLabel: View {
    let item: String
    var color: Color = .primary
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundStyle(.thinMaterial)
            Image(systemName: item)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .tint(color)
        }
    }
}
