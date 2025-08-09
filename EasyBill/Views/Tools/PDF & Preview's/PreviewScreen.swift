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
                                Text("Print")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
                        Button {
                            showDeleteAlert.toggle()
                        } label: {
                            VStack {
                                ButtonItemLabel(item: "trash.fill", color: .red)
                                Text("Delete")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
                        NavigationLink {
                            EditInvoiceView(viewModel: viewModel, invoice: invoice)
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
                            if invoice.status == .Open {
                                invoice.status = .Paid
                            } else {
                                invoice.status = .Open
                            }
                            try? context.save()
    //                        dismiss()
                            //TODO: diese button funktion testen und noch ein button erstellen um es auch wieder auf offen zu stellen die rechnung!
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
                                Text(invoice.status == .Paid ? "Open" : "Paid")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                        }
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
            .navigationTitle("Invoice-Preview")
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
