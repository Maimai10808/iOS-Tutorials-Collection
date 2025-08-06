//
//  Task.swift
//  ToDoList
//
//

import Foundation

struct Task: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let priority: Priority
    var isComplete: Bool
}
