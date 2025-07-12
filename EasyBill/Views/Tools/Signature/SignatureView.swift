//
//  SignaturView.swift
//  EasyBill
//
//  Created by Francesco Sallia on 12.07.25.
//

import Foundation
import SwiftUICore
import SwiftUI

struct SignatureView: View {
    @Binding var drawing: Drawing
    var body: some View {
        HStack {
            Button("Löschen") {
//                NotificationCenter.default.post(name: .clearSignature, object: nil)
            }
            .tint(.red)
            Spacer()
            Text("Signatur")
                .bold()
            Spacer()
            Button("Speichern") {

            }
            .buttonStyle(.borderless)
        }
        .padding()
        .padding(.top, 20)
        VStack {
            ZStack {
                Rectangle()
                    .strokeBorder(Color.gray, lineWidth: 4)
                    .background(Color.white)
                    .frame(height: 200)
                    .padding(.horizontal)
                SignatureCanvas(drawing: $drawing)
                    .frame(height: 200)
            }
            .padding(.vertical)
            
            Text("Hier unterschreiben")
                .padding(.bottom)
            
           
            Spacer()
        }
    }
}

//#Preview {
//    SignatureView()
//}
