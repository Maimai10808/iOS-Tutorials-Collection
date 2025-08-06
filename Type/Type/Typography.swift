//
//  Typography.swift
//  Type
//
//  Created by mac on 7/9/25.
//

import Foundation
import UIKit

enum FontType: String {
    
    case robotoRegular = "Roboto-Regular"
    case robotoMedium = "Roboto-Medium"
    case robotoItalic = "Roboto-Italic"
}

extension FontType {
    var name: String {
        return self.rawValue
    }
}

enum FontSize {
    
    case custom(Double)
}

extension FontSize {
    
    var value: Double {
        switch self {
        case .custom(let customSize):
            return customSize
        }
    }
}
