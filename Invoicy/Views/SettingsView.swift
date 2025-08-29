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
                Section(header: Text("settings_title")) {
                    // Example setting
                    HStack {
                        Text("Theme")
                        Picker("Theme", selection: $viewModel.selectedTheme) {
                            Text("System").tag(ColorSchemeEnum.system)
                            Text("light_scheme").tag(ColorSchemeEnum.light)
                            Text("dark_scheme").tag(ColorSchemeEnum.dark)
                        }
                        .pickerStyle(.segmented)
                    }
                }

                Section(header: Text("share_and_feedback")) {
                    
                    Button("rate_the_app") {
                        if let url = URL(string: "https://apps.apple.com/app/id6751598755?action=write-review") {
                                UIApplication.shared.open(url)
                            }
                    }
                    Button("share_the_app") {
                        viewModel.showShareSheet.toggle()
                    }

                }
                .foregroundStyle(.primary)

                Section(header: Text("legal_information")) {
                    NavigationLink("privacy_policy", destination: PrivacyPolicyView())
                    NavigationLink("terms_of_use", destination: TermsOfServiceView())
                }
            }
            .navigationTitle("settings_title")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareView(activityItems: [URL(string: "https://apps.apple.com/de/app/invoicy/id6751598755")!])
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    @Previewable @State var viewModel: BillViewModel = BillViewModel()
    SettingsView(viewModel: viewModel)
}
