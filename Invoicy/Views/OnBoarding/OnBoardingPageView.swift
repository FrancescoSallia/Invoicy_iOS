//
//  OnBoardingPageView.swift
//  Invoicy
//
//  Created by Francesco Sallia on 30.08.25.
//

import SwiftUI

struct OnBoardingPageView: View {
    
    let title: String
    let subTitle: String
    let points: [String]
    let description: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(title)
            .font(.title)
            .multilineTextAlignment(.leading)
            .padding()
            .foregroundStyle(.primaryApp)
            
            
            Text(subTitle)
            .font(.title3)
            .multilineTextAlignment(.leading)
            .padding()
            
            ForEach(points, id: \.self) { point in
                
                HStack {
                 Text("•")
                        .font(.title)
                    Text(point)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 0.5)
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.horizontal)
            }
            .foregroundStyle(.secondary)
            
            Text(description)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
            .padding()
            .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
}

#Preview {
    OnBoardingPageView(
        title: "Willkommen bei Invoicy 👋",
        subTitle: "Ihre einfache Lösung für professionelle Rechnungen:",
        points: [
            "Erstellen Sie Rechnungen in Sekunden",
            "100% kostenlos und ohne Abo",
            "Verwalten Sie Ihr Business effizient an einem Ort",
            "Bleiben Sie immer auf dem Laufenden über Zahlungen"
        ],
        description: "Starten Sie jetzt und konzentrieren Sie sich auf das, was wirklich zählt – Ihr Business!"
    )
}

#Preview {
    OnBoardingPageView(
        title:"Optimieren Sie Ihre Rechnungsstellung",
        subTitle: "Steigern Sie Ihre Produktivität mit unseren benutzerfreundlichen Tools:",
        points: ["Zugriff auf alle Funktionen über ein intuitives Dashboard",
                 "Erstellen und versenden Sie schnell professionelle Rechnungen unterwegs",
                 "Verwalten Sie mehrere Unternehmen von einer einzigen Plattform aus"
                ],
        description: "Vereinfachen Sie Ihr Rechnungsmanagement und konzentrieren Sie sich auf das Wachstum Ihres Unternehmens!")
}

#Preview {
    OnBoardingPageView(
        title: "Mühelose Kundenverwaltung",
        subTitle: "Bauen Sie mühelos stärkere Beziehungen auf:",
        points: [
            "Führen Sie eine umfassende Kundendatenbank",
            "Schneller Zugriff und Aktualisierung von Kundendaten",
            "Passen Sie Rechnungen für jeden Kunden an",
            "Zahlungsverlauf und ausstehende Salden verfolgen"
        ],
        description: "Verpassen Sie nie einen Takt in Ihrer Kundenkommunikation!"
    )
}

#Preview {
    OnBoardingPageView(
        title: "onboarding_customer_title",
        subTitle: "onboarding_customer_subtitle",
        points: [
            "onboarding_customer_point_1",
            "onboarding_customer_point_2",
            "onboarding_customer_point_3",
            "onboarding_customer_point_4"
        ],
        description: "onboarding_customer_description"
    )
}
