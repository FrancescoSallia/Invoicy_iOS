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
    @ObservedObject var errorHandler = ErrorHandler.shared

    let invoice: Invoice
    @ObservedObject var viewModel: BillViewModel
    let pdfData: Data
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                PDFPreviewView(pdfData: pdfData)
                    .edgesIgnoringSafeArea(.all)
                    .padding(.top, 40)
                
                ScrollView(.horizontal) {
                    HStack {
                        Button {
                            PDFHelper.printPDF(data: pdfData)
                        } label: {
                            VStack {
                                ButtonItemLabel(item: "printer.fill")
                                Text("print_")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
                        NavigationLink {
                            EditInvoiceView(viewModel: viewModel, invoice: invoice)
                        } label: {
                            VStack {
                                ButtonItemLabel(item: "pencil.and.scribble")
                                Text("edit_")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
                        .tint(.primary)
                        Button {
                            if invoice.status == .Open {
                                invoice.status = .Paid
                            } else {
                                invoice.status = .Open
                            }
                            try? context.save()
                        } label: {
                            VStack {
                                ZStack {
                                    Circle()
                                        .frame(width: 54, height: 54)
                                        .foregroundStyle(invoice.status == .Paid ? Color.orange.opacity(0.12) : Color.green.opacity(0.12))
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .tint(invoice.status == .Paid ? Color.orange : Color.green)
                                }
                                Text(invoice.status == .Paid ? "invoice_filter_open" : "invoice_filter_paid")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        } 
                        Button {
                            viewModel.showShareSheet.toggle()
                        } label: {
                            VStack{
                                ButtonItemLabel(item: "square.and.arrow.up", color: .primary)
                                Text("share_")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
                        Button {
                            showDeleteAlert.toggle()
                        } label: {
                            VStack {
                                ButtonItemLabel(item: "trash.fill", color: .red)
                                Text("delete_")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .alert(item: $errorHandler.currentError) { appError in
                    Alert(
                        title: Text(appError.title),
                        message: Text(appError.errorDescription ?? ""),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .alert("delete_question", isPresented: $showDeleteAlert) {
                Button("delete_", role: .destructive) {
                    context.delete(invoice)
                    try? context.save()
                    dismiss()
                }
                Button("cancel_", role: .cancel) { }
            } message: {
                Text("sure_delete_question")
            }
            .sheet(isPresented: $viewModel.showShareSheet) {
                ShareView(activityItems: [pdfData])
                    .presentationDetents([.medium, .large])
            }
            .navigationTitle("invoice_preview_title")
            .navigationBarTitleDisplayMode(.inline)
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
                    VStack {
                        ButtonItemLabel(item: "printer.fill")
                        Text("Print")
                            .font(.footnote)
                            .tint(.primary)
                    }
                }
                
                Button {
                    //LOGIK
                } label: {
                    VStack {
                        ButtonItemLabel(item: "trash.fill", color: .red)
                        Text("Delete")
                            .font(.footnote)
                            .tint(.primary)
                    }
                }
                Button {
                    //LOGIK Einbauen
                } label: {
                    VStack {
                        ButtonItemLabel(item: "pencil.and.scribble")
                        Text("Edit")
                            .font(.footnote)
                            .tint(.primary)
                    }
                }
                .tint(.primary)
                Button {
                    //LOGIK
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 54, height: 54)
                                .foregroundStyle(.green.opacity(0.12))
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .tint(.green)
                        }
                        Text("Complete")
                            .font(.footnote)
                            .tint(.primary)
                    }
                    Button {
                        //Logik
                    } label: {
                        VStack{
                            ButtonItemLabel(item: "square.and.arrow.up", color: .primary)
                            Text("Share")
                                .font(.footnote)
                                .tint(.primary)
                        }
                    }
                }
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
                .frame(width: 54, height: 54)
                .foregroundStyle(.thinMaterial)
            Image(systemName: item)
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
                .tint(color)
        }
    }
}
