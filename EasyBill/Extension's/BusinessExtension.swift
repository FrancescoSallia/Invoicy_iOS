//
//  BusinessExtension.swift
//  EasyBill
//
//  Created by Francesco Sallia on 13.07.25.
//

import Foundation
import UIKit

extension Business {
    var logoImg: UIImage? {
        get {
            guard let data = logoImgData else { return nil }
            return UIImage(data: data)
        }
        set {
            logoImgData = newValue?.pngData()
        }
    }
    
    var signatureImg: UIImage? {
        get {
            guard let data = signatureImgData else { return nil }
            return UIImage(data: data)
        }
        set {
            signatureImgData = newValue?.pngData()
        }
    }
}
