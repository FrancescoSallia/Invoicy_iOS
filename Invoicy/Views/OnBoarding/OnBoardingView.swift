//
//  OnBoardingView.swift
//  Invoicy
//
//  Created by Francesco Sallia on 30.08.25.
//

import SwiftUI

struct OnBoardingView: View {
    
    @State private var currentPage = 0
    var onFinished: () -> Void
    
    var body: some View {
        VStack {
            VStack {
                TabView(selection: $currentPage) {
                    // Erste Seite
                    OnBoardingPageView(
                        title: NSLocalizedString("onboarding_welcome_title", comment: ""),
                        subTitle: NSLocalizedString("onboarding_welcome_subtitle", comment: ""),
                        points: [
                            NSLocalizedString("onboarding_welcome_point_1", comment: ""),
                            NSLocalizedString("onboarding_welcome_point_2", comment: ""),
                            NSLocalizedString("onboarding_welcome_point_3", comment: ""),
                            NSLocalizedString("onboarding_welcome_point_4", comment: "")
                        ],
                        description: NSLocalizedString("onboarding_welcome_description", comment: "")
                    )
                    .tag(0)
                    
                    // Zweite Seite
                    OnBoardingPageView(
                        title: NSLocalizedString("onboarding_invoice_title", comment: ""),
                        subTitle: NSLocalizedString("onboarding_invoice_subtitle", comment: ""),
                        points: [
                            NSLocalizedString("onboarding_invoice_point_1", comment: ""),
                            NSLocalizedString("onboarding_invoice_point_2", comment: ""),
                            NSLocalizedString("onboarding_invoice_point_3", comment: "")
                        ],
                        description: NSLocalizedString("onboarding_invoice_description", comment: "")
                    )
                    .tag(1)
                    
                    // Dritte Seite
                    OnBoardingPageView(
                        title: NSLocalizedString("onboarding_customer_title", comment: ""),
                        subTitle: NSLocalizedString("onboarding_customer_subtitle", comment: ""),
                        points: [
                            NSLocalizedString("onboarding_customer_point_1", comment: ""),
                            NSLocalizedString("onboarding_customer_point_2", comment: ""),
                            NSLocalizedString("onboarding_customer_point_3", comment: ""),
                            NSLocalizedString("onboarding_customer_point_4", comment: "")
                        ],
                        description: NSLocalizedString("onboarding_customer_description", comment: "")
                    )
                    .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                Spacer()
            }
            
            // Button nur auf der letzten Seite
            if currentPage == 2 {
                Button(NSLocalizedString("onboarding_start_button", comment: "")) {
                   onFinished()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
}

//#Preview {
//    OnBoardingView(onFinished: () -> Void)
//}
