//
//  TodoRowView.swift
//  Homework7
//
//  Created by Guofeng Luo on 2026/7/30.
//

import SwiftUI

/// A single row in the todo list: a completion toggle plus the todo's title.
/// Tapping the title triggers editing.
struct TodoRowView: View {
    let todo: TodoItem
    let onToggle: () -> Void
    let onEdit: () -> Void

    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isCompleted ? .green : .secondary)
            }
            .buttonStyle(.plain)

            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundStyle(todo.isCompleted ? .secondary : .primary)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onEdit)
    }
}
