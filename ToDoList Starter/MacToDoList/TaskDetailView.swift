//
//  TaskDetailView.swift
//  MacToDoList
//
//  Created by mac on 7/28/25.
//

import SwiftUI

struct TaskDetailView: View {
    @Binding var task: Task
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(task.title)
                    .font(.system(size: 26, weight: .bold))
                Spacer()
            }
            .padding(.bottom, 15)
            Button(action: {
                task.isComplete.toggle()
                dismiss()
            }, label: {
                Text(task.isComplete ? "Mark Not Done" : "Mark Done")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            })
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    TaskDetailView(task: .constant(Task(title: "Test", priority: .urgent, isComplete: false)))
}

