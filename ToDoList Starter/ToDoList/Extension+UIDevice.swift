//
//  Extension+UIDevice.swift
//  ToDoList
//
//  Created by mac on 7/28/25.
//

import Foundation
import SwiftUI

#if os(iOS)
extension UIDevice {
    
    static var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    
}
#endif
