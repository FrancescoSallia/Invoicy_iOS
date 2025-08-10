////
////  ImagePicker.swift
////  EasyBill
////
////  Created by Francesco Sallia on 12.07.25.
////
//
//import Foundation
//import SwiftUI
//import PhotosUI
//
//@MainActor
//struct ImagePicker: UIViewControllerRepresentable {
//    @ObservedObject var viewModel: BillViewModel
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//        let parent: ImagePicker
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//            picker.dismiss(animated: true)
//            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
//                return
//            }
//
//            provider.loadObject(ofClass: UIImage.self) { object, _ in
//                if let image = object as? UIImage {
//                    DispatchQueue.main.async {
//                        self.parent.viewModel.logoImage = image
//                    }
//                }
//            }
//        }
//    }
//}
