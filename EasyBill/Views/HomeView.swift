//
//  HomeView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//


import SwiftUI
import SwiftData

struct HomeView: View {

    @ObservedObject var viewModel: BillViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var invoices: [Invoice]
    
    @State private var selectedFilter: InvoiceFilter = .all

    var filteredInvoices: [Invoice] {
        switch selectedFilter {
        case .all:
            return invoices
        case .Open:
            return invoices.filter { $0.status == .Open }
        case .Paid:
            return invoices.filter { $0.status == .Paid }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if invoices.isEmpty {
                        VStack {
                            Spacer()

                            Image("bill_icon")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)

                            Text("Erstellen Sie ihre erste Rechnung")
                                .font(.title2)
                                .bold()
                                .padding(.bottom, 4)

                            Text("Beginnen Sie, Zahlungen zu verfolgen und ihr Geschäftseinkommen zu verwalten")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)

                            Spacer()
                        }
                        .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 0) {
                                Picker("InvoicePicker", selection: $selectedFilter) {
                                    Text("All").tag(InvoiceFilter.all)
                                    Text("Open").tag(InvoiceFilter.Open)
                                    Text("Paid").tag(InvoiceFilter.Paid)
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal)
                                ForEach(filteredInvoices, id: \.self) { invoice in
                                    NavigationLink {
//                                        InvoiceDetailView(viewModel: viewModel)
                                        PreviewScreen(invoice: invoice, viewModel: viewModel, pdfData: PDFHelper.generatePDF(from: invoice, with: viewModel))
                                    } label: {
                                        HStack(alignment: .top, spacing: 12) {
                                            Image(systemName: "doc.text.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .padding(16)
                                                .background(Color.gray.opacity(0.2))
                                                .clipShape(Circle())

                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack {
                                                    Text(invoice.invoiceName)
                                                        .font(.headline)
                                                    Spacer()
                                                    Text("\(viewModel.calculateTotal(invoice.items, discount: invoice.discount))")
                                                    Text(CurrencyEnum.symbol(from: invoice.currency))
                                                        .padding(.leading, -2)
                                                }
                                                Text("Erstellt: \(invoice.issuedOn.formatted())")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                                HStack {
                                                    Text("\(invoice.invoiceNumber)")
                                                    Spacer()
                                                    HStack {
                                                        Circle()
                                                            .fill(invoice.status == .Paid ? Color.green : Color.orange)
                                                            .scaledToFit()
                                                            .frame(width: 8)
                                                        Text("\(invoice.status)")
                                                            .tint(.secondary)
                                                    }
                                                }
                                                .padding(.trailing,4)
                                                .font(.callout)
                                            }

                                            Spacer()
                                        }
                                        .padding()
                                    }
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                            .padding(.bottom, 100) // Abstand zum Button unten
                        }
                    }
                }

                // ✅ Floating Action Button
                NavigationLink {
                    InvoiceFormView(viewModel: viewModel)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .bold()
                        Text("Add Invoice")
                            .bold()
                    }
                    .padding()
                    .background(Color.tabViewBackground)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 40)
            }
            .navigationTitle("Invoices")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                HStack {
                    Image(systemName: "gift.fill")
                    Button("Upgrade") {
                        // TODO: Upgrade Logic
                    }
                }
                .foregroundStyle(.white)
                .padding(6)
                .background(Color.yellow)
                .clipShape(.capsule)
            }
        }
    }
}

//#Preview {
//    @Previewable @State var viewModel: BillViewModel = BillViewModel()
//    HomeView(viewModel: viewModel)
//       
//}

#Preview {
    @Previewable @State var viewModel = BillViewModel()

    // 1. In-Memory Container erstellen
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Invoice.self,
            Business.self,
            Client.self,
            InvoiceItem.self,
        configurations: configuration
    )

    // 2. Beispiel-Daten einfügen
    let context = container.mainContext

    let business = Business(
        businessName: "Test GmbH",
        email: "info@test.de",
        phoneNumber: "01234 567890",
        street: "Hauptstraße",
        houseNumber: "1",
        postalCode: "12345",
        city: "Musterstadt",
        country: "Deutschland"
    )

    let client = Client(
        clientName: "Max Mustermann",
        email: "max@example.com",
        contactName: "Max Mustermann",
        phoneNumber: "09876 543210",
        street: "Nebenstraße",
        houseNumber: "2",
        postalCode: "54321",
        city: "Beispielstadt",
        country: "Deutschland"
    )

    let item1 = InvoiceItem(
        itemName: "Design Arbeit",
        itemDescription: "Logo & Branding",
        quantity: 5,
        unit: "Stunden",
        price: 80
    )

    let item2 = InvoiceItem(
        itemName: "Webentwicklung",
        itemDescription: "Landingpage",
        quantity: 1,
        unit: "Projekt",
        price: 1200
    )
    
    let status: InvoiceStatusEnum = .Open

    let invoice = Invoice(
        business: business,
        client: client,
        invoiceName: "Rechnung 001",
        invoiceNumber: "INV-001",
        currency: "EUR",
        issuedOn: Date(),
        dueDate: Date().addingTimeInterval(7*24*60*60),
        items: [item1, item2],
        discount: 0,
        tax: 19,
        totalSummery: 1600,
        status: status
    )

    context.insert(business)
    context.insert(client)
    context.insert(invoice)

    // 3. View mit Container zurückgeben
    return HomeView(viewModel: viewModel)
        .modelContainer(container)
}
