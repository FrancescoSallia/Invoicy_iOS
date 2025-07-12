//
//  SettingsView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Form {
                // Darstellung section placeholder
                Section(header: Text("Eisntellungen")) {
                    // Example setting
                    HStack {
                        Text("Theme")
                        Picker("Theme", selection: .constant("Light")) {
                            Text("System").tag("System")
                            Text("Light").tag("Light")
                            Text("Dark").tag("Dark")
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
