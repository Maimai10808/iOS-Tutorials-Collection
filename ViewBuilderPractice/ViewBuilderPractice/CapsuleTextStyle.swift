//
//  CapsuleTextStyle.swift
//  ViewBuilderPractice
//
//  Created by mac on 8/4/25.
//

import Foundation
import SwiftUI

struct CapsuleTextStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.system(size: 15, weight: .semibold))
            .padding()
            .background(Capsule().fill(.gray))
    }
    
}


extension View {
    
    func capsuleTextStyle() -> some View {
        modifier(CapsuleTextStyle())
    }
    
}
