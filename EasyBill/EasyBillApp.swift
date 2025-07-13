//
//  EasyBillApp.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import SwiftUI
import SwiftData

@main
struct EasyBillApp: App {
    
    @StateObject var viewModel: BillViewModel = BillViewModel()
    
    var body: some Scene {
        WindowGroup {
//            CustomTabView()
//                .preferredColorScheme(.light) // <- globaler Theme Switch
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    HomeView()
                }
                Tab("Clients", systemImage: "person.text.rectangle.fill") {
                    ClientsView(viewModel: viewModel)
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
            .tint(.tabViewBackground)
        }
    }
}
