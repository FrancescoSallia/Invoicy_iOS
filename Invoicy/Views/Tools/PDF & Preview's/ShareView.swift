//
//  ShareView.swift
//  Invoicy
//
//  Created by Francesco Sallia on 11.08.25.
//

import SwiftUI
import UIKit

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = { _, _, _, _ in
            presentationMode.wrappedValue.dismiss()
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
