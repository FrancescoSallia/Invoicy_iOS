//
//  SettingsView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedTheme: ColorSchemeEnum = .system
    var body: some View {
        NavigationStack {
            Form {
                // Darstellung section placeholder
                Section(header: Text("Eisntellungen")) {
                    // Example setting
                    HStack {
                        Text("Theme")
                        Picker("Theme", selection: $selectedTheme) {
                            Text("System").tag(ColorSchemeEnum.system)
                            Text("Light").tag(ColorSchemeEnum.light)
                            Text("Dark").tag(ColorSchemeEnum.dark)
                        }
                        .pickerStyle(.segmented)
                    }
                }

                Section(header: Text("Teilen & Feedback")) {
                    
                    Button("App bewerten") {
                        //TODO: App bewerten Logik
                    }
                    Button("App teilen") {
                       //TODO: App Teilen Logic
                    }

                }
                .foregroundStyle(.primary)

                Section(header: Text("Rechtl. Informationen")) {
                    NavigationLink("Datenschutz", destination: Text("Datenschutz Inhalt"))
                    NavigationLink("Nutzungsbedingungen", destination: Text("Nutzungsbedingungen Inhalt"))
                }
            }
            .navigationTitle("Einstellungen")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
