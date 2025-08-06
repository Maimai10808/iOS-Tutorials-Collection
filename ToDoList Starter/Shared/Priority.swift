//
//  Priority.swift
//  ToDoList
//
//

import Foundation
import SwiftUI

enum Priority: String, Identifiable, CaseIterable {
    
    var id: Self { self }
    
    case urgent, normal, optional
    
    var title: String {
        switch self {
        case .urgent:
            return "Urgent"
        case .normal:
            return "Normal"
        case .optional:
            return "Optional"
        }
    }
    
    var color: Color {
        switch self {
        case .urgent:
            return Color.red
        case .normal:
            return Color.blue
        case .optional:
            return Color.green
        }
    }
    
}
