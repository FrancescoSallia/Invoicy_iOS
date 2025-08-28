//
//  TermsOfServiceView.swift
//  Invoicy
//
//  Created by Francesco Sallia on 11.08.25.
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Terms of Service")
                    .font(.title)
                    .bold()
                
                Group {
                    Text("1. Scope")
                        .font(.headline)
                    Text("These terms apply to all users of the Invoicy app.")
                }
                
                Group {
                    Text("2. Description of Service")
                        .font(.headline)
                    Text("Invoicy provides features for managing invoices, customer, and business data. We do not guarantee the app is free of errors.")
                }
                
                Group {
                    Text("3. User Obligations")
                        .font(.headline)
                    Text("You agree not to use the app for unlawful purposes or to infringe on the rights of others.")
                }
                
                Group {
                    Text("4. Limitation of Liability")
                        .font(.headline)
                    Text("""
We are not liable for any damages arising from the use of the app, including data loss.  
We also do not guarantee the availability of the app at all times.  
Furthermore, we exclude liability for consequential damages resulting from the use of the app.
""")
                }
                
                Group {
                    Text("5. Intellectual Property")
                        .font(.headline)
                    Text("All rights to the app and its contents belong to us.")
                }
                
                Group {
                    Text("6. Termination")
                        .font(.headline)
                    Text("We reserve the right to restrict or terminate access to the app in case of violations, where technically feasible.")
                }
                
                Group {
                    Text("7. Changes to Terms")
                        .font(.headline)
                    Text("We may change these terms at any time. Changes will be communicated in advance.")
                }
                
                Group {
                    Text("8. No Contractual Relationship")
                        .font(.headline)
                    Text("Use of the app does not create any contractual relationship between you and us, including purchase or subscription agreements.")
                }
                
                Group {
                    Text("9. Governing Law")
                        .font(.headline)
                    Text("These terms are governed by German law. The place of jurisdiction is Berlin.")
                }
                
                Group {
                    Text("Contact")
                        .font(.headline)
                    Text("""
If you have any questions about these terms, please contact us at:  
**invoicy@outlook.com**


""")
                }
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
    }
}

#Preview {
    NavigationStack {
        TermsOfServiceView()
    }
}
