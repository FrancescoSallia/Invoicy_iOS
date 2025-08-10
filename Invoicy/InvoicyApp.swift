//
//  EasyBillApp.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import SwiftUI
import SwiftData

@main
struct InvoicyApp: App {
    
    @StateObject var viewModel: BillViewModel = BillViewModel()
    @StateObject var errorHandler = ErrorHandler.shared
    
    var body: some Scene {
        WindowGroup {
//            CustomTabView()
//                .preferredColorScheme(.light) // <- globaler Theme Switch
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    HomeView(viewModel: viewModel)
                        .modelContainer(for: [Invoice.self, Business.self , Client.self])
                }
                Tab("Clients", systemImage: "person.text.rectangle.fill") {
                    ClientsView(viewModel: viewModel)
                        .modelContainer(for: [Client.self])
                }
                Tab("Business", systemImage: "suitcase") {
                    BusinessView(viewModel: viewModel)
                        .modelContainer(for: [Business.self])
                }
                Tab("Settings", systemImage: "gearshape") {
                    SettingsView(viewModel: viewModel)
                }
            }
            .preferredColorScheme(viewModel.selectedTheme.colorScheme) // <- globaler Theme Switch
            .tint(.primaryApp)
        }
    }
}
