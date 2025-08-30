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
    
    // State, ob Onboarding angezeigt wird
    @State private var showOnBoarding: Bool = !UserDefaults.standard.bool(forKey: "onBoardingCompleted")
    
    var body: some Scene {
        WindowGroup {
            if showOnBoarding {
                // Onboarding anzeigen
                OnBoardingView {
                    // Closure wird aufgerufen, wenn Onboarding fertig ist
                    showOnBoarding = false
                    UserDefaults.standard.set(true, forKey: "onBoardingCompleted")
                }
            } else {
                
                TabView {
                    Tab("Invoicy", systemImage: "doc.text.fill") {
                        HomeView(viewModel: viewModel)
                            .modelContainer(for: [Invoice.self, Business.self , Client.self])
                    }
                    Tab("Kunden", systemImage: "person.text.rectangle.fill") {
                        ClientsView(viewModel: viewModel)
                            .modelContainer(for: [Client.self])
                    }
                    Tab("Unternehmen", systemImage: "suitcase") {
                        BusinessView(viewModel: viewModel)
                            .modelContainer(for: [Business.self])
                    }
                    Tab("Einstellungen", systemImage: "gearshape") {
                        SettingsView(viewModel: viewModel)
                    }
                }
                .preferredColorScheme(viewModel.selectedTheme.colorScheme) // <- globaler Theme Switch
                .tint(.primaryApp)
            }
        }
    }
}
