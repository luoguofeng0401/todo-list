//
//  TodoListView.swift
//  TodoList
//
//  Created by Guofeng Luo on 2026/7/24.
//

import SwiftUI
import SwiftData

/// The main screen showing the list of todos with support for creating,
/// editing, completing and deleting items.
struct TodoListView: View {
    @State private var viewModel: TodoListViewModel

    /// Controls presentation of the add/edit form.
    @State private var isPresentingForm = false
    /// The todo currently being edited, or `nil` when creating a new one.
    @State private var editingTodo: TodoItem?

    init(modelContext: ModelContext) {
        _viewModel = State(initialValue: TodoListViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.todos.isEmpty {
                    ContentUnavailableView(
                        "No Todos",
                        systemImage: "checklist",
                        description: Text("Tap the + button to add your first todo.")
                    )
                } else {
                    todoList
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        editingTodo = nil
                        isPresentingForm = true
                    } label: {
                        Label("Add Todo", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingForm) {
                TodoFormView(viewModel: viewModel, todo: editingTodo)
            }
        }
    }

    private var todoList: some View {
        List {
            ForEach(viewModel.todos) { todo in
                TodoRowView(todo: todo) {
                    viewModel.toggleCompletion(todo)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    editingTodo = todo
                    isPresentingForm = true
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.deleteTodo(todo)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
    }
}

/// A single row displaying a todo with a tappable completion indicator.
private struct TodoRowView: View {
    let todo: TodoItem
    let onToggle: () -> Void

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
        }
    }
}
