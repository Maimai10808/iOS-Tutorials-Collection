//
//  TasksView.swift
//  ToDoList
//

import SwiftUI

struct TasksView: View {
    
    @State var tasks: [Task] = []
    @State var addTasks = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($tasks) { $task in
                        NavigationLink {
                            TaskDetailView(task: $task)
                        } label: {
                            HStack {
                                Image(systemName: task.isComplete ? "checkmark.circle" : "circle")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black)
                                Text(task.title)
                                    .font(.system(size: 16))
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(task.priority.title)
                                    .font(.system(size: 15, weight: .bold))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 5)
                                    .foregroundStyle(task.priority.color)
                                    .background(Capsule().fill(task.priority.color.opacity(0.4)))
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Tasks")
            .sheet(isPresented: $addTasks, content: {
                AddTaskView(tasks: $tasks)
            })
            .toolbar {
                
                #if os(iOS)
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addTasks = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.black)
                    })
                }
                #elseif os(macOS)
                ToolbarItem {
                    Button(action: {
                        addTasks = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.black)
                    })
                }
                
                #endif
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
}

#Preview {
    TasksView()
}
