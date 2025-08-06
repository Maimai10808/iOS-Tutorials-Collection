//
//  TaskRow.swift
//  TaskManager
//
//  Created by mac on 3/17/25.
//

import SwiftUI

struct TaskRow: View {
    
    @ObservedObject var task: CDTask
    
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "largecircle.fill.circle" : "circle")
                .onTapGesture {
                    task.isCompleted.toggle()
                }
            
            TextField("New Task", text: $task.title)
                .textFieldStyle(.plain)
            
            Button(action: {
                inspectorIsShown = true
                selectedTask = task
            }, label: {
                Text("More")
            })
        }
        
        
        
    }
}







