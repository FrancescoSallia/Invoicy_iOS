//
//  PrivacyPolicyView.swift
//  Invoicy
//
//  Created by Francesco Sallia on 11.08.25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Privacy Policy")
                    .font(.title)
                    .bold()
                
                Text("""
We take the protection of your personal data very seriously. 
This app stores all entered data exclusively locally on your device. No data is transmitted, stored, or shared with us or any third parties.
""")
                
                Group {
                    Text("What data is stored?")
                        .font(.headline)
                    Text("""
- Your invoice data, customer and business information, and any other inputs within the app.
""")
                }
                
                Group {
                    Text("How is the data used?")
                        .font(.headline)
                    Text("""
- The data is used solely for the app’s functionality and remains on your device.
""")
                }
                
                Group {
                    Text("Is data shared?")
                        .font(.headline)
                    Text("- No. Your data never leaves your device and is not shared with anyone.")
                }
                
                Group {
                    Text("Tracking and Analytics")
                        .font(.headline)
                    Text("- This app does **not** use any tracking or analytics services.")
                }
                
                Group {
                    Text("Your rights")
                        .font(.headline)
                    Text("""
You have the right to access, correct, or delete any data stored on your device through the app.  
Since the data is only stored locally, we do not have access to it.
""")
                }
                
                Group {
                    Text("Contact")
                        .font(.headline)
                    Text("""
If you have any questions about privacy, you can contact us at:  
**francesco.developer@hotmail.com**


""")
                }
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
