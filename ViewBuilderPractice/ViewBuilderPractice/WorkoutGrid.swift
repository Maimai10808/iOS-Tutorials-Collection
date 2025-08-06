//
//  WorkoutGrid.swift
//  ViewBuilderPractice
//
//  Created by mac on 8/4/25.
//

import Foundation
import SwiftUI

struct WorkoutGrid<Content: View>: View {
    
    @ViewBuilder var content: () -> Content
    
    let columns = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2), alignment: .leading),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            content()
        }
        
    }
    
}
