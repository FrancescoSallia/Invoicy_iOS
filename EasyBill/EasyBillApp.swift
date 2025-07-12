//
//  EasyBillApp.swift
//  EasyBill
//
//  Created by Francesco Sallia on 07.07.25.
//

import SwiftUI

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
                                }
                            Tab("Settings", systemImage: "gearshape") {
                                    SettingsView()
                                }
                        }
                         .preferredColorScheme(.light) // <- globaler Theme Switch
                         .tint(.tabViewBackground)

//                        .onAppear {
//                            UITabBar.appearance().backgroundColor = UIColor.tabViewBackground
//                        }

        }
    }
}




//            TabView {
//
//                Tab("Home", systemImage: "house.fill") {
//                        HomeView()
//                    }
//                Tab("Clients", systemImage: "person.text.rectangle.fill") {
//                        ClientsView()
//                    }
//                Tab("Business", systemImage: "suitcase") {
//                        BusinessView()
//                    }
//                Tab("Settings", systemImage: "gearshape") {
//                        SettingsView()
//                    }
//            }
//            .onAppear {
//                UITabBar.appearance().backgroundColor = UIColor.tabViewBackground
//            }
