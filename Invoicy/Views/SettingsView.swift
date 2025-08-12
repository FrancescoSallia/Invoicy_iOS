//
//  SettingsView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel: BillViewModel

    var body: some View {
        NavigationStack {
            Form {
                // Darstellung section placeholder
                Section(header: Text("Eisntellungen")) {
                    // Example setting
                    HStack {
                        Text("Theme")
                        Picker("Theme", selection: $viewModel.selectedTheme) {
                            Text("System").tag(ColorSchemeEnum.system)
                            Text("Hell").tag(ColorSchemeEnum.light)
                            Text("Dunkel").tag(ColorSchemeEnum.dark)
                        }
                        .pickerStyle(.segmented)
                    }
                }

                Section(header: Text("Teilen & Feedback")) {
                    
                    Button("App bewerten") {
                        //TODO: App bewerten Logik
                    }
                    Button("App teilen") {
//                        viewModel.showShareSheet.toggle()
                    }

                }
                .foregroundStyle(.primary)

                Section(header: Text("Rechtl. Informationen")) {
                    NavigationLink("Datenschutz", destination: PrivacyPolicyView())
                    NavigationLink("Nutzungsbedingungen", destination: TermsOfServiceView())
                }
            }
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
        }
        //TODO: App Store link statt pdf einfügen um die app zu teilen und nicht das ganze dokument!
        
//        .sheet(isPresented: $viewModel.showShareSheet) {
//            ShareView(activityItems: [pdfData])
//                .presentationDetents([.medium, .large])
//        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    SettingsView(viewModel: viewModel)
}
