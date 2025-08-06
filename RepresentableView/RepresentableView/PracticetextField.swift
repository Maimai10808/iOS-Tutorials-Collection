//
//  PracticetextField.swift
//  RepresentableView
//
//  Created by mac on 8/3/25.
//

import Foundation
import SwiftUI

struct PracticetextField: UIViewRepresentable {
    
    @Binding var value: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .line
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = value
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(value: $value)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var value: String
        
        init(value: Binding<String>) {
            self._value = value
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersInRanges ranges: [NSValue], replacementString string: String) -> Bool {
            if string.isEmpty {
                return true
            }
            
            if Int(string) != nil {
                value = textField.text ?? ""
                return true
            }
            return false

        }
    }

    
    
}


