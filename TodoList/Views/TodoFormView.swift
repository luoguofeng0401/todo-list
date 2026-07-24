//
//  TodoFormView.swift
//  TodoList
//
//  Created by Guofeng Luo on 2026/7/24.
//

import SwiftUI

/// A form used both for creating a new todo and editing an existing one.
struct TodoFormView: View {
    @Environment(\.dismiss) private var dismiss

    let viewModel: TodoListViewModel
    /// The todo being edited, or `nil` when creating a new one.
    let todo: TodoItem?

    @State private var title: String

    private var isEditing: Bool { todo != nil }

    init(viewModel: TodoListViewModel, todo: TodoItem?) {
        self.viewModel = viewModel
        self.todo = todo
        _title = State(initialValue: todo?.title ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
            }
            .navigationTitle(isEditing ? "Edit Todo" : "New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(trimmedTitle.isEmpty)
                }
            }
        }
    }

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func save() {
        if let todo {
            viewModel.updateTodo(todo, title: trimmedTitle)
        } else {
            viewModel.addTodo(title: trimmedTitle)
        }
        dismiss()
    }
}
