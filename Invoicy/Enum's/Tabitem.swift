//
//  Tabitem.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
enum TabItem: String, CaseIterable {
    case home = "Home"
    case clients = "Clients"
    case business = "Business"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .clients: return "person.text.rectangle.fill"
        case .business: return "suitcase"
        case .settings: return "gearshape"
        }
    }
}
